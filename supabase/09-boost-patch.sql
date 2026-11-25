-- MStream v9 TikTok-style Boost Patch: Run ONCE in Supabase SQL Editor (safe, no data deleted).

-- 1) Boost expiry column on public.posts
alter table public.posts add column if not exists boost_until timestamptz;

-- 2) Boost payment requests table (bKash / Nagad TrxID verification)
create table if not exists public.boost_requests (
  id bigint generated always as identity primary key,
  post_id bigint not null references public.posts on delete cascade,
  owner uuid not null references public.profiles on delete cascade,
  plan text not null check (plan in ('24h','3d','7d')),
  amount_bdt int not null,
  pay_method text not null check (pay_method in ('bKash','Nagad')),
  trx_id text not null check (char_length(trx_id) between 4 and 40),
  status text not null default 'pending' check (status in ('pending','approved','rejected')),
  created_at timestamptz not null default now()
);
alter table public.boost_requests enable row level security;
drop policy if exists "boost read" on public.boost_requests;   create policy "boost read" on public.boost_requests for select using (owner = auth.uid() or public.is_admin());
drop policy if exists "boost add" on public.boost_requests;    create policy "boost add" on public.boost_requests for insert with check (owner = auth.uid() and not public.is_banned() and not public.is_guest());

-- 3) Admin approve / reject RPC (automatically activates posts.boost_until on approval)
create or replace function public.admin_decide_boost(req_id bigint, approve boolean)
returns void language plpgsql security definer set search_path = public as $$
declare
  rec record;
  dur interval;
begin
  if not public.is_admin() then raise exception 'Admin access required'; end if;
  select * into rec from public.boost_requests where id = req_id;
  if not found then raise exception 'Request not found'; end if;
  update public.boost_requests set status = case when approve then 'approved' else 'rejected' end where id = req_id;
  if approve then
    dur := case rec.plan when '24h' then interval '24 hours' when '3d' then interval '3 days' else interval '7 days' end;
    update public.posts
    set boost_until = greatest(coalesce(boost_until, now()), now()) + dur
    where id = rec.post_id;
  end if;
end $$;
grant execute on function public.admin_decide_boost(bigint, boolean) to authenticated;

-- 4) Admin instant free boost RPC
create or replace function public.admin_boost_post(pid bigint, hrs int)
returns void language plpgsql security definer set search_path = public as $$
begin
  if not public.is_admin() then raise exception 'Admin access required'; end if;
  update public.posts set boost_until = case when hrs <= 0 then null else now() + make_interval(hours => hrs) end where id = pid;
end $$;
grant execute on function public.admin_boost_post(bigint, int) to authenticated;
