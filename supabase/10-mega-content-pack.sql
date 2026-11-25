-- MStream v10 Mega Content Pack: Run ONCE in Supabase SQL Editor (safe, no duplicates, no data deleted).
-- Adds 37 Full Movies (South Hindi Dubbed, Bollywood Hindi, Bangla, Kolkata), 34 Real Short Reels, and 6 Online HTML5 Games.

-- 1) Add 37 Verified Full Movies (South Dubbed, Hindi, Bangla, Kolkata)
insert into public.catalog (kind, title, genre, media_url, thumb_url)
select v.kind, v.title, v.genre, v.media_url, v.thumb_url
from (values
  -- South Indian Hindi Dubbed (Telugu / Tamil)
  ('movie', 'Magadheera (4K) — Ram Charan', 'South Dubbed • Action', 'https://www.youtube.com/watch?v=3qiS9IUiIlw', 'https://i.ytimg.com/vi/3qiS9IUiIlw/hqdefault.jpg'),
  ('movie', 'Dear Comrade — Vijay Deverakonda', 'South Dubbed • Romance', 'https://www.youtube.com/watch?v=zzhfvt5vZHI', 'https://i.ytimg.com/vi/zzhfvt5vZHI/hqdefault.jpg'),
  ('movie', 'Chatrapathi (Hindi) — Bellamkonda', 'South Dubbed • Action', 'https://www.youtube.com/watch?v=d_1Q7DaSnBU', 'https://i.ytimg.com/vi/d_1Q7DaSnBU/hqdefault.jpg'),
  ('movie', 'Gold Thief (Bangaru Bullodu)', 'South Dubbed • Comedy', 'https://www.youtube.com/watch?v=eR1OXdEi4OY', 'https://i.ytimg.com/vi/eR1OXdEi4OY/hqdefault.jpg'),
  ('movie', 'Gold Thief — Allari Naresh', 'South Dubbed • Comedy', 'https://www.youtube.com/watch?v=lULz1emnPlA', 'https://i.ytimg.com/vi/lULz1emnPlA/hqdefault.jpg'),
  ('movie', 'Dangerous Khiladi 2 — Allu Arjun', 'South Dubbed • Action', 'https://www.youtube.com/watch?v=UBjdi_JXEng', 'https://i.ytimg.com/vi/UBjdi_JXEng/hqdefault.jpg'),
  ('movie', 'Dum (Happy) — Allu Arjun', 'South Dubbed • Romance', 'https://www.youtube.com/watch?v=JGizSzsSioI', 'https://i.ytimg.com/vi/JGizSzsSioI/hqdefault.jpg'),
  ('movie', 'Ek Aur Rakshak (Varudu) — Allu Arjun', 'South Dubbed • Action', 'https://www.youtube.com/watch?v=Vg33RbVKVgo', 'https://i.ytimg.com/vi/Vg33RbVKVgo/hqdefault.jpg'),
  ('movie', 'Super Hero Shehanshah — Vijay', 'South Dubbed • Action', 'https://www.youtube.com/watch?v=ZZzNiUQdGp4', 'https://i.ytimg.com/vi/ZZzNiUQdGp4/hqdefault.jpg'),
  ('movie', 'Allu Arjun Love Story (Hindi Dubbed)', 'South Dubbed • Romance', 'https://www.youtube.com/watch?v=MC2k1eCpXl4', 'https://i.ytimg.com/vi/MC2k1eCpXl4/hqdefault.jpg'),
  ('movie', 'Allu Arjun Action Special (1080p)', 'South Dubbed • Action', 'https://www.youtube.com/watch?v=nK0dDJRNNuU', 'https://i.ytimg.com/vi/nK0dDJRNNuU/hqdefault.jpg'),
  ('movie', 'South Blockbuster Action — Prabhas', 'South Dubbed • Action', 'https://www.youtube.com/watch?v=2mVvcfzPc9U', 'https://i.ytimg.com/vi/2mVvcfzPc9U/hqdefault.jpg'),
  ('movie', 'Veerta The Power — Allu Arjun', 'South Dubbed • Action', 'https://www.youtube.com/watch?v=Yy08bc2zHig', 'https://i.ytimg.com/vi/Yy08bc2zHig/hqdefault.jpg'),
  ('movie', 'Fighter 2 — Allu Arjun (Hindi Dubbed)', 'South Dubbed • Action', 'https://www.youtube.com/watch?v=tl_y-6tpJOc', 'https://i.ytimg.com/vi/tl_y-6tpJOc/hqdefault.jpg'),

  -- Hindi Bollywood Full Movies
  ('movie', 'Bhool Bhulaiyaa — Akshay Kumar', 'Hindi • Horror Comedy', 'https://www.youtube.com/watch?v=Kkcwa_hSKLA', 'https://i.ytimg.com/vi/Kkcwa_hSKLA/hqdefault.jpg'),
  ('movie', 'Romeo S3 (2025) — Full Movie', 'Hindi • Action Thriller', 'https://www.youtube.com/watch?v=tQtJzzCOiys', 'https://i.ytimg.com/vi/tQtJzzCOiys/hqdefault.jpg'),
  ('movie', 'Dhamaal (HD) — Sanjay Dutt', 'Hindi • Comedy', 'https://www.youtube.com/watch?v=LKNHVDPKy7g', 'https://i.ytimg.com/vi/LKNHVDPKy7g/hqdefault.jpg'),
  ('movie', 'Sanam Re (4K) — Romantic Movie', 'Hindi • Romance', 'https://www.youtube.com/watch?v=vMEo5QDLmsw', 'https://i.ytimg.com/vi/vMEo5QDLmsw/hqdefault.jpg'),
  ('movie', 'Pad Man (4K) — Akshay Kumar', 'Hindi • Drama', 'https://www.youtube.com/watch?v=UM54pRjkfos', 'https://i.ytimg.com/vi/UM54pRjkfos/hqdefault.jpg'),
  ('movie', 'Tees Maar Khan — Akshay Kumar', 'Hindi • Comedy', 'https://www.youtube.com/watch?v=8ucYhlbg0Ko', 'https://i.ytimg.com/vi/8ucYhlbg0Ko/hqdefault.jpg'),
  ('movie', 'Jaan-E-Mann — Salman & Akshay', 'Hindi • Romance Comedy', 'https://www.youtube.com/watch?v=X1ZF_wvzc80', 'https://i.ytimg.com/vi/X1ZF_wvzc80/hqdefault.jpg'),
  ('movie', 'Karan Arjun — SRK & Salman Khan', 'Hindi • Action Classic', 'https://www.youtube.com/watch?v=80kaFa6HTjA', 'https://i.ytimg.com/vi/80kaFa6HTjA/hqdefault.jpg'),
  ('movie', 'Hum Tumhare Hain Sanam — SRK', 'Hindi • Romance', 'https://www.youtube.com/watch?v=lTLQO4s9CFo', 'https://i.ytimg.com/vi/lTLQO4s9CFo/hqdefault.jpg'),
  ('movie', 'BABY (4K) — Akshay Kumar', 'Hindi • Action Thriller', 'https://www.youtube.com/watch?v=KyPyjT1FvWs', 'https://i.ytimg.com/vi/KyPyjT1FvWs/hqdefault.jpg'),
  ('movie', 'Namastey London — Akshay & Katrina', 'Hindi • Romance', 'https://www.youtube.com/watch?v=2ehGY6YvFvE', 'https://i.ytimg.com/vi/2ehGY6YvFvE/hqdefault.jpg'),
  ('movie', 'Bodyguard (4K) — Salman Khan', 'Hindi • Action Romance', 'https://www.youtube.com/watch?v=f07wuFY5Tug', 'https://i.ytimg.com/vi/f07wuFY5Tug/hqdefault.jpg'),
  ('movie', 'Insan — Akshay Kumar & Ajay Devgn', 'Hindi • Action', 'https://www.youtube.com/watch?v=PoIqA9cn8Ow', 'https://i.ytimg.com/vi/PoIqA9cn8Ow/hqdefault.jpg'),

  -- Kolkata & Bangladesh Bangla Full Movies
  ('movie', 'Santan Jakhan Satru — Prosenjit', 'Kolkata • Bangla Drama', 'https://www.youtube.com/watch?v=9W4p4_dzwEs', 'https://i.ytimg.com/vi/9W4p4_dzwEs/hqdefault.jpg'),
  ('movie', 'Sud Asal (সুদ আসল) — Prosenjit', 'Kolkata • Bangla Family', 'https://www.youtube.com/watch?v=eMX0w1em4iM', 'https://i.ytimg.com/vi/eMX0w1em4iM/hqdefault.jpg'),
  ('movie', 'Sindur Khela — Prosenjit', 'Kolkata • Bangla Classic', 'https://www.youtube.com/watch?v=uZdYCMcwTJU', 'https://i.ytimg.com/vi/uZdYCMcwTJU/hqdefault.jpg'),
  ('movie', 'Asbe Kobe Tumi Seje Mohini', 'Kolkata • Bangla Romance', 'https://www.youtube.com/watch?v=zSUvDU9EVJU', 'https://i.ytimg.com/vi/zSUvDU9EVJU/hqdefault.jpg'),
  ('movie', 'Gharer Laxmi — Full Movie', 'Kolkata • Bangla Family', 'https://www.youtube.com/watch?v=Ruif9YRCMzE', 'https://i.ytimg.com/vi/Ruif9YRCMzE/hqdefault.jpg'),
  ('movie', 'Chachu Amar Chachu — Shakib Khan', 'Bangla • Family Drama', 'https://www.youtube.com/watch?v=XEMWnXjz8Ms', 'https://i.ytimg.com/vi/XEMWnXjz8Ms/hqdefault.jpg'),
  ('movie', 'Ful Fotabo Tomay Niye — Shakib Khan', 'Bangla • Romance', 'https://www.youtube.com/watch?v=WoCaT-LCXz0', 'https://i.ytimg.com/vi/WoCaT-LCXz0/hqdefault.jpg'),
  ('movie', 'Jora Bon — Pori Moni & Ferdous', 'Bangla • Latest Movie', 'https://www.youtube.com/watch?v=izJFmzIep3g', 'https://i.ytimg.com/vi/izJFmzIep3g/hqdefault.jpg'),
  ('movie', 'Baba Jatri Chele Ricksawala', 'Bangla • Emotional Drama', 'https://www.youtube.com/watch?v=pxgRF_ZtrF8', 'https://i.ytimg.com/vi/pxgRF_ZtrF8/hqdefault.jpg'),
  ('movie', 'Sotter Mrittu Nei — Classic', 'Bangla • Classic', 'https://www.youtube.com/watch?v=X5qJD4zj4AE', 'https://i.ytimg.com/vi/X5qJD4zj4AE/hqdefault.jpg')
) as v(kind, title, genre, media_url, thumb_url)
where not exists (select 1 from public.catalog c where c.media_url = v.media_url);

