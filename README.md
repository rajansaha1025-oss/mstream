# MStream — Watch • Share • Shop • Connect

## 1. Deploy (GitHub Pages, free)
Upload **everything** in this folder (keep `assets/`) to a public repo → Settings → Pages → `main` / root.

## 2. Turn on the cloud (Supabase, free)
1. Create a project at supabase.com. Authentication → Providers → enable **Anonymous sign-ins**.
2. SQL Editor → run `supabase/schema.sql`, then `supabase/schema-v2.sql` (likes, payments), then `schema-v3.sql` (follows, DMs, wallet), `schema-v4.sql` (bans, comments, views, reports), `schema-v5.sql` (follower counts).
3. Authentication → Users → add your admin (email + strong password). Then run:
   `update public.profiles set role='admin' where id='<that user id>';`
   (To make someone a Verified Publisher, set `role='publisher'` the same way.)
4. Project Settings → API → copy **Project URL** and **anon key** into `APP_CONFIG` in `index.html`. Never put the `service_role` key anywhere in this repo.
5. Open the site: the DEMO badge disappears; 5-tap the logo → admin login now uses email + password checked by Supabase.

### Payments (manual verification)
Users pay your bKash/Nagad number and submit the TrxID. Check it in your bKash app, then in Supabase → Table Editor → `payments` set `status` to `approved` (boosts activate automatically) or `rejected`. Orders appear in the same table for you/the seller to fulfil.
Put your Project URL in `supabaseUrl` (key is already set).

### Wallet, affiliate & withdrawals
Share links now carry the sharer's ID. When you set an **order** payment to `approved` (after delivery/payment), the referrer gets 8% in `wallet_entries`. Users withdraw from the Wallet tab (min ৳500); you pay them manually, then set the `withdrawals` row to `paid` (or `rejected` to refund the balance). Boosts expire automatically after the paid duration.
### Chat
Messages are private 1-to-1. A person can be messaged only after they open the site and set their name in Account (names are unique).

### Login
Guests start anonymous; **Account → Cloud Account** upgrades them to email + password (same data kept) or Google. In Supabase → Authentication → Providers → Email, switch off "Confirm email" (easy) or set up SMTP. For Google, add your Google OAuth client ID/secret there.
### Moderation
Log in as admin (5 taps on the logo): Hide/Delete/Ban/Role now save to Supabase. Banned users cannot post, comment, chat or pay. User reports are in the `reports` table. Roles are decided by the server (`profiles.role`), not by the browser.

### Free Games
4 original games are built in (Snake, 2048, Memory, Tic-Tac-Toe). To add more, put only games you are **licensed to embed** into `APP_CONFIG.externalGames` (https links), e.g. from a game-publisher programme whose terms allow embedding. Never embed games just because they are free to play.
### Ads (optional)
Fill `APP_CONFIG.ads` after your ad account is approved: `adsenseClient` + `adsenseSlot` (Google AdSense) or paste another network's code into `customHtml`. Ads show only after the visitor accepts the cookie banner. Check your network's rules before using ads inside an APK (AdSense for websites may not be allowed in apps; apps usually need AdMob).
### Dark mode and Bangla
Toggle buttons in the header (🌙 and বাং). Dark mode is a colour-inversion approximation; Bangla translates the main menu and buttons, not every message.
### Faster CSS (optional)
Tailwind still loads from a CDN. To build it yourself: create `.github/workflows/tailwind.yml` with the contents of `optional/tailwind-build.yml`, run it from the Actions tab until `tailwind.css` appears in the repo, then in `index.html` replace the `cdn.tailwindcss.com` script tag with `<link rel="stylesheet" href="tailwind.css">`. Keep the CDN until that file exists.

## 3. Cloudinary
In Cloudinary → Settings → Upload presets, restrict the unsigned preset (video only, max size, a folder).

## 4. Android APK
pwabuilder.com → your Pages URL → Android. Upload the APK to GitHub Releases and set `apkDownloadUrl`. Add the generated `assetlinks.json` under `.well-known/` to hide the browser bar.

## Better calls (optional)
Create a free TURN account (e.g. metered.ca) and paste the servers into `APP_CONFIG.turnServers`.

## Replace before launch
Your contact email in `privacy.html` and `terms.html`.
