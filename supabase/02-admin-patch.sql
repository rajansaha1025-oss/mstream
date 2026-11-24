-- Run ONCE in Supabase SQL Editor (no reset needed!) to enable Ban/Unban from the MStream Admin Panel.
create or replace function public.admin_set_ban(uid uuid, is_banned boolean)
returns void language plpgsql security definer set search_path = public as $$
begin
  if not public.is_admin() then
    raise exception 'Admin access required';
  end if;
  if uid = auth.uid() then
    raise exception 'You cannot ban yourself';
  end if;
  update public.profiles set banned = is_banned where id = uid;
end $$;
grant execute on function public.admin_set_ban(uuid, boolean) to authenticated;
