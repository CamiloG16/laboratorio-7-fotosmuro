-- Mi proyecto crea las tablas con RLS activado, asi que el muro necesita reglas.
-- Solo para usuarios con sesion: todos leen; cada quien escribe lo suyo.

alter table public.profiles enable row level security;
drop policy if exists "perfiles visibles para usuarios con sesion" on public.profiles;
create policy "perfiles visibles para usuarios con sesion" on public.profiles
  for select to authenticated using (true);
drop policy if exists "cada quien actualiza su perfil" on public.profiles;
create policy "cada quien actualiza su perfil" on public.profiles
  for update to authenticated
  using ((select auth.uid()) = id) with check ((select auth.uid()) = id);

alter table public.posts enable row level security;
drop policy if exists "posts visibles para usuarios con sesion" on public.posts;
create policy "posts visibles para usuarios con sesion" on public.posts
  for select to authenticated using (true);
drop policy if exists "cada quien publica sus posts" on public.posts;
create policy "cada quien publica sus posts" on public.posts
  for insert to authenticated with check ((select auth.uid()) = profile_id);
drop policy if exists "cada quien edita sus posts" on public.posts;
create policy "cada quien edita sus posts" on public.posts
  for update to authenticated
  using ((select auth.uid()) = profile_id) with check ((select auth.uid()) = profile_id);
drop policy if exists "cada quien borra sus posts" on public.posts;
create policy "cada quien borra sus posts" on public.posts
  for delete to authenticated using ((select auth.uid()) = profile_id);

alter table public.likes enable row level security;
drop policy if exists "likes visibles para usuarios con sesion" on public.likes;
create policy "likes visibles para usuarios con sesion" on public.likes
  for select to authenticated using (true);
drop policy if exists "cada quien da su like" on public.likes;
create policy "cada quien da su like" on public.likes
  for insert to authenticated with check ((select auth.uid()) = profile_id);
drop policy if exists "cada quien cambia su like" on public.likes;
create policy "cada quien cambia su like" on public.likes
  for update to authenticated
  using ((select auth.uid()) = profile_id) with check ((select auth.uid()) = profile_id);
drop policy if exists "cada quien quita su like" on public.likes;
create policy "cada quien quita su like" on public.likes
  for delete to authenticated using ((select auth.uid()) = profile_id);
