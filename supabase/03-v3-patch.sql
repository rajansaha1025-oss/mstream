-- MStream v3 Patch: Run ONCE in Supabase SQL Editor (safe on existing DB, no data deleted).

-- 1) Category column on posts
alter table public.posts add column if not exists category text not null default 'reels';

-- 2) Follow / Follower system
create table if not exists public.follows (
  follower uuid not null references public.profiles on delete cascade,
  following uuid not null references public.profiles on delete cascade,
  created_at timestamptz not null default now(),
  primary key (follower, following),
  check (follower <> following)
);
alter table public.follows enable row level security;
drop policy if exists "follows read" on public.follows;   create policy "follows read" on public.follows for select using (true);
drop policy if exists "follows add" on public.follows;    create policy "follows add" on public.follows for insert with check (follower = auth.uid() and not public.is_banned());
drop policy if exists "follows remove" on public.follows; create policy "follows remove" on public.follows for delete using (follower = auth.uid());

-- 3) Movies & Live TV catalog (managed by Admin)
create table if not exists public.catalog (
  id bigint generated always as identity primary key,
  kind text not null check (kind in ('movie','livetv')),
  title text not null check (char_length(title) between 1 and 120),
  genre text not null default 'General',
  media_url text not null,
  thumb_url text,
  active boolean not null default true,
  created_at timestamptz not null default now()
);
alter table public.catalog enable row level security;
drop policy if exists "catalog read" on public.catalog;   create policy "catalog read" on public.catalog for select using (active or public.is_admin());
drop policy if exists "catalog add" on public.catalog;    create policy "catalog add" on public.catalog for insert with check (public.is_admin());
drop policy if exists "catalog edit" on public.catalog;   create policy "catalog edit" on public.catalog for update using (public.is_admin());
drop policy if exists "catalog delete" on public.catalog; create policy "catalog delete" on public.catalog for delete using (public.is_admin());

-- 4) Admin ban/unban RPC (included here so you only need to run this single file)
create or replace function public.admin_set_ban(uid uuid, is_banned boolean)
returns void language plpgsql security definer set search_path = public as $$
begin
  if not public.is_admin() then raise exception 'Admin access required'; end if;
  if uid = auth.uid() then raise exception 'You cannot ban yourself'; end if;
  update public.profiles set banned = is_banned where id = uid;
end $$;
grant execute on function public.admin_set_ban(uuid, boolean) to authenticated;

-- 5) Seed real official Live TV channels (idempotent: skips if already added)
insert into public.catalog (kind, title, genre, media_url, thumb_url)
select v.kind, v.title, v.genre, v.media_url, v.thumb_url
from (values
  ('livetv', 'Jamuna TV Live', 'News • BD', 'https://www.youtube.com/channel/UCN6sm8iHiPd0cnoUardDAnw/live', null),
  ('livetv', 'SOMOY TV Live', 'News • BD', 'https://www.youtube.com/channel/UCxHoBXkY88Tb8z1Ssj6CWsQ/live', null),
  ('livetv', 'Al Jazeera English Live', 'News • World', 'https://www.youtube.com/channel/UCNye-wNBqNL5ZzHSJj3l8Bg/live', null),
  ('livetv', 'FRANCE 24 English Live', 'News • World', 'https://www.youtube.com/channel/UCQfwfsi5VrQ8yKZ-UWmAEFg/live', null),
  ('livetv', 'NASA ISS Earth View Live', 'Space • Science', 'https://www.youtube.com/channel/UCLA_DiR1FfKNvjuUpBHmylQ/live', null)
) as v(kind, title, genre, media_url, thumb_url)
where not exists (select 1 from public.catalog c where c.media_url = v.media_url);

-- 6) Seed real Creative Commons Open Movies (Blender Foundation — official YouTube releases)
insert into public.catalog (kind, title, genre, media_url, thumb_url)
select v.kind, v.title, v.genre, v.media_url, v.thumb_url
from (values
  ('movie', 'Big Buck Bunny (Full HD)', 'Animation • Comedy', 'https://www.youtube.com/watch?v=YE7VzlLtp-4', 'https://i.ytimg.com/vi/YE7VzlLtp-4/hqdefault.jpg'),
  ('movie', 'Sintel (4K Open Movie)', 'Animation • Fantasy', 'https://www.youtube.com/watch?v=puLAJaabJh0', 'https://i.ytimg.com/vi/puLAJaabJh0/hqdefault.jpg'),
  ('movie', 'Tears of Steel (4K Sci-Fi)', 'Sci-Fi • Action', 'https://www.youtube.com/watch?v=OHOpb2fS-cM', 'https://i.ytimg.com/vi/OHOpb2fS-cM/hqdefault.jpg'),
  ('movie', 'Spring (Blender Open Movie)', 'Animation • Adventure', 'https://www.youtube.com/watch?v=WhWc3b3KhnY', 'https://i.ytimg.com/vi/WhWc3b3KhnY/hqdefault.jpg'),
  ('movie', 'CHARGE (Sci-Fi Short Film)', 'Sci-Fi • Action', 'https://www.youtube.com/watch?v=UXqq0ZvbOnk', 'https://i.ytimg.com/vi/UXqq0ZvbOnk/hqdefault.jpg'),
  ('movie', 'Cosmos Laundromat', 'Animation • Sci-Fi', 'https://www.youtube.com/watch?v=Y-rmzh0PI3c', 'https://i.ytimg.com/vi/Y-rmzh0PI3c/hqdefault.jpg')
) as v(kind, title, genre, media_url, thumb_url)
where not exists (select 1 from public.catalog c where c.media_url = v.media_url);

-- 7) Seed real starter Short Reels (owned by your admin account; skips if already added)
do $$
declare admin_id uuid;
begin
  select id into admin_id from public.profiles order by (role = 'admin') desc, created_at asc limit 1;
  if admin_id is not null then
    insert into public.posts (owner, title, category, media_url, thumb_url)
    select admin_id, v.title, v.category, v.media_url, v.thumb_url
    from (values
      ('WING IT! — Animated Short', 'anime', 'https://www.youtube.com/watch?v=u9lj-c29dxI', 'https://i.ytimg.com/vi/u9lj-c29dxI/hqdefault.jpg'),
      ('Coffee Run — Animated Short', 'anime', 'https://www.youtube.com/watch?v=PVGeM40dABA', 'https://i.ytimg.com/vi/PVGeM40dABA/hqdefault.jpg'),
      ('Agent 327: Operation Barbershop', 'reels', 'https://www.youtube.com/watch?v=yHioWLdgnMI', 'https://i.ytimg.com/vi/yHioWLdgnMI/hqdefault.jpg'),
      ('Big Buck Bunny — Official Trailer', 'reels', 'https://www.youtube.com/watch?v=GJVwbyAY4Sk', 'https://i.ytimg.com/vi/GJVwbyAY4Sk/hqdefault.jpg')
    ) as v(title, category, media_url, thumb_url)
    where not exists (select 1 from public.posts p where p.media_url = v.media_url);
  end if;
end $$;
