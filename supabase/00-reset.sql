-- ONLY if you have OLD MStream tables. This deletes all old MStream data. Then run 01-schema.sql.
drop trigger if exists on_auth_user_created on auth.users;
drop table if exists public.reports, public.post_views, public.comments, public.withdrawals, public.wallet_entries, public.dms, public.follows, public.payments, public.messages, public.likes, public.posts, public.profiles cascade;
drop function if exists public.follower_count(text), public.add_view(bigint), public.add_comment(bigint,text), public.request_withdraw(text,text,int), public.wallet_balance(), public.send_dm(text,text), public.claim_name(text), public.is_banned(), public.is_admin(), public.is_guest(), public.apply_boost(), public.refund_withdrawal(), public.my_role(), public.handle_new_user() cascade;
