-- Run 3rd
insert into storage.buckets(id,name,public,file_size_limit,allowed_mime_types) select b,b,true,5242880,array['image/png','image/jpeg','image/webp','image/gif','image/svg+xml'] from unnest(array['website-assets','service-images','guidance-images','about-images','gallery-images','counsellor-images']) b on conflict(id) do nothing;
create policy "public read" on storage.objects for select using(bucket_id in('website-assets','service-images','guidance-images','about-images','gallery-images','counsellor-images'));
create policy "admin write" on storage.objects for insert to authenticated with check(is_admin());
create policy "admin update" on storage.objects for update to authenticated using(is_admin());
create policy "admin delete" on storage.objects for delete to authenticated using(is_admin());
