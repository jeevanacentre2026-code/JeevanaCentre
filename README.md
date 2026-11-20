# Counselling & Guidance Website (Tamil public site + English admin)
Vanilla HTML/CSS/JS + Supabase. No build step.

## Setup
1. Create a Supabase project. In **SQL Editor** run, in order: `supabase/schema.sql`, `policies.sql`, `storage-policies.sql`, `seed.sql` for JEEVANA's Tamil homepage and 10 guidance topics, then `supabase/realtime.sql` to enable live public-page updates. On an existing setup, run `supabase/counsellor-profiles.sql`, then `supabase/realtime.sql`. Rerunning the updated `seed.sql` adds the new topics and replaces untouched starter copy; existing topic content is not overwritten.
2. Edit `assets/js/config.js` with your project URL and **anon** key (never the service role key).
3. **Create the first admin**: Authentication → Users → Add user (email + password, auto-confirm). Then run in SQL Editor:
   `insert into admin_profiles(id,email,full_name) select id,email,'Admin' from auth.users where email='YOU@EXAMPLE.COM';`
   Only users with an `admin_profiles` row can write (enforced by RLS). Turn off public sign-ups in Authentication settings.
   If login succeeds but reports that the account has no administrator profile, run this in SQL Editor using the exact email from Authentication → Users:
   `insert into public.admin_profiles(id,email,full_name) select id,email,'Admin' from auth.users where lower(email)=lower('YOUR-ADMIN-EMAIL') on conflict (id) do update set email=excluded.email,role='admin';`
4. Open `/admin/` and log in. The JEEVANA content can be edited in the dashboard. Add your logo, contact details, and any additional content.
5. Deploy: drag the folder to Netlify, or `vercel --prod` (static project, no build command). Replace `YOUR-DOMAIN` in `robots.txt`/`sitemap.xml`.

## Notes
- Admin is one single-page app (`admin/index.html`, hash routes) covering all modules.
- Tamil text is stored and rendered as-is (UTF-8). Rich text is sanitized before public display.
- Public pages subscribe to Supabase Realtime for site-content changes and refresh the open page while preserving its scroll position and relevant filters. Updates require the tables in `supabase/realtime.sql` to be in the `supabase_realtime` publication.
- Manage counsellor profiles under **Settings → Counsellor Profiles**. Add, edit, or delete profiles; upload, replace, or remove photos; and provide Tamil/primary and optional English details for names, qualifications, designation, experience, specialization, and descriptions. Profiles appear directly below the handshake image in the Home and About Us sections; drag rows to change their display order. The **About Us** editor also has optional English title, description, and rich-content fields.
- Block types: heading, paragraph, article, image, image_text, gallery (one URL per line or upload), video (YouTube URL), multi_section, custom.
- Not implemented by design: appointments, testimonials, enquiry forms, payments.
- Not yet tested against a live Supabase project; verify after configuring credentials.
