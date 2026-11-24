# MStream
1. Supabase → SQL Editor: run `supabase/00-reset.sql` (only if old tables exist), then `supabase/01-schema.sql` (whole file, once).
2. Authentication → Providers: Anonymous sign-ins ON; Email → "Confirm email" OFF. URL Configuration: Site URL = https://rajansaha1025-oss.github.io/mstream/
3. Upload all files + `assets`, `supabase`, `optional` folders to the GitHub repo. Settings → Pages → main / root.
4. Open the site, Sign up with mitulroy1111@gmail.com, then run in SQL Editor:
   update public.profiles set role='admin' where id=(select id from auth.users where email='mitulroy1111@gmail.com');
5. Optional: create `.github/workflows/ping.yml` from `optional/ping.yml` so the free database never pauses.
