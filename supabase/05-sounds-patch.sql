-- MStream v6 Sounds Patch: Run ONCE in Supabase SQL Editor (no data deleted).
-- Adds sound_title and sound_url columns to public.posts so Reels support Auto-Songs and "Use This Sound".

alter table public.posts add column if not exists sound_title text;
alter table public.posts add column if not exists sound_url text;
