-- MStream v7 SuperApp Patch: Run ONCE in Supabase SQL Editor (safe on existing DB, no data deleted).
-- Adds Instagram 24h Stories, Save/Bookmark (Watch Later), and Online Games URL catalog support.

-- 1) Instagram-style 24-Hour Stories
create table if not exists public.stories (
  id bigint generated always as identity primary key,
  owner uuid not null references public.profiles on delete cascade,
  media_url text,
  caption text check (char_length(caption) <= 200),
  bg text not null default 'linear-gradient(135deg,#6d28d9,#e11d8f)',
  created_at timestamptz not null default now(),
  expires_at timestamptz not null default (now() + interval '24 hours')
);
alter table public.stories enable row level security;
drop policy if exists "stories read" on public.stories;   create policy "stories read" on public.stories for select using (expires_at > now() or owner = auth.uid() or public.is_admin());
drop policy if exists "stories add" on public.stories;    create policy "stories add" on public.stories for insert with check (owner = auth.uid() and not public.is_banned() and not public.is_guest());
drop policy if exists "stories delete" on public.stories; create policy "stories delete" on public.stories for delete using (owner = auth.uid() or public.is_admin());

-- 2) Save / Bookmark Reels (Instagram Save + YouTube Watch Later)
create table if not exists public.saves (
  post_id bigint not null references public.posts on delete cascade,
  owner uuid not null references public.profiles on delete cascade,
  created_at timestamptz not null default now(),
  primary key (post_id, owner)
);
alter table public.saves enable row level security;
drop policy if exists "saves read" on public.saves;   create policy "saves read" on public.saves for select using (owner = auth.uid());
drop policy if exists "saves add" on public.saves;    create policy "saves add" on public.saves for insert with check (owner = auth.uid());
drop policy if exists "saves remove" on public.saves; create policy "saves remove" on public.saves for delete using (owner = auth.uid());

-- 3) Allow Online Games ('game') in catalog alongside 'movie' and 'livetv'
alter table public.catalog drop constraint if exists catalog_kind_check;
alter table public.catalog add constraint catalog_kind_check check (kind in ('movie','livetv','game'));

-- 4) Seed 6 Verified Online HTML5 Games (idempotent — skips if already added)
insert into public.catalog (kind, title, genre, media_url, thumb_url)
select v.kind, v.title, v.genre, v.media_url, v.thumb_url
from (values
  ('game', 'Classic Tetris Online', 'Puzzle • Arcade', 'https://vacationlabs.github.io/tetris/', null),
  ('game', 'Pacman HTML5', 'Retro • Arcade', 'https://alfonsonishikawa.github.io/pacman/', null),
  ('game', 'Play Chess Online', 'Board • Strategy', 'https://playchessunblocked.github.io/', null),
  ('game', 'Doodle Jump Online', 'Action • Jump', 'https://doodlejump24.github.io/', null),
  ('game', 'Super Mario Bros HTML5', 'Platformer • Classic', 'https://playmario.github.io/HTML5_Client/', null),
  ('game', 'Classic DOOM Browser', 'Action • Retro', 'https://joeheyming.github.io/doom/', null)
) as v(kind, title, genre, media_url, thumb_url)
where not exists (select 1 from public.catalog c where c.media_url = v.media_url);
