alter table public.posts add column if not exists image_path text;

drop policy if exists "post-images: usuarios autenticados" on storage.objects;
create policy "post-images: usuarios autenticados"
on storage.objects for all to authenticated
using (bucket_id = 'post-images')
with check (bucket_id = 'post-images');
