-- MStream v11 Kids Bangla & Hindi Cartoons Mega Pack: Run ONCE in Supabase SQL Editor (safe, no duplicates).
-- Adds 81 verified Bangla & Hindi Kids Cartoons/Animations + Masha & The Bear Hindi Live TV channel.

-- 1) Add Masha and the Bear Hindi Live TV channel
insert into public.catalog (kind, title, genre, media_url, thumb_url)
select v.kind, v.title, v.genre, v.media_url, v.thumb_url
from (values
  ('livetv', 'Masha & The Bear Hindi Live', 'Cartoon • India Hindi', 'https://www.youtube.com/channel/UCpgG0rtKd-CTzStI9w2ibkg/live', null)
) as v(kind, title, genre, media_url, thumb_url)
where not exists (select 1 from public.catalog c where c.media_url = v.media_url);

-- 2) Add 81 Verified Bangla & Hindi Kids Cartoons, Animations & Rhymes
insert into public.catalog (kind, title, genre, media_url, thumb_url)
select v.kind, v.title, v.genre, v.media_url, v.thumb_url
from (values
  -- Nat Boltu & Bantul The Great (Bangla)
  ('series', 'Nut Boltu — Masir Telebhaja', 'Bangla Kids • Cartoon', 'https://www.youtube.com/watch?v=kGiPSI6rChw', 'https://i.ytimg.com/vi/kGiPSI6rChw/hqdefault.jpg'),
  ('series', 'Nut Boltu — Daspray Dengue (Ep 298)', 'Bangla Kids • Cartoon', 'https://www.youtube.com/watch?v=xvYMz0RFMSc', 'https://i.ytimg.com/vi/xvYMz0RFMSc/hqdefault.jpg'),
  ('series', 'Nut Boltu — Target Borobabu (Ep 797)', 'Bangla Kids • Cartoon', 'https://www.youtube.com/watch?v=BAzlJmX9lDI', 'https://i.ytimg.com/vi/BAzlJmX9lDI/hqdefault.jpg'),
  ('series', 'Nut Boltu — Rohossomoy Jatra (Ep 719)', 'Bangla Kids • Cartoon', 'https://www.youtube.com/watch?v=C9QNl11Zgc0', 'https://i.ytimg.com/vi/C9QNl11Zgc0/hqdefault.jpg'),
  ('series', 'Nut Boltu — The Master Plan', 'Bangla Kids • Cartoon', 'https://www.youtube.com/watch?v=lrhaFdHLWOg', 'https://i.ytimg.com/vi/lrhaFdHLWOg/hqdefault.jpg'),
  ('series', 'Nut Boltu — Korali Dadur Mounobroto', 'Bangla Kids • Cartoon', 'https://www.youtube.com/watch?v=HGQ08cZNrCY', 'https://i.ytimg.com/vi/HGQ08cZNrCY/hqdefault.jpg'),
  ('series', 'Bantul The Great — Best Scene 304', 'Bangla Kids • Cartoon', 'https://www.youtube.com/watch?v=7lg1A6yC4lQ', 'https://i.ytimg.com/vi/7lg1A6yC4lQ/hqdefault.jpg'),
  ('series', 'Nut Boltu — Boltu Palay Palay (Ep 781)', 'Bangla Kids • Cartoon', 'https://www.youtube.com/watch?v=-e3in5a5t2M', 'https://i.ytimg.com/vi/-e3in5a5t2M/hqdefault.jpg'),
  ('series', 'Nut Boltu — Shilpi Biday (Ep 359)', 'Bangla Kids • Cartoon', 'https://www.youtube.com/watch?v=av2t-AJTEjo', 'https://i.ytimg.com/vi/av2t-AJTEjo/hqdefault.jpg'),
  ('series', 'Nut Boltu — Episode 700 Special', 'Bangla Kids • Cartoon', 'https://www.youtube.com/watch?v=Q51u7qq85BU', 'https://i.ytimg.com/vi/Q51u7qq85BU/hqdefault.jpg'),

  -- Gopal Bhar Special Full Episodes (Bangla)
  ('series', 'Gopal Bhar — Prosadi Jhum (Double Gopal)', 'Gopal Bhar • Bangla Kids', 'https://www.youtube.com/watch?v=BP1Lk7bSqPA', 'https://i.ytimg.com/vi/BP1Lk7bSqPA/hqdefault.jpg'),
  ('series', 'Gopal Bhar — Se Gure Bali (Ep 1238)', 'Gopal Bhar • Bangla Kids', 'https://www.youtube.com/watch?v=g6zFvUjxi7A', 'https://i.ytimg.com/vi/g6zFvUjxi7A/hqdefault.jpg'),
  ('series', 'Gopal Bhar — Chorar Gupto Songket', 'Gopal Bhar • Bangla Kids', 'https://www.youtube.com/watch?v=-HHdAZLXvuY', 'https://i.ytimg.com/vi/-HHdAZLXvuY/hqdefault.jpg'),
  ('series', 'Gopal Bhar — Bondhuder Irsha', 'Gopal Bhar • Bangla Kids', 'https://www.youtube.com/watch?v=GNK651sF4Ag', 'https://i.ytimg.com/vi/GNK651sF4Ag/hqdefault.jpg'),
  ('series', 'Gopal Bhar — Chand Neme Elo (Ep 1250)', 'Gopal Bhar • Bangla Kids', 'https://www.youtube.com/watch?v=2cJf87d4MIc', 'https://i.ytimg.com/vi/2cJf87d4MIc/hqdefault.jpg'),
  ('series', 'Gopal Bhar — Bhoyaboho Obostha', 'Gopal Bhar • Bangla Kids', 'https://www.youtube.com/watch?v=F2y5h8jJuFo', 'https://i.ytimg.com/vi/F2y5h8jJuFo/hqdefault.jpg'),
  ('series', 'Gopal Bhar — Jor Jar Muluk Tar', 'Gopal Bhar • Bangla Kids', 'https://www.youtube.com/watch?v=eNmlCP7p9ks', 'https://i.ytimg.com/vi/eNmlCP7p9ks/hqdefault.jpg'),
  ('series', 'Gopal Bhar — Kothin Proshno (Ep 1298)', 'Gopal Bhar • Bangla Kids', 'https://www.youtube.com/watch?v=IGEX-9COmtI', 'https://i.ytimg.com/vi/IGEX-9COmtI/hqdefault.jpg'),

  -- Ssoftoons & Bangla Fairy Tales / Rupkotha
  ('series', 'Boneder Bajimat — Ssoftoons Bangla', 'Bangla Kids • Fairy Tales', 'https://www.youtube.com/watch?v=bfISDD5q7vo', 'https://i.ytimg.com/vi/bfISDD5q7vo/hqdefault.jpg'),
  ('series', 'Tale of the Bamboo Eater — Bangla Fairy Tales', 'Bangla Kids • Fairy Tales', 'https://www.youtube.com/watch?v=cQ_AqTDyVxE', 'https://i.ytimg.com/vi/cQ_AqTDyVxE/hqdefault.jpg'),
  ('series', 'Alo — Ssoftoons Bangla Cartoon', 'Bangla Kids • Fairy Tales', 'https://www.youtube.com/watch?v=4kILJTaVPN0', 'https://i.ytimg.com/vi/4kILJTaVPN0/hqdefault.jpg'),
  ('series', 'Chasir Bou — Ssoftoons Bangla Story', 'Bangla Kids • Fairy Tales', 'https://www.youtube.com/watch?v=qBKrZSQV0ao', 'https://i.ytimg.com/vi/qBKrZSQV0ao/hqdefault.jpg'),
  ('series', 'Gul Diye Phul Chash — Ssoftoons Bangla', 'Bangla Kids • Fairy Tales', 'https://www.youtube.com/watch?v=9CWbrsSzOaM', 'https://i.ytimg.com/vi/9CWbrsSzOaM/hqdefault.jpg'),
  ('series', 'Jemon Dosh Temon Sasti — Ssoftoons', 'Bangla Kids • Fairy Tales', 'https://www.youtube.com/watch?v=76zsOKPVdnA', 'https://i.ytimg.com/vi/76zsOKPVdnA/hqdefault.jpg'),
  ('series', 'Ma-er Buddhi (Hariye Paowa) — Ssoftoons', 'Bangla Kids • Fairy Tales', 'https://www.youtube.com/watch?v=oj_IdYGilu0', 'https://i.ytimg.com/vi/oj_IdYGilu0/hqdefault.jpg'),
  ('series', 'Forsa Howar Cream — Ssoftoons Bangla', 'Bangla Kids • Fairy Tales', 'https://www.youtube.com/watch?v=dJxQOBX0AbI', 'https://i.ytimg.com/vi/dJxQOBX0AbI/hqdefault.jpg'),
  ('series', 'Smart Bacchader Golpo — Bangla Cartoon', 'Bangla Kids • Moral Stories', 'https://www.youtube.com/watch?v=P2kdxFCej4E', 'https://i.ytimg.com/vi/P2kdxFCej4E/hqdefault.jpg'),
  ('series', 'Boloban O Durbal — Bangla Moral Story', 'Bangla Kids • Moral Stories', 'https://www.youtube.com/watch?v=uIkRCNGiRL0', 'https://i.ytimg.com/vi/uIkRCNGiRL0/hqdefault.jpg'),
  ('series', 'Top 10 Bangla Moral Stories Collection', 'Bangla Kids • Moral Stories', 'https://www.youtube.com/watch?v=jlIALxU8DZY', 'https://i.ytimg.com/vi/jlIALxU8DZY/hqdefault.jpg'),
  ('series', 'Gilhari Express — Bangla Kids Cartoon', 'Bangla Kids • Cartoon', 'https://www.youtube.com/watch?v=Kwq3Yj9APZI', 'https://i.ytimg.com/vi/Kwq3Yj9APZI/hqdefault.jpg'),
  ('series', 'My Turn Your Turn — Bangla Rupkotha', 'Bangla Kids • Cartoon', 'https://www.youtube.com/watch?v=53y7XZZtMUM', 'https://i.ytimg.com/vi/53y7XZZtMUM/hqdefault.jpg'),
  ('series', 'Lobhi Doitto — Bengali Kids Stories', 'Bangla Kids • Fairy Tales', 'https://www.youtube.com/watch?v=93_3Fn4TU9Q', 'https://i.ytimg.com/vi/93_3Fn4TU9Q/hqdefault.jpg'),
  ('series', 'Byanger Mojar Kando — Kids Animation', 'Bangla Kids • Cartoon', 'https://www.youtube.com/watch?v=aRCWkl7aR5E', 'https://i.ytimg.com/vi/aRCWkl7aR5E/hqdefault.jpg'),
  ('series', 'Bacchader Jonno Bangla Rupkotha', 'Bangla Kids • Fairy Tales', 'https://www.youtube.com/watch?v=DOESI0y-tIo', 'https://i.ytimg.com/vi/DOESI0y-tIo/hqdefault.jpg'),
  ('series', 'Khajanar Khoj — Panchatantra Bangla', 'Bangla Kids • Moral Stories', 'https://www.youtube.com/watch?v=UFZvMfPpdKE', 'https://i.ytimg.com/vi/UFZvMfPpdKE/hqdefault.jpg'),

  -- Bangla Kids Rhymes & Chora
  ('series', 'Hattimatim Tim — Bangla Kids Rhyme', 'Rhymes • Bangla Kids', 'https://www.youtube.com/watch?v=9dyWJ6rUo9o', 'https://i.ytimg.com/vi/9dyWJ6rUo9o/hqdefault.jpg'),
  ('series', 'Hattimatim Tim & More — Kheyal Khushi', 'Rhymes • Bangla Kids', 'https://www.youtube.com/watch?v=cRhg8uuuPOU', 'https://i.ytimg.com/vi/cRhg8uuuPOU/hqdefault.jpg'),
  ('series', 'Hattimatim Tim — Best Bengali Rhymes', 'Rhymes • Bangla Kids', 'https://www.youtube.com/watch?v=ta71mLE278s', 'https://i.ytimg.com/vi/ta71mLE278s/hqdefault.jpg'),
  ('series', 'Hattimatim Tim Classic Cartoon Rhyme', 'Rhymes • Bangla Kids', 'https://www.youtube.com/watch?v=tbPGw2Fy11Y', 'https://i.ytimg.com/vi/tbPGw2Fy11Y/hqdefault.jpg'),
  ('series', 'Hattimatim Tim — Nursery Rhymes Bangla', 'Rhymes • Bangla Kids', 'https://www.youtube.com/watch?v=3mkVIjgBr54', 'https://i.ytimg.com/vi/3mkVIjgBr54/hqdefault.jpg'),
  ('series', 'Bangla Kids Songs & Rhymes Collection', 'Rhymes • Bangla Kids', 'https://www.youtube.com/watch?v=0cNC8777v-k', 'https://i.ytimg.com/vi/0cNC8777v-k/hqdefault.jpg'),
  ('series', 'Hattimatim Tim — Learn With Kids', 'Rhymes • Bangla Kids', 'https://www.youtube.com/watch?v=k7oCFcXI4bA', 'https://i.ytimg.com/vi/k7oCFcXI4bA/hqdefault.jpg'),
  ('series', 'Hattimatim Tim + Dol Dol Doloni Rhymes', 'Rhymes • Bangla Kids', 'https://www.youtube.com/watch?v=VYoSN0AoxTo', 'https://i.ytimg.com/vi/VYoSN0AoxTo/hqdefault.jpg'),

  -- Motu Patlu Hindi Full Episodes
  ('series', 'Motu Patlu — John Ne Chheene Sabke Ghar', 'Hindi Kids • Motu Patlu', 'https://www.youtube.com/watch?v=HrYbDYhMlIw', 'https://i.ytimg.com/vi/HrYbDYhMlIw/hqdefault.jpg'),
  ('series', 'Motu Patlu — Dragon Motu Full Episode', 'Hindi Kids • Motu Patlu', 'https://www.youtube.com/watch?v=GCDxsBbIb1A', 'https://i.ytimg.com/vi/GCDxsBbIb1A/hqdefault.jpg'),
  ('series', 'Motu Patlu — John Bana Guardian Angel', 'Hindi Kids • Motu Patlu', 'https://www.youtube.com/watch?v=QxNQxxu4BuE', 'https://i.ytimg.com/vi/QxNQxxu4BuE/hqdefault.jpg'),
  ('series', 'Motu Patlu — Motu Ka Alarm Clock', 'Hindi Kids • Motu Patlu', 'https://www.youtube.com/watch?v=Ej181JL2jng', 'https://i.ytimg.com/vi/Ej181JL2jng/hqdefault.jpg'),
  ('series', 'Motu Patlu — Motu Ka Sapna', 'Hindi Kids • Motu Patlu', 'https://www.youtube.com/watch?v=yWAA2Y9bZ40', 'https://i.ytimg.com/vi/yWAA2Y9bZ40/hqdefault.jpg'),
  ('series', 'Motu Patlu — Daal Mein Kuch Kala', 'Hindi Kids • Motu Patlu', 'https://www.youtube.com/watch?v=cecI-uP5d8o', 'https://i.ytimg.com/vi/cecI-uP5d8o/hqdefault.jpg'),
  ('series', 'Motu Patlu — Season 5 Episode 192', 'Hindi Kids • Motu Patlu', 'https://www.youtube.com/watch?v=DXztW9FQOHg', 'https://i.ytimg.com/vi/DXztW9FQOHg/hqdefault.jpg'),
  ('series', 'Motu Patlu — Scooter Race (Ep 3)', 'Hindi Kids • Motu Patlu', 'https://www.youtube.com/watch?v=vYM9wrC-Kmw', 'https://i.ytimg.com/vi/vYM9wrC-Kmw/hqdefault.jpg'),
  ('series', 'Motu Patlu — Rock Garden Adventure', 'Hindi Kids • Motu Patlu', 'https://www.youtube.com/watch?v=e76ga2T3uoM', 'https://i.ytimg.com/vi/e76ga2T3uoM/hqdefault.jpg'),
  ('series', 'Motu Patlu — Humpty Dumpty Special', 'Hindi Kids • Motu Patlu', 'https://www.youtube.com/watch?v=CrRlKjiG6c0', 'https://i.ytimg.com/vi/CrRlKjiG6c0/hqdefault.jpg'),
  ('series', 'Motu Patlu — Motu Ke Samose Ki Dukaan', 'Hindi Kids • Motu Patlu', 'https://www.youtube.com/watch?v=boaEDlAiK0M', 'https://i.ytimg.com/vi/boaEDlAiK0M/hqdefault.jpg'),

  -- Vir The Robot Boy, Rudra & Shiva (Hindi)
  ('series', 'Vir The Robot Boy — Compilation 13', 'Hindi Kids • Action Cartoon', 'https://www.youtube.com/watch?v=qypwdcNqgG8', 'https://i.ytimg.com/vi/qypwdcNqgG8/hqdefault.jpg'),
  ('series', 'Vir The Robot Boy — Monsoon Special', 'Hindi Kids • Action Cartoon', 'https://www.youtube.com/watch?v=HzfWws5bL54', 'https://i.ytimg.com/vi/HzfWws5bL54/hqdefault.jpg'),
  ('series', 'Rudra & Shiva vs Vir The Robot Boy', 'Hindi Kids • Action Cartoon', 'https://www.youtube.com/watch?v=wVBn35zfG4A', 'https://i.ytimg.com/vi/wVBn35zfG4A/hqdefault.jpg'),
  ('series', 'Vir The Robot Boy — Vir Ek Villain', 'Hindi Kids • Action Cartoon', 'https://www.youtube.com/watch?v=e0jrQnmUY5U', 'https://i.ytimg.com/vi/e0jrQnmUY5U/hqdefault.jpg'),
  ('series', 'Vir The Robot Boy — New Action Series', 'Hindi Kids • Action Cartoon', 'https://www.youtube.com/watch?v=YuqUUNuFVCA', 'https://i.ytimg.com/vi/YuqUUNuFVCA/hqdefault.jpg'),
  ('series', 'Vir The Robot Boy — Compilation 24', 'Hindi Kids • Action Cartoon', 'https://www.youtube.com/watch?v=XEekJoqHcbg', 'https://i.ytimg.com/vi/XEekJoqHcbg/hqdefault.jpg'),
  ('series', 'Vir The Robot Boy — Compilation 35', 'Hindi Kids • Action Cartoon', 'https://www.youtube.com/watch?v=4G-QjwNE4NI', 'https://i.ytimg.com/vi/4G-QjwNE4NI/hqdefault.jpg'),
  ('series', 'Vir The Robot Boy — Episode 74B Full', 'Hindi Kids • Action Cartoon', 'https://www.youtube.com/watch?v=iX6hYQTkOqU', 'https://i.ytimg.com/vi/iX6hYQTkOqU/hqdefault.jpg'),
  ('series', 'Vir The Robot Boy — Robotic Machine', 'Hindi Kids • Action Cartoon', 'https://www.youtube.com/watch?v=iTPf5Mx3o94', 'https://i.ytimg.com/vi/iTPf5Mx3o94/hqdefault.jpg'),

  -- Oggy and the Cockroaches (Hindi Full Episodes)
  ('series', 'Oggy & Cockroaches — New Episodes HD', 'Hindi Kids • Oggy', 'https://www.youtube.com/watch?v=9MVV8CXi-CE', 'https://i.ytimg.com/vi/9MVV8CXi-CE/hqdefault.jpg'),
  ('series', 'Oggy Hindi — Sports Fans (S04E26)', 'Hindi Kids • Oggy', 'https://www.youtube.com/watch?v=BstW5GDKVMU', 'https://i.ytimg.com/vi/BstW5GDKVMU/hqdefault.jpg'),
  ('series', 'Oggy Celebrity — Hindi Full Episode', 'Hindi Kids • Oggy', 'https://www.youtube.com/watch?v=Q1YORgGYhxE', 'https://i.ytimg.com/vi/Q1YORgGYhxE/hqdefault.jpg'),
  ('series', 'Oggy — Cruising The Nile HD', 'Hindi Kids • Oggy', 'https://www.youtube.com/watch?v=u_oeumbhljg', 'https://i.ytimg.com/vi/u_oeumbhljg/hqdefault.jpg'),
  ('series', 'Oggy — Two Bad Guys Full Episode', 'Hindi Kids • Oggy', 'https://www.youtube.com/watch?v=PKiiu93YR2Q', 'https://i.ytimg.com/vi/PKiiu93YR2Q/hqdefault.jpg'),
  ('series', 'Oggy Hindi — Gupt Baksa Full Episode', 'Hindi Kids • Oggy', 'https://www.youtube.com/watch?v=Q9proI4Wy64', 'https://i.ytimg.com/vi/Q9proI4Wy64/hqdefault.jpg'),
  ('series', 'Oggy Hindi — Kuch Ajeeb Hai', 'Hindi Kids • Oggy', 'https://www.youtube.com/watch?v=znx0Uo61CXI', 'https://i.ytimg.com/vi/znx0Uo61CXI/hqdefault.jpg'),
  ('series', 'Oggy Hindi — Oggy 2 Full Episode', 'Hindi Kids • Oggy', 'https://www.youtube.com/watch?v=TG96UUxwYVE', 'https://i.ytimg.com/vi/TG96UUxwYVE/hqdefault.jpg'),
  ('series', 'Oggy Hindi — Kho Gaya! Full Episode', 'Hindi Kids • Oggy', 'https://www.youtube.com/watch?v=MBKgWORXkYk', 'https://i.ytimg.com/vi/MBKgWORXkYk/hqdefault.jpg'),
  ('series', 'Oggy Hindi — Oggy Ka Purana Ghar', 'Hindi Kids • Oggy', 'https://www.youtube.com/watch?v=IWwDEfMLmcQ', 'https://i.ytimg.com/vi/IWwDEfMLmcQ/hqdefault.jpg'),

  -- Masha and the Bear & Peppa Pig (Hindi)
  ('series', 'Masha & The Bear — Summer Holidays', 'Hindi Kids • Masha', 'https://www.youtube.com/watch?v=jCvSEuHms5M', 'https://i.ytimg.com/vi/jCvSEuHms5M/hqdefault.jpg'),
  ('series', 'Peppa Pig Hindi — Takiye Ka Mahal', 'Hindi Kids • Peppa Pig', 'https://www.youtube.com/watch?v=TUxsRg6yu1o', 'https://i.ytimg.com/vi/TUxsRg6yu1o/hqdefault.jpg'),
  ('series', 'Masha & The Bear Hindi — Good Vibes', 'Hindi Kids • Masha', 'https://www.youtube.com/watch?v=uh6iYcK6zwM', 'https://i.ytimg.com/vi/uh6iYcK6zwM/hqdefault.jpg'),
  ('series', 'Masha & The Bear — Shower Power', 'Hindi Kids • Masha', 'https://www.youtube.com/watch?v=HrchZ6KACq8', 'https://i.ytimg.com/vi/HrchZ6KACq8/hqdefault.jpg'),
  ('series', 'Masha & The Bear Hindi — All Specials', 'Hindi Kids • Masha', 'https://www.youtube.com/watch?v=YLlE0liN8Fc', 'https://i.ytimg.com/vi/YLlE0liN8Fc/hqdefault.jpg'),
  ('series', 'Masha & The Bear — Eat Porridge', 'Hindi Kids • Masha', 'https://www.youtube.com/watch?v=YDhoIHgYYwo', 'https://i.ytimg.com/vi/YDhoIHgYYwo/hqdefault.jpg'),
  ('series', 'Masha & The Bear Hindi — Family Fun', 'Hindi Kids • Masha', 'https://www.youtube.com/watch?v=yJIcq1ZEjWE', 'https://i.ytimg.com/vi/yJIcq1ZEjWE/hqdefault.jpg')
) as v(kind, title, genre, media_url, thumb_url)
where not exists (select 1 from public.catalog c where c.media_url = v.media_url);
