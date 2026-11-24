# MStream
1. Supabase → SQL Editor: run `supabase/00-reset.sql` (only if old tables exist), then `supabase/01-schema.sql` (whole file, once).
2. If upgrading an existing setup, run `supabase/02-admin-patch.sql` once to enable Ban/Unban in the Admin Panel.
3. Authentication → Providers: Anonymous sign-ins ON; Email → "Confirm email" OFF. URL Configuration: Site URL = https://rajansaha1025-oss.github.io/mstream/
4. Upload all files + `assets`, `supabase`, `optional` folders to the GitHub repo. Settings → Pages → main / root.
5. Open the site, Sign up with your admin email, then run in SQL Editor:
   update public.profiles set role='admin' where id=(select id from auth.users where email='YOUR_ADMIN_EMAIL');
6. Optional: create `.github/workflows/ping.yml` from `optional/ping.yml` so the free database never pauses.
