-- MStream Live TV Pack (BD + India + Sports): Run ONCE in Supabase SQL Editor (safe, no duplicates).
-- Uses official 24/7 YouTube Live channel embeds that never expire.

insert into public.catalog (kind, title, genre, media_url, thumb_url)
select v.kind, v.title, v.genre, v.media_url, v.thumb_url
from (values
  -- Bangladesh Official Live TV
  ('livetv', 'Ekattor TV Live', 'BD • News', 'https://www.youtube.com/channel/UCtqvtAVmad5zywaziN6CbfA/live', null),
  ('livetv', 'Independent TV Live', 'BD • News', 'https://www.youtube.com/channel/UCATUkaOHwO9EP_W87zCiPbA/live', null),
  ('livetv', 'Channel 24 Live', 'BD • News', 'https://www.youtube.com/channel/UCHLqIOMPk20w-6cFgkA90jw/live', null),
  ('livetv', 'DBC NEWS Live', 'BD • News', 'https://www.youtube.com/channel/UCUvXoiDEKI8VZJrr58g4VAw/live', null),
  ('livetv', 'ATN News Live', 'BD • News', 'https://www.youtube.com/channel/UCKlhfq1ILoAFav7iw5iCnfA/live', null),
  ('livetv', 'Rtv Live 24/7', 'BD • Entertainment & News', 'https://www.youtube.com/channel/UCR0hSGudjeZfnGL3uodU9Sw/live', null),
  ('livetv', 'NTV Live', 'BD • Entertainment & News', 'https://www.youtube.com/channel/UC0V3IJCnr6ZNjB9t_GLhFFA/live', null),
  ('livetv', 'Channel i Live', 'BD • Entertainment & News', 'https://www.youtube.com/channel/UCA9CI-VL_LzlIROr2_n4iqA/live', null),

  -- India Official Live TV (Kolkata Bangla + Hindi + English)
  ('livetv', 'ABP ANANDA Live', 'India • Bangla News', 'https://www.youtube.com/channel/UCv3rFzn-GHGtqzXiaq3sWNg/live', null),
  ('livetv', 'Zee 24 Ghanta Live', 'India • Bangla News', 'https://www.youtube.com/channel/UCdF5Q5QVbYstYrTfpgUl0ZA/live', null),
  ('livetv', 'Aaj Tak HD Live', 'India • Hindi News', 'https://www.youtube.com/channel/UClmlqOOktUTpfW0EkTiqSjQ/live', null),
  ('livetv', 'NDTV India Live', 'India • Hindi News', 'https://www.youtube.com/channel/UC9CYT9gSNLevX5ey2_6CK0Q/live', null),
  ('livetv', 'NDTV 24x7 Live', 'India • English News', 'https://www.youtube.com/channel/UCZFMm1mMw0F81Z37aaEzTUA/live', null),
  ('livetv', 'India Today Live', 'India • English News', 'https://www.youtube.com/channel/UCYPvAwZP8pZhSMW8qs7cVCw/live', null),

  -- Sports Official Live Channels
  ('livetv', 'T Sports Live', 'Sports • BD Cricket & Football', 'https://www.youtube.com/channel/UC48Zc5trlPUvDIbCAaMdLiQ/live', null),
  ('livetv', 'T Sports Bangladesh', 'Sports • BD', 'https://www.youtube.com/channel/UCCqIQrVd8vknHzLoYzg8OcQ/live', null),
  ('livetv', 'FIFA+ Live Football', 'Sports • Football', 'https://www.youtube.com/channel/UCc-wT5WN6__3k8It-_HM_lA/live', null),
  ('livetv', 'BWF TV Live', 'Sports • Badminton', 'https://www.youtube.com/channel/UChh-akEbUM8_6ghGVnJd6cQ/live', null),
  ('livetv', 'Olympic Games Live', 'Sports • World', 'https://www.youtube.com/channel/UCTl3QQTvqHFjurroKxexy2Q/live', null)
) as v(kind, title, genre, media_url, thumb_url)
where not exists (select 1 from public.catalog c where c.media_url = v.media_url);
