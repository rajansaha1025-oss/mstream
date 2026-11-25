-- MStream v4 Content Pack: Run ONCE in Supabase SQL Editor (safe, no duplicates, no data deleted).
-- Adds Internet Archive classic movies, Bangla full movies, Blender open movies, and 10+ new Short Reels.

-- 1) Add Movies from Internet Archive & YouTube to public.catalog
insert into public.catalog (kind, title, genre, media_url, thumb_url)
select v.kind, v.title, v.genre, v.media_url, v.thumb_url
from (values
  ('movie', 'Badol | বাদল (Full HD)', 'Bangla • Classic', 'https://www.youtube.com/watch?v=3hJOG8mo5p4', 'https://i.ytimg.com/vi/3hJOG8mo5p4/hqdefault.jpg'),
  ('movie', 'Shaan | শান (Full Movie)', 'Bangla • Action', 'https://www.youtube.com/watch?v=DUXifJCs7-g', 'https://i.ytimg.com/vi/DUXifJCs7-g/hqdefault.jpg'),
  ('movie', 'Suno Baranari (Uttam Kumar)', 'Bangla • Classic', 'https://www.youtube.com/watch?v=NloQ9zrRpFg', 'https://i.ytimg.com/vi/NloQ9zrRpFg/hqdefault.jpg'),
  ('movie', 'Sprite Fright (Open Movie)', 'Horror • Comedy', 'https://www.youtube.com/watch?v=_cMxraX_5RE', 'https://i.ytimg.com/vi/_cMxraX_5RE/hqdefault.jpg'),
  ('movie', 'Elephants Dream (Open Movie)', 'Sci-Fi • Animation', 'https://www.youtube.com/watch?v=ePVe9FzuFfQ', 'https://i.ytimg.com/vi/ePVe9FzuFfQ/hqdefault.jpg'),
  ('movie', 'His Girl Friday (1940)', 'Hollywood • Comedy (Archive.org)', 'https://archive.org/details/his_girl_friday', 'https://archive.org/services/img/his_girl_friday'),
  ('movie', 'Charade (1963) — Audrey Hepburn', 'Hollywood • Thriller (Archive.org)', 'https://archive.org/details/ecatma-Old_Time_Movie_Show_-_Charade_1963', 'https://archive.org/services/img/ecatma-Old_Time_Movie_Show_-_Charade_1963'),
  ('movie', 'The General (1926) HD', 'Action • Classic (Archive.org)', 'https://archive.org/details/the-general-keaton-and-bruckman-1926-high-quality-1080p-t-o-p-swu-fc', 'https://archive.org/services/img/the-general-keaton-and-bruckman-1926-high-quality-1080p-t-o-p-swu-fc'),
  ('movie', 'The Navigator (1924) HD', 'Comedy • Classic (Archive.org)', 'https://archive.org/details/the-navigator-keaton-1924-high-quality-1080p-fgo-qarunxf-q', 'https://archive.org/services/img/the-navigator-keaton-1924-high-quality-1080p-fgo-qarunxf-q'),
  ('movie', 'Charlie Chaplin: The Adventurer', 'Comedy • Classic (Archive.org)', 'https://archive.org/details/CC_1917_10_22_TheAdventurer', 'https://archive.org/services/img/CC_1917_10_22_TheAdventurer'),
  ('movie', 'Nosferatu (1922)', 'Horror • Classic (Archive.org)', 'https://archive.org/details/nosferatu_201508', 'https://archive.org/services/img/nosferatu_201508')
) as v(kind, title, genre, media_url, thumb_url)
where not exists (select 1 from public.catalog c where c.media_url = v.media_url);

-- 2) Add 10 Real Short Reels (Red Bull Shorts, GoPro, NASA 4K, Blender Shorts) to public.posts
do $$
declare admin_id uuid;
begin
  select id into admin_id from public.profiles order by (role = 'admin') desc, created_at asc limit 1;
  if admin_id is not null then
    insert into public.posts (owner, title, category, media_url, thumb_url)
    select admin_id, v.title, v.category, v.media_url, v.thumb_url
    from (values
      ('Moments Of EXTREME Trust — Red Bull', 'reels', 'https://www.youtube.com/shorts/k--pkJcePTM', 'https://i.ytimg.com/vi/k--pkJcePTM/hqdefault.jpg'),
      ('World''s CRAZIEST POVs — Red Bull', 'reels', 'https://www.youtube.com/shorts/vcQqEGCpnMs', 'https://i.ytimg.com/vi/vcQqEGCpnMs/hqdefault.jpg'),
      ('They Went HOW Fast?! — Red Bull', 'reels', 'https://www.youtube.com/shorts/YLpdWPeSC8M', 'https://i.ytimg.com/vi/YLpdWPeSC8M/hqdefault.jpg'),
      ('Sports You Never Knew Existed', 'reels', 'https://www.youtube.com/shorts/9bv0rBDxVrY', 'https://i.ytimg.com/vi/9bv0rBDxVrY/hqdefault.jpg'),
      ('Practice Made Perfect — Action Short', 'reels', 'https://www.youtube.com/shorts/XVhsU0E1mHg', 'https://i.ytimg.com/vi/XVhsU0E1mHg/hqdefault.jpg'),
      ('GoPro HERO13 Cinematic Reel 4K', 'reels', 'https://www.youtube.com/watch?v=RgZwS3LVbjw', 'https://i.ytimg.com/vi/RgZwS3LVbjw/hqdefault.jpg'),
      ('Earth in 4K from Space Station — NASA', 'news', 'https://www.youtube.com/watch?v=UOT4VwhVukA', 'https://i.ytimg.com/vi/UOT4VwhVukA/hqdefault.jpg'),
      ('Earth at Night — NASA 4K', 'news', 'https://www.youtube.com/watch?v=Q3YYwIsMHzw', 'https://i.ytimg.com/vi/Q3YYwIsMHzw/hqdefault.jpg'),
      ('HERO — 2D/3D Animated Short', 'anime', 'https://www.youtube.com/watch?v=pKmSdY56VtY', 'https://i.ytimg.com/vi/pKmSdY56VtY/hqdefault.jpg'),
      ('Glass Half — 3D Comedy Cartoon', 'anime', 'https://www.youtube.com/watch?v=lqiN98z6Dak', 'https://i.ytimg.com/vi/lqiN98z6Dak/hqdefault.jpg')
    ) as v(title, category, media_url, thumb_url)
    where not exists (select 1 from public.posts p where p.media_url = v.media_url);
  end if;
end $$;
