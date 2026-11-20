-- Run 2nd
create or replace function is_admin() returns boolean language sql security definer set search_path=public stable as $$ select exists(select 1 from admin_profiles where id=auth.uid() and role='admin') $$;
do $$ declare t text; begin foreach t in array array['site_settings','navigation_links','homepage_sections','service_categories','service_subcategories','service_content_blocks','guidance_categories','guidance_articles','about_sections','counsellor_profiles','contact_settings','footer_settings','footer_links','social_links','admin_profiles'] loop
execute format('alter table %I enable row level security',t);
execute format('create policy "admin all" on %I for all to authenticated using(is_admin()) with check(is_admin())',t);end loop;end $$;
create policy "pub" on site_settings for select using(true);create policy "pub" on contact_settings for select using(true);create policy "pub" on footer_settings for select using(true);
create policy "pub" on navigation_links for select using(is_active);create policy "pub" on footer_links for select using(is_active);create policy "pub" on social_links for select using(is_active);create policy "pub" on homepage_sections for select using(is_active);
create policy "pub" on service_categories for select using(is_published);create policy "pub" on service_subcategories for select using(is_published);create policy "pub" on guidance_categories for select using(is_published);
create policy "pub" on service_content_blocks for select using(status='published');create policy "pub" on about_sections for select using(status='published');create policy "pub" on counsellor_profiles for select using(true);
create policy "pub" on guidance_articles for select using(status='published' and (published_at is null or published_at<=now()));
create policy "own" on admin_profiles for select to authenticated using(id=auth.uid());
