alter table public.profiles add column if not exists avatar_path text;

drop policy if exists "avatars: usuarios autenticados" on storage.objects;
create policy "avatars: usuarios autenticados"
on storage.objects for all to authenticated
using (bucket_id = 'avatars')
with check (bucket_id = 'avatars');
