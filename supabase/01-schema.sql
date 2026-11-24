-- MStream database. Run this whole file ONCE (after 00-reset.sql if you had old tables).
create table if not exists public.profiles (
  id uuid primary key references auth.users on delete cascade,
  display_name text not null check (char_length(display_name) between 2 and 30),
  role text not null default 'user' check (role in ('user','publisher','admin')),
  banned boolean not null default false,
  created_at timestamptz not null default now());
create unique index if not exists profiles_name_uq on public.profiles (lower(display_name));
create table if not exists public.posts (
  id bigint generated always as identity primary key,
  owner uuid not null references public.profiles on delete cascade,
  title text not null check (char_length(title) between 1 and 120),
  media_url text not null, thumb_url text,
  hidden boolean not null default false, views int not null default 0,
  created_at timestamptz not null default now());
create table if not exists public.likes (post_id bigint references public.posts on delete cascade, owner uuid references public.profiles on delete cascade, primary key (post_id, owner));
create table if not exists public.comments (
  id bigint generated always as identity primary key,
  post_id bigint not null references public.posts on delete cascade,
  owner uuid not null references public.profiles on delete cascade,
  body text not null check (char_length(body) between 1 and 300),
  created_at timestamptz not null default now());

create or replace function public.handle_new_user() returns trigger language plpgsql security definer set search_path = public as $$
declare n text := left(trim(coalesce(new.raw_user_meta_data->>'name', '')), 24);
begin
  if char_length(n) < 2 then n := 'user'; end if;
  begin insert into public.profiles(id, display_name) values (new.id, n);
  exception when unique_violation then
    insert into public.profiles(id, display_name) values (new.id, n || floor(random()*9000 + 1000)::int);
  end;
  return new;
end $$;
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users for each row execute function public.handle_new_user();
insert into public.profiles(id, display_name) select id, 'user' || floor(random()*90000 + 10000)::int from auth.users on conflict (id) do nothing;

create or replace function public.is_admin() returns boolean language sql stable security definer set search_path = public as $$
  select exists (select 1 from public.profiles where id = auth.uid() and role = 'admin') $$;
create or replace function public.is_banned() returns boolean language sql stable security definer set search_path = public as $$
  select coalesce((select banned from public.profiles where id = auth.uid()), false) $$;
create or replace function public.is_guest() returns boolean language sql stable as $$
  select coalesce((auth.jwt() ->> 'is_anonymous')::boolean, false) $$;
create or replace function public.add_view(pid bigint) returns void language sql security definer set search_path = public as $$
  update public.posts set views = views + 1 where id = pid $$;

alter table public.profiles enable row level security;
alter table public.posts enable row level security;
alter table public.likes enable row level security;
alter table public.comments enable row level security;
drop policy if exists "profiles read" on public.profiles;   create policy "profiles read" on public.profiles for select using (true);
drop policy if exists "profiles rename" on public.profiles; create policy "profiles rename" on public.profiles for update using (id = auth.uid()) with check (id = auth.uid());
revoke update on public.profiles from anon, authenticated;
grant update (display_name) on public.profiles to authenticated;   -- users can change only their name; roles are set in the dashboard
drop policy if exists "posts read" on public.posts;   create policy "posts read" on public.posts for select using (not hidden or owner = auth.uid() or public.is_admin());
drop policy if exists "posts add" on public.posts;    create policy "posts add" on public.posts for insert with check (owner = auth.uid() and not public.is_banned() and not public.is_guest());
drop policy if exists "posts delete" on public.posts; create policy "posts delete" on public.posts for delete using (owner = auth.uid() or public.is_admin());
drop policy if exists "posts moderate" on public.posts; create policy "posts moderate" on public.posts for update using (public.is_admin());
drop policy if exists "likes read" on public.likes;   create policy "likes read" on public.likes for select using (true);
drop policy if exists "likes add" on public.likes;    create policy "likes add" on public.likes for insert with check (owner = auth.uid() and not public.is_banned());
drop policy if exists "likes remove" on public.likes; create policy "likes remove" on public.likes for delete using (owner = auth.uid());
drop policy if exists "comments read" on public.comments;   create policy "comments read" on public.comments for select using (true);
drop policy if exists "comments add" on public.comments;    create policy "comments add" on public.comments for insert with check (owner = auth.uid() and not public.is_banned());
drop policy if exists "comments delete" on public.comments; create policy "comments delete" on public.comments for delete using (owner = auth.uid() or public.is_admin());
-- Make yourself admin (after you sign up on the site), replace the email:
--   update public.profiles set role='admin' where id = (select id from auth.users where email='YOUR_EMAIL');
