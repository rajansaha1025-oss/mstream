-- MStream v12 Reputed BD Live TV Add-on: Run ONCE in Supabase SQL Editor (safe, no duplicates).
insert into public.catalog (kind, title, genre, media_url, thumb_url)
select v.kind, v.title, v.genre, v.media_url, v.thumb_url
from (values
  ('livetv', 'ATN Bangla Live', 'BD • Entertainment & News', 'https://www.youtube.com/channel/UCVg8WjB-6bgtcYmrl1hj_Fg/live', null),
  ('livetv', 'ATN Bangla News Live', 'BD • News', 'https://www.youtube.com/channel/UCbgcYEdMsuypG2NJ-znBp3w/live', null),
  ('livetv', 'NEWS24 Live BD', 'BD • News', 'https://www.youtube.com/channel/UCb2O5Uo4a26CdTE7_2QA-jA/live', null),
  ('livetv', 'Maasranga TV Live', 'BD • Entertainment', 'https://www.youtube.com/channel/UC7lUFHcujxyC76r2LkmSOZA/live', null)
) as v(kind, title, genre, media_url, thumb_url)
where not exists (select 1 from public.catalog c where c.media_url = v.media_url);
