-- MStream v8 Cartoons, Series & Live Cartoon Channels Pack: Run ONCE in Supabase SQL Editor (safe, no duplicates).

-- 1) Allow 'series' in public.catalog alongside 'movie', 'livetv', 'game'
alter table public.catalog drop constraint if exists catalog_kind_check;
alter table public.catalog add constraint catalog_kind_check check (kind in ('movie','livetv','series','game'));

-- 2) Seed 5 Official Cartoon Live TV Channels (India + International)
insert into public.catalog (kind, title, genre, media_url, thumb_url)
select v.kind, v.title, v.genre, v.media_url, v.thumb_url
from (values
  ('livetv', 'Sony AATH Live (Gopal Bhar)', 'Cartoon • India Bangla', 'https://www.youtube.com/channel/UCBz9qbqujcjIavFmBJW2oZw/live', null),
  ('livetv', 'Green Gold TV (Chhota Bheem Live)', 'Cartoon • India', 'https://www.youtube.com/channel/UCiBigY9XM-HaOxUc269ympg/live', null),
  ('livetv', 'Mr. Bean Cartoon Live', 'Cartoon • World', 'https://www.youtube.com/channel/UCkAGrHCLFmlK3H2kd6isipg/live', null),
  ('livetv', 'OGGY Official Cartoon Live', 'Cartoon • World', 'https://www.youtube.com/channel/UCNEKMkg_DG8eAyR1BNWsSvw/live', null),
  ('livetv', 'Mr. Bean World Live', 'Cartoon • World', 'https://www.youtube.com/channel/UCzoFjzSkbrDD1GHsz2YNLig/live', null)
) as v(kind, title, genre, media_url, thumb_url)
where not exists (select 1 from public.catalog c where c.media_url = v.media_url);

-- 3) Seed Gopal Bhar, Chhota Bheem, Doraemon, Shinchan, Tom & Jerry, Mr. Bean, Motu Patlu, Meena & Thakurmar Jhuli Series/Episodes
insert into public.catalog (kind, title, genre, media_url, thumb_url)
select v.kind, v.title, v.genre, v.media_url, v.thumb_url
from (values
  ('series', 'Gopal Bhar — Season 1 (400 Episodes)', 'Gopal Bhar • Bangla', 'https://www.youtube.com/playlist?list=PL5O3zv2ZcASgUAyvvmP8SXotRpe2m12VJ', 'https://i.ytimg.com/vi/eRnr0a0Iifw/hqdefault.jpg'),
  ('series', 'Gopal Bhar — Full Series (982 Episodes)', 'Gopal Bhar • Bangla', 'https://www.youtube.com/playlist?list=PL5O3zv2ZcASh8p9kUDsJ9I8q5BTTd0cmw', 'https://i.ytimg.com/vi/s0_nwds5D_E/hqdefault.jpg'),
  ('series', 'Best of Gopal Bhar (891 Episodes)', 'Gopal Bhar • Bangla', 'https://www.youtube.com/playlist?list=PL5O3zv2ZcASgMB9aSQH_O1dS1393zDUGi', 'https://i.ytimg.com/vi/jChoqnzFl50/hqdefault.jpg'),
  ('series', 'Gopal Bhar — Double Gopal Series', 'Gopal Bhar • Bangla', 'https://www.youtube.com/playlist?list=PL5O3zv2ZcASiQyY9AxATv-tpWK_kH1kmF', 'https://i.ytimg.com/vi/1Q24FXNbb2U/hqdefault.jpg'),
  ('series', 'Chhota Bheem — Full Series (947 Episodes)', 'Cartoon • India Hindi', 'https://www.youtube.com/playlist?list=PL_J7KQaTDoWzFZOCZL8Q4_HXe5mUDaMC7', 'https://i.ytimg.com/vi/2YB_1lyfP94/hqdefault.jpg'),
  ('series', 'Mr. Bean Cartoon — Full Collection', 'Cartoon • World', 'https://www.youtube.com/playlist?list=PL2DBcdm4eKcglbj6Fmcnpjb_wWmjAzN7V', 'https://i.ytimg.com/vi/qUz512BuAfU/hqdefault.jpg'),
  ('series', 'Mr. Bean Animated — Full Episodes', 'Cartoon • World', 'https://www.youtube.com/playlist?list=PLC1EDzqtkrh_Zj67UUTZZmRfrgqwyZNlW', 'https://i.ytimg.com/vi/Xar9cWXlhhk/hqdefault.jpg'),
  ('series', 'Tom and Jerry — Mega Compilation', 'Cartoon • World', 'https://www.youtube.com/watch?v=pEl3-0GHyoQ', 'https://i.ytimg.com/vi/pEl3-0GHyoQ/hqdefault.jpg'),
  ('series', 'Motu Patlu — Samosa Machine Disaster', 'Cartoon • India Hindi', 'https://www.youtube.com/watch?v=f_XR3kuIB9A', 'https://i.ytimg.com/vi/f_XR3kuIB9A/hqdefault.jpg'),
  ('series', 'Meena Cartoon — Part 1 (Bangla)', 'Bangla • Cartoon', 'https://www.youtube.com/watch?v=l3iLIM-p1bc', 'https://i.ytimg.com/vi/l3iLIM-p1bc/hqdefault.jpg'),
  ('series', 'Thakurmar Jhuli — Manimala (Bangla)', 'Bangla • Cartoon', 'https://www.youtube.com/watch?v=5y6nZ6L8ZIU', 'https://i.ytimg.com/vi/5y6nZ6L8ZIU/hqdefault.jpg'),
  ('series', 'Doraemon — Full Episode (Hindi)', 'Doraemon • Anime', 'https://www.youtube.com/watch?v=FoB3j54oSf0', 'https://i.ytimg.com/vi/FoB3j54oSf0/hqdefault.jpg'),
  ('series', 'Shinchan — Latest Episode (Hindi)', 'Shinchan • Anime', 'https://www.youtube.com/watch?v=-pnJfvYKETo', 'https://i.ytimg.com/vi/-pnJfvYKETo/hqdefault.jpg'),
  ('series', 'Shinchan — Special Episode (Bangla)', 'Shinchan • Bangla Anime', 'https://www.youtube.com/watch?v=Y03axxig4gs', 'https://i.ytimg.com/vi/Y03axxig4gs/hqdefault.jpg')
) as v(kind, title, genre, media_url, thumb_url)
where not exists (select 1 from public.catalog c where c.media_url = v.media_url);
