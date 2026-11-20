-- Run after schema.sql in the Supabase SQL Editor.
-- Adds public site-content tables to Realtime without changing admin_profiles.
do $$
declare
  table_name text;
  required_tables text[] := array[
    'site_settings',
    'navigation_links',
    'homepage_sections',
    'service_categories',
    'service_subcategories',
    'service_content_blocks',
    'guidance_categories',
    'guidance_articles',
    'about_sections',
    'counsellor_profiles',
    'contact_settings',
    'footer_settings',
    'footer_links',
    'social_links'
  ];
  missing_tables text;
begin
  if not exists (select 1 from pg_publication where pubname = 'supabase_realtime') then
    raise exception 'Supabase Realtime publication is missing. Enable Realtime for this project first.';
  end if;

  select string_agg(required.table_name, ', ')
    into missing_tables
    from unnest(required_tables) as required(table_name)
    where to_regclass(format('public.%I', required.table_name)) is null;

  if missing_tables is not null then
    raise exception 'Missing public tables: %. Run supabase/schema.sql first.', missing_tables;
  end if;

  foreach table_name in array required_tables loop
    if not exists (
      select 1
      from pg_publication_tables
      where pubname = 'supabase_realtime'
        and schemaname = 'public'
        and tablename = table_name
    ) then
      execute format('alter publication supabase_realtime add table public.%I', table_name);
    end if;
  end loop;
end
$$;