-- 2) Add 6 More Verified Online HTML5 Games
insert into public.catalog (kind, title, genre, media_url, thumb_url)
select v.kind, v.title, v.genre, v.media_url, v.thumb_url
from (values
  ('game', 'Nebula Nomad Space Shooter', 'Shooter • Arcade', 'https://therkspace.github.io/nebulanomad/', null),
  ('game', 'Fruit Ninja HTML5', 'Action • Slice', 'https://famobigames.github.io/famobi.com/fruit-ninja/index7038.html?locale=en', null),
  ('game', 'Bus Parking 3D', 'Racing • Driving', 'https://famobigames.github.io/famobi.com/bus-parking-3d/index7038.html?locale=en', null),
  ('game', 'LittleJS Retro Arcade', 'Arcade • Collection', 'https://killedbyapixel.github.io/LittleJSArcade/', null),
  ('game', 'Retro Bowl & IO Games Hub', 'Sports • Multiplayer', 'https://retro-bowl-36.github.io/', null),
  ('game', 'Legacy 12 Retro Games', 'Retro • Platformer', 'https://humancto.github.io/legacy-games/', null)
) as v(kind, title, genre, media_url, thumb_url)
where not exists (select 1 from public.catalog c where c.media_url = v.media_url);

-- 3) Add 34 Real Verified Short Reels (Football, Cricket, Gaming, Comedy, Science, Food)
do $$
declare admin_id uuid;
begin
  select id into admin_id from public.profiles order by (role = 'admin') desc, created_at asc limit 1;
  if admin_id is not null then
    insert into public.posts (owner, title, category, media_url, thumb_url)
    select admin_id, v.title, v.category, v.media_url, v.thumb_url
    from (values
      ('Try to stop Doku ⚡ Football Skills', 'reels', 'https://www.youtube.com/shorts/UmE55I2E-Zs', 'https://i.ytimg.com/vi/UmE55I2E-Zs/hqdefault.jpg'),
      ('Messi vs Ronaldo — Champions League', 'reels', 'https://www.youtube.com/shorts/efxOScRIfRM', 'https://i.ytimg.com/vi/efxOScRIfRM/hqdefault.jpg'),
      ('The Day Ronaldo & Messi Shocked The World', 'reels', 'https://www.youtube.com/shorts/OLnv7PidjmM', 'https://i.ytimg.com/vi/OLnv7PidjmM/hqdefault.jpg'),
      ('The Double Nutmeg ⚽ Man City Skills', 'reels', 'https://www.youtube.com/shorts/2xalEeYRUzk', 'https://i.ytimg.com/vi/2xalEeYRUzk/hqdefault.jpg'),
      ('Messi vs Ronaldo Hat-Trick Debate', 'reels', 'https://www.youtube.com/shorts/m3wJ7NVJipY', 'https://i.ytimg.com/vi/m3wJ7NVJipY/hqdefault.jpg'),
      ('The Best Messi vs Ronaldo Match', 'reels', 'https://www.youtube.com/shorts/H0ujCYk88P0', 'https://i.ytimg.com/vi/H0ujCYk88P0/hqdefault.jpg'),
      ('Virat Kohli vs Ronaldo vs Messi', 'reels', 'https://www.youtube.com/shorts/oZ1GDAV4G7k', 'https://i.ytimg.com/vi/oZ1GDAV4G7k/hqdefault.jpg'),
      ('Messi vs Ronaldo — Who Ya Got? ⚽', 'reels', 'https://www.youtube.com/shorts/C2ZoJ3A5PUs', 'https://i.ytimg.com/vi/C2ZoJ3A5PUs/hqdefault.jpg'),
      ('Shakib Al Hasan Best Batting 🏏', 'reels', 'https://www.youtube.com/shorts/qrC1WOHJoKE', 'https://i.ytimg.com/vi/qrC1WOHJoKE/hqdefault.jpg'),
      ('Shakib Al Hasan Goes BIG — 3 Sixes!', 'reels', 'https://www.youtube.com/shorts/MJvfwfU3ptw', 'https://i.ytimg.com/vi/MJvfwfU3ptw/hqdefault.jpg'),
      ('Suresh Raina Jersey Collection — Kohli & Dhoni', 'reels', 'https://www.youtube.com/shorts/kad7m__I6mo', 'https://i.ytimg.com/vi/kad7m__I6mo/hqdefault.jpg'),
      ('Cricket X-Ball Unboxing 🏏', 'reels', 'https://www.youtube.com/shorts/IloPtmBptYU', 'https://i.ytimg.com/vi/IloPtmBptYU/hqdefault.jpg'),
      ('Joe Root Cricket Interview', 'reels', 'https://www.youtube.com/shorts/Ci-xSoNlMDA', 'https://i.ytimg.com/vi/Ci-xSoNlMDA/hqdefault.jpg'),
      ('Magic of Science Experiment 🧪', 'reels', 'https://www.youtube.com/shorts/X7z4W2lGlQk', 'https://i.ytimg.com/vi/X7z4W2lGlQk/hqdefault.jpg'),
      ('Submarine Balloon Science Fun', 'reels', 'https://www.youtube.com/shorts/CgH3vr8SRiU', 'https://i.ytimg.com/vi/CgH3vr8SRiU/hqdefault.jpg'),
      ('Funniest Science Jokes Ranked 😂', 'reels', 'https://www.youtube.com/shorts/Hbyjimi_HlQ', 'https://i.ytimg.com/vi/Hbyjimi_HlQ/hqdefault.jpg'),
      ('Comedy Song Game — Jack Dee', 'reels', 'https://www.youtube.com/shorts/wYU13dV7dqw', 'https://i.ytimg.com/vi/wYU13dV7dqw/hqdefault.jpg'),
      ('Funny Couple Moments in Korea', 'reels', 'https://www.youtube.com/shorts/9cfO6u9aJ74', 'https://i.ytimg.com/vi/9cfO6u9aJ74/hqdefault.jpg'),
      ('River Science Follow Up', 'reels', 'https://www.youtube.com/shorts/4bbYpTY2sg8', 'https://i.ytimg.com/vi/4bbYpTY2sg8/hqdefault.jpg'),
      ('I Escaped The Cops On A Scooter — GTA', 'gaming', 'https://www.youtube.com/shorts/83MjCxDwYfA', 'https://i.ytimg.com/vi/83MjCxDwYfA/hqdefault.jpg'),
      ('Supercars in Minecraft 🏎️', 'gaming', 'https://www.youtube.com/shorts/1zqmEZvOc4k', 'https://i.ytimg.com/vi/1zqmEZvOc4k/hqdefault.jpg'),
      ('When Your Friend Is Hacking — Minecraft', 'gaming', 'https://www.youtube.com/shorts/WESkXi4SGbU', 'https://i.ytimg.com/vi/WESkXi4SGbU/hqdefault.jpg'),
      ('Build a Rideable Sports Car in Minecraft', 'gaming', 'https://www.youtube.com/shorts/UY6IkGsYi1w', 'https://i.ytimg.com/vi/UY6IkGsYi1w/hqdefault.jpg'),
      ('Crazy Mountain Bike Climb — Minecraft', 'gaming', 'https://www.youtube.com/shorts/h1MpoX9B9VM', 'https://i.ytimg.com/vi/h1MpoX9B9VM/hqdefault.jpg'),
      ('How To Build A Sports Car in Minecraft', 'gaming', 'https://www.youtube.com/shorts/JsxmD4b9OBY', 'https://i.ytimg.com/vi/JsxmD4b9OBY/hqdefault.jpg'),
      ('Fastest Ways to Travel in Minecraft', 'gaming', 'https://www.youtube.com/shorts/56w5ex94B0g', 'https://i.ytimg.com/vi/56w5ex94B0g/hqdefault.jpg'),
      ('Motorbikes Are OP — Gaming Short', 'gaming', 'https://www.youtube.com/shorts/8NHsRvYq9w8', 'https://i.ytimg.com/vi/8NHsRvYq9w8/hqdefault.jpg'),
      ('Marvel Rivals Gameplay Montage', 'gaming', 'https://www.youtube.com/shorts/SF5hGdcjQ4g', 'https://i.ytimg.com/vi/SF5hGdcjQ4g/hqdefault.jpg'),
      ('Hearthstone Doubling Down 🎮', 'gaming', 'https://www.youtube.com/shorts/93M0oxN0Y98', 'https://i.ytimg.com/vi/93M0oxN0Y98/hqdefault.jpg'),
      ('24 Hours Kolkata Bengali Street Food 🍛', 'reels', 'https://www.youtube.com/shorts/LJyidNTKsqE', 'https://i.ytimg.com/vi/LJyidNTKsqE/hqdefault.jpg'),
      ('Kolkata Hedua Street Food Vlog', 'reels', 'https://www.youtube.com/shorts/cT5smECEtOE', 'https://i.ytimg.com/vi/cT5smECEtOE/hqdefault.jpg'),
      ('Sylheti Cooking — Dal Bhuna & Hilsha Fish 🐟', 'reels', 'https://www.youtube.com/shorts/oN-UOtIdic8', 'https://i.ytimg.com/vi/oN-UOtIdic8/hqdefault.jpg'),
      ('Kolkata College Street Food Tour', 'reels', 'https://www.youtube.com/shorts/FQXcv2mS-rU', 'https://i.ytimg.com/vi/FQXcv2mS-rU/hqdefault.jpg'),
      ('Kolkata Fusion Bengali Food ❤️', 'reels', 'https://www.youtube.com/shorts/I2l8jtaFuq0', 'https://i.ytimg.com/vi/I2l8jtaFuq0/hqdefault.jpg')
    ) as v(title, category, media_url, thumb_url)
    where not exists (select 1 from public.posts p where p.media_url = v.media_url);
  end if;
end $$;
