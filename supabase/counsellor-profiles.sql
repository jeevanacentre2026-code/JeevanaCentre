-- Run on an existing Supabase project to add About Us counsellor profiles.
create table if not exists public.counsellor_profiles(
  id uuid primary key default gen_random_uuid(),
  name text not null,
  name_en text,
  photo_url text,
  qualifications text not null,
  qualifications_en text,
  experience text not null,
  experience_en text,
  designation text,
  designation_en text,
  specialization text,
  specialization_en text,
  bio text,
  bio_en text,
  display_order int default 0,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table public.counsellor_profiles
  add column if not exists name_en text,
  add column if not exists qualifications_en text,
  add column if not exists experience_en text,
  add column if not exists designation text,
  add column if not exists designation_en text,
  add column if not exists specialization_en text,
  add column if not exists bio_en text,
  alter column photo_url drop not null;

alter table public.about_sections
  add column if not exists title_en text,
  add column if not exists description_en text,
  add column if not exists content_en jsonb default '{}';

create index if not exists counsellor_profiles_display_order_idx
  on public.counsellor_profiles(display_order);

drop trigger if exists trg_upd on public.counsellor_profiles;
create trigger trg_upd before update on public.counsellor_profiles
  for each row execute function set_updated_at();

alter table public.counsellor_profiles enable row level security;
drop policy if exists "admin all" on public.counsellor_profiles;
create policy "admin all" on public.counsellor_profiles
  for all to authenticated using(is_admin()) with check(is_admin());
drop policy if exists "pub" on public.counsellor_profiles;
create policy "pub" on public.counsellor_profiles
  for select using(true);

insert into storage.buckets(id,name,public,file_size_limit,allowed_mime_types)
values('counsellor-images','counsellor-images',true,5242880,
  array['image/png','image/jpeg','image/webp','image/gif','image/svg+xml'])
on conflict(id) do update set
  public=excluded.public,
  file_size_limit=excluded.file_size_limit,
  allowed_mime_types=excluded.allowed_mime_types;

drop policy if exists "counsellor images public read" on storage.objects;
create policy "counsellor images public read" on storage.objects
  for select using(bucket_id='counsellor-images');
