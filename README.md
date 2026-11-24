# MStream v3
1. Supabase → SQL Editor: run `supabase/00-reset.sql` (only if starting fresh), then `supabase/01-schema.sql`, then `supabase/03-v3-patch.sql`.
   - If you already ran `01-schema.sql` earlier, ONLY run `supabase/03-v3-patch.sql` once (no data deleted; adds Follows, Categories, Movies & Live TV catalog + real starter videos).
2. Authentication → Providers: Anonymous sign-ins ON; Email → "Confirm email" OFF. URL Configuration: Site URL = https://rajansaha1025-oss.github.io/mstream/
3. Upload all files + `assets`, `supabase`, `optional` folders to the GitHub repo. Settings → Pages → main / root.
4. Open the site, Sign up with your admin email, then run in SQL Editor:
   update public.profiles set role='admin' where id=(select id from auth.users where email='YOUR_ADMIN_EMAIL');
5. Optional: create `.github/workflows/ping.yml` from `optional/ping.yml` so the free database never pauses.
