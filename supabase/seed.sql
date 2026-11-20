-- Run after schema.sql, policies.sql and storage-policies.sql.
-- Adds JEEVANA's Tamil content without overwriting existing service edits.
begin;

create temporary table jeevana_topics (
  slug text primary key,
  title text not null,
  subheading text not null,
  description text not null,
  details text not null,
  display_order int not null
) on commit drop;

insert into jeevana_topics(slug,title,subheading,description,details,display_order) values
('pre-post-marital-life','திருமணத்திற்கு முன் / பின் வாழ்க்கை அணுகுமுறை','திருமண வாழ்க்கைக்கான புரிதலும் தயாரிப்பும்','திருமண வாழ்க்கைக்கான புரிதல், தயாரிப்பு மற்றும் இணக்கத்திற்கு வழிகாட்டுதல்.',$$
<ul>
<li>திருமணம் தொடர்பாக வரன் மற்றும் பெற்றோரிடையே புரிந்துணர்வை ஏற்படுத்துதல்.</li>
<li>திருமண பந்தத்திற்கு உடல் மற்றும் மனரீதியாகத் தயார்படுத்துதல்.</li>
<li>திருமண நிகழ்வு மற்றும் திருமண வாழ்க்கை குறித்த விழிப்புணர்வை உருவாக்குதல்.</li>
<li>கணவன்–மனைவி உறவில் உருவாகும் மாற்றங்களைப் புரிந்துகொண்டு தீர்வை நோக்கிய வழிகாட்டுதல்.</li>
<li>குடும்ப மற்றும் திருமணப் பிணக்குகளைச் சீர்செய்து இணக்கத்தை உருவாக்குதல்.</li>
<li>கடந்தகால நிகழ்வுகளிலிருந்து மீண்டு புத்துணர்வுடன் புதிய வாழ்க்கையை ஏற்றுக்கொள்ளுதல்.</li>
</ul>$$,1),
('mindset-joy-clarity','மனநிலையில் மகிழ்ச்சி / தெளிவு','மகிழ்ச்சியும் மனத் தெளிவும்','மகிழ்ச்சியான மனநிலையையும் தெளிவான சிந்தனையையும் வளர்க்க உதவும் வழிகாட்டுதல்.',$$
<ul>
<li>சந்தோஷமும் உற்சாகமும் நிறைந்த நாட்களை அமைத்துக்கொள்ளுதல்.</li>
<li>தனிமை மற்றும் வீண் கவலைகளைக் குறைத்து உற்சாகம் பெறுதல்.</li>
<li>எதிர்மறை எண்ணங்களைக் குறைத்து தெளிவாகச் சிந்திக்கும் திறனை வளர்த்தல்.</li>
<li>மனச்சுமையைக் குறைத்து மகிழ்ச்சியான மனநிலையை உருவாக்குதல்.</li>
<li>மனதை ஒருநிலைப்படுத்தி விழிப்புணர்வைப் பயிற்றுவித்தல்.</li>
</ul>$$,2),
('approach-hesitation','அணுகுமுறையில் தயக்கம்','துணிவுடன் அணுகுதல்','புதிய மனிதர்கள், உறவுகள் மற்றும் சூழ்நிலைகளை அணுகும் துணிவை வளர்த்தல்.',$$
<ul>
<li>புதிய மனிதர்கள், உறவுகள் மற்றும் சூழ்நிலைகளை அணுகும்போது ஏற்படும் தயக்கத்தைக் குறைத்துத் துணிவை வளர்த்தல்.</li>
<li>மனதில் உள்ளதை வெளிப்படுத்த இயலாமையை மாற்றுதல்.</li>
<li>விளைவுகளை எண்ணிப் பின்வாங்கும் மனநிலையை மாற்றித் தைரியத்தை வளர்த்தல்.</li>
<li>தாழ்வு மனப்பான்மையைக் குறைத்துத் தன்னம்பிக்கையை ஊக்குவித்தல்.</li>
<li>உணர்வுகளை வெளிப்படுத்த முடியாத தவிப்பைக் குறைத்தல்.</li>
</ul>$$,3),
('decision-making','முடிவெடுப்பதில் குழப்பம்','தெளிவான முடிவெடுக்கும் திறன்','முக்கிய முடிவுகளைத் தெளிவாகவும் பொறுப்புடனும் எடுக்க உதவும் வழிகாட்டுதல்.',$$
<ul>
<li>திருமணம், வேலை, தொழில், சொத்து மற்றும் முதலீடு தொடர்பான முக்கிய முடிவுகளை நிர்வகித்தல்.</li>
<li>இரண்டு அல்லது அதற்கு மேற்பட்ட தரப்புகளுக்காக முடிவெடுக்கும்போது நடுநிலையைக் கையாளுதல்.</li>
<li>சுயமாக முடிவெடுக்கும் திறனை வளர்த்தல்.</li>
<li>முடிவெடுப்பதைத் தள்ளிப்போடும் பழக்கத்தை மாற்றுதல்.</li>
<li>எடுத்த முடிவில் தடுமாற்றமின்றி உறுதியுடன் செயல்படுதல்.</li>
</ul>$$,4),
('confronting-fear','எதிர்கொள்வதில் அச்சம்','சிக்கல்களைத் துணிவுடன் எதிர்கொள்ளுதல்','சிக்கல்களையும் உரையாடல்களையும் துணிவுடன் எதிர்கொள்ளும் திறனை வளர்த்தல்.',$$
<ul>
<li>பிரச்சினைகளை நேருக்கு நேர் சந்திக்காமல் தவிர்க்கும் மனப்பான்மையில் மாற்றம் ஏற்படுத்துதல்.</li>
<li>விவாதித்தல், எதிர்த்தல், தட்டிக்கேட்டல் போன்ற தருணங்களில் ஏற்படும் பதற்றத்தைச் சீராக்குதல்.</li>
<li>உண்மையை உரைக்காமல் சமாளிக்கும் சந்தர்ப்பவாத மனப்போக்கை மாற்றுதல்.</li>
<li>எதிர்ப்பு வரும் என அஞ்சி வாய்ப்புகளைத் தவறவிடும் தயக்கத்தைப் போக்கித் துணிவை வளர்த்தல்.</li>
<li>பாதுகாப்பற்ற உணர்விலிருந்து மீண்டு தன்னம்பிக்கையுடன் செயல்படுதல்.</li>
</ul>$$,5),
('anxiety-consequences','விளைவுகள் குறித்த கவலை','கவலைகளையும் அதீத சிந்தனையையும் கையாளுதல்','குற்ற உணர்வு, அதீத சிந்தனை மற்றும் எதிர்காலக் கவலைகளைக் கையாள உதவும் வழிகாட்டுதல்.',$$
<ul>
<li>தன் தனித்தன்மையை அறியாமையால் உருவாகும் தாழ்வு மனப்பான்மையைப் போக்குதல்.</li>
<li>தெரிந்தோ தெரியாமலோ செய்த தவறின் குற்ற உணர்விலிருந்து மீளுதல்.</li>
<li>தன் கருத்தை வெளிப்படுத்த முடியாத பயத்தை அகற்றுதல்.</li>
<li>கற்பனை மற்றும் அதீத சிந்தனையால் உண்டாகும் விரக்தியிலிருந்து மீளுதல்.</li>
<li>கடந்தகால மற்றும் எதிர்காலச் சிந்தனைகளைச் சீர்படுத்தி நிகழ்காலத்தில் வாழ உதவுதல்.</li>
</ul>$$,6),
('expectation-disappointment','எதிர்பார்ப்புகளில் ஏமாற்றம்','எதிர்பார்ப்புகளைச் சமநிலைப்படுத்துதல்','நிறைவேறாத எதிர்பார்ப்புகளையும் உறவு சார்ந்த வருத்தங்களையும் கையாளுதல்.',$$
<ul>
<li>குடும்ப மற்றும் சமூகச் சூழலில் அன்பும் மரியாதையும் கிடைக்காத வருத்தத்திலிருந்து மீளுதல்.</li>
<li>எதிர்பார்த்தபடி அமையாத வாழ்க்கைத்துணை, வேலை, வருமானம் போன்றவற்றைச் சுமுகமாகக் கையாளுதல்.</li>
<li>தன்னைப் புரிந்துகொள்ளாத உறவு மற்றும் நட்பு சார்ந்த வருத்தத்திற்கு மாற்றுவழி காணுதல்.</li>
<li>தனக்கே துன்பம், நினைப்பது எதுவும் நடப்பதில்லை என்ற மனப்போக்கை மாற்றுதல்.</li>
<li>மற்றவர்களுடன் தன்னை ஒப்பிடும் பழக்கத்தை மாற்றுதல்.</li>
</ul>$$,7),
('self-esteem','சுயமதிப்பை உயர்த்துதல்','தன்னம்பிக்கையும் சுயமதிப்பும்','தன்னம்பிக்கை, சுயமதிப்பு மற்றும் நேர்மறையான வெளிப்பாட்டை வளர்த்தல்.',$$
<ul>
<li>பழக்கவழக்கங்களில் மாற்றங்களை ஏற்படுத்திச் சுயமதிப்பை உயர்த்துதல்.</li>
<li>சுயக்கட்டுப்பாட்டுப் பயிற்சிகள் மூலம் நன்மதிப்பைப் பெருக்குதல்.</li>
<li>குணத்திற்கேற்ப வெளிப்பாட்டில் மாற்றம் செய்து சுயமெருகை மேம்படுத்துதல்.</li>
<li>தாழ்வு மனப்பான்மையைக் குறைத்துத் தன்னம்பிக்கையை உருவாக்குதல்.</li>
<li>பேச்சு மற்றும் செயல்பாட்டுத் திறன்களைக் கற்றல்.</li>
</ul>$$,8),
('relationship-harmony','உறவுமுறைகளில் இணக்கம்','உறவுகளில் புரிதலும் இணக்கமும்','தம்பதியர், குடும்பம் மற்றும் நட்பு உறவுகளில் இணக்கத்தை வளர்த்தல்.',$$
<ul>
<li>தம்பதிகளிடையே உருவாகும் கருத்து வேறுபாடுகளைச் சீர்செய்து இணக்கமான சூழலை உருவாக்குதல்.</li>
<li>குடும்ப உறவுகளில் ஏற்படும் வெறுப்புணர்வைத் தணித்து அமைதியை உருவாக்குதல்.</li>
<li>உறவுப் படிநிலைகளைச் சுமுகமாகக் கையாளும் திறனைப் பழக்குதல்.</li>
<li>அன்பு மற்றும் பாச உணர்வுகளை வெளிப்படுத்த இயலாமையால் ஏற்படும் விரிசல், விரக்தியிலிருந்து மீளுதல்.</li>
<li>பிரிவை நோக்கிச் சென்ற உறவில் தன்நிலையை உணர்ந்து தெளிவான முடிவெடுக்க உதவுதல்.</li>
</ul>$$,9),
('family-workplace-management','குடும்ப / பணியிடச் சூழல் மேலாண்மை','குடும்பம் மற்றும் பணியிடச் சமநிலை','குடும்பம் மற்றும் பணியிடப் பொறுப்புகளைச் சமநிலையுடன் கையாளுதல்.',$$
<ul>
<li>குடும்ப மற்றும் பணியிடக் கோபங்களை வேறு இடங்களில் வெளிப்படுத்துவதைத் தவிர்த்தல்.</li>
<li>உருவான சிக்கலில் தன் பங்கை உணர்ந்து பொறுப்புடன் கையாளுதல்.</li>
<li>பணம், கடமை, நேரம் ஆகியவற்றைச் சமநிலையுடன் நிர்வகித்தல்.</li>
<li>பொறுப்புணர்வில் ஏற்படும் ஏற்ற இறக்கங்களைக் கையாளுதல்.</li>
<li>குழந்தை வளர்ப்பு, பணிப் பகிர்வு, குடும்ப நிர்வாகம் குறித்து வழிகாட்டுதல்.</li>
<li>சரிவிகித ஆளுமை வளர்ச்சிக்கு உதவுதல்.</li>
<li>இயல்பாகப் பழகுதல், நேர்மறைக் கண்ணோட்டம், சமநிலைப் போக்கு போன்ற திறன்களை வளர்த்தல்.</li>
</ul>$$,10);

insert into site_settings(website_name,tamil_slogan,default_seo_title,default_seo_description)
select 'JEEVANA | ஜீவனா வாழ்வியல் வழிகாட்டு மையம்',
       'வாழ்க்கைச் சிக்கல்களை எதிர்கொண்டு மகிழ்ச்சியை நிலைநிறுத்த வழிகாட்டுதல்.',
       'ஜீவனா வாழ்வியல் வழிகாட்டு மையம்',
       'திருமண வாழ்க்கை, குடும்ப உறவுகள், பணியிடம், சுற்றம் மற்றும் நட்பில் ஏற்படும் சிக்கல்களுக்கான வாழ்வியல் வழிகாட்டுதல்.'
where not exists(select 1 from site_settings);

update site_settings
set website_name='JEEVANA | ஜீவனா வாழ்வியல் வழிகாட்டு மையம்',
    tamil_slogan='வாழ்க்கைச் சிக்கல்களை எதிர்கொண்டு மகிழ்ச்சியை நிலைநிறுத்த வழிகாட்டுதல்.',
    default_seo_title='ஜீவனா வாழ்வியல் வழிகாட்டு மையம்',
    default_seo_description='திருமண வாழ்க்கை, குடும்ப உறவுகள், பணியிடம், சுற்றம் மற்றும் நட்பில் ஏற்படும் சிக்கல்களுக்கான வாழ்வியல் வழிகாட்டுதல்.'
where website_name in ('ஆலோசனை மையம்','JEEVANA | ஜீவனா வாழ்வியல் வழிகாட்டு மையம்');

insert into contact_settings(phone,email)
select '','' where not exists(select 1 from contact_settings);
insert into footer_settings(footer_description,copyright_text)
select 'திருமண வாழ்க்கை, குடும்ப உறவுகள், பணியிடம், சுற்றம் மற்றும் நட்பில் ஏற்படும் சிக்கல்களை எதிர்கொள்ள வாழ்வியல் வழிகாட்டுதல்.',
       '© JEEVANA ஜீவனா வாழ்வியல் வழிகாட்டு மையம்'
where not exists(select 1 from footer_settings);
update footer_settings
set footer_description='திருமண வாழ்க்கை, குடும்ப உறவுகள், பணியிடம், சுற்றம் மற்றும் நட்பில் ஏற்படும் சிக்கல்களை எதிர்கொள்ள வாழ்வியல் வழிகாட்டுதல்.',
    copyright_text='© JEEVANA ஜீவனா வாழ்வியல் வழிகாட்டு மையம்'
where footer_description in ('கல்வி, தொழில், குடும்பம் மற்றும் தனிப்பட்ட வளர்ச்சிக்கான வழிகாட்டுதல்.','திருமண வாழ்க்கை, குடும்ப உறவுகள், பணியிடம், சுற்றம் மற்றும் நட்பில் ஏற்படும் சிக்கல்களை எதிர்கொள்ள வாழ்வியல் வழிகாட்டுதல்.');

insert into navigation_links(title,url,display_order)
select v.title,v.url,v.display_order
from (values
 ('முகப்பு','index.html',1),
 ('எங்களைப் பற்றி','about.html',2),
 ('வாழ்வியல் வழிகாட்டுதல்','services.html',3),
 ('தொடர்புக்கு','contact.html',4)
) as v(title,url,display_order)
where not exists(select 1 from navigation_links);
insert into footer_links(title,url,display_order)
select n.title,n.url,n.display_order from navigation_links n
where not exists(select 1 from footer_links);
update navigation_links set title='வாழ்வியல் வழிகாட்டுதல்',display_order=3
where title='ஆலோசனை சேவைகள்' and url='services.html';
update navigation_links set is_active=false
where title='வழிகாட்டுதல்' and url='guidance.html';
update footer_links set title='வாழ்வியல் வழிகாட்டுதல்',display_order=3
where title='ஆலோசனை சேவைகள்' and url='services.html';
update footer_links set is_active=false
where title='வழிகாட்டுதல்' and url='guidance.html';

insert into homepage_sections(section_key,section_title,section_description,section_content,image_url,display_order,is_active)
select v.section_key,v.section_title,v.section_description,v.section_content::jsonb,v.image_url,v.display_order,v.is_active
from (values
 ('hero','சவால்களைத் தாண்டி, மகிழ்ச்சியுடன் வாழ்வோம்','வாழ்க்கைச் சூழல்களைப் புரிந்துகொண்டு, தெளிவான முடிவுகளுடன் மகிழ்ச்சியை நிலைநிறுத்த உங்களுக்கான வழிகாட்டுதல்.','{"badge":"ஜீவனா வாழ்வியல் வழிகாட்டு மையம்","btn1":"வழிகாட்டுதலைப் பெறுங்கள்","btn1_url":"contact.html","btn2":"எங்கள் சேவைகள்","btn2_url":"services.html","trust":"உங்கள் வாழ்க்கைச் சவால்களைப் புரிந்துகொள்ளும் ஆதரவு","callout":"உங்கள் மகிழ்ச்சி முக்கியம்","callout_text":"சூழல் சிக்கல்களை ஒன்றாகக் கையாள்வோம்."}','https://images.unsplash.com/photo-1545389336-cf090694435e?auto=format&fit=crop&w=1000&q=85',1,true),
 ('services','வாழ்க்கையின் பல பரிமாணங்களுக்கான வழிகாட்டுதல்',null,'{"slugs":["pre-post-marital-life","mindset-joy-clarity","approach-hesitation","decision-making"]}',null,2,true),
 ('articles','வழிகாட்டுதல் கட்டுரைகள்',null,'{}',null,5,false),
 ('about','எங்களைப் பற்றி','<p>ஜீவனா வாழ்வியல் வழிகாட்டு மையம் திருமண வாழ்க்கை, குடும்ப உறவுகள், பணியிடம், சுற்றம் மற்றும் நட்பு சார்ந்த சவால்களைப் புரிந்துகொண்டு, மகிழ்ச்சியும் தெளிவும் நிலைநிறுத்த வழிகாட்டுகிறது.</p>','{}','https://images.unsplash.com/photo-1545389336-cf090694435e?auto=format&fit=crop&w=1000&q=85',6,true),
 ('contact','தொடர்புக்கு',null,'{}',null,7,true)
) as v(section_key,section_title,section_description,section_content,image_url,display_order,is_active)
where not exists(select 1 from homepage_sections);

update homepage_sections
set section_title='சவால்களைத் தாண்டி, மகிழ்ச்சியுடன் வாழ்வோம்',
    section_description='வாழ்க்கைச் சூழல்களைப் புரிந்துகொண்டு, தெளிவான முடிவுகளுடன் மகிழ்ச்சியை நிலைநிறுத்த உங்களுக்கான வழிகாட்டுதல்.',
    section_content='{"badge":"ஜீவனா வாழ்வியல் வழிகாட்டு மையம்","btn1":"வழிகாட்டுதலைப் பெறுங்கள்","btn1_url":"contact.html","btn2":"எங்கள் சேவைகள்","btn2_url":"services.html","trust":"உங்கள் வாழ்க்கைச் சவால்களைப் புரிந்துகொள்ளும் ஆதரவு","callout":"உங்கள் மகிழ்ச்சி முக்கியம்","callout_text":"சூழல் சிக்கல்களை ஒன்றாகக் கையாள்வோம்."}',
    image_url=coalesce(image_url,'https://images.unsplash.com/photo-1545389336-cf090694435e?auto=format&fit=crop&w=1000&q=85'),
    display_order=1
where section_key='hero'
  and section_title in ('சிறந்த மனம். சிறந்த எதிர்காலம்.','மனநலம் சிறந்தால், வாழ்க்கையும் சிறக்கும்.','சவால்களைத் தாண்டி, மகிழ்ச்சியுடன் வாழ்வோம்');
update homepage_sections
set section_title='வாழ்க்கையின் பல பரிமாணங்களுக்கான வழிகாட்டுதல்',
    section_content='{"slugs":["pre-post-marital-life","mindset-joy-clarity","approach-hesitation","decision-making"]}',
    display_order=2
where section_key='services' and section_title in ('எங்கள் சேவைகள்','வாழ்க்கையின் பல பரிமாணங்களுக்கான வழிகாட்டுதல்');
update homepage_sections set is_active=false where section_key='why';
update homepage_sections set is_active=false where section_key='intro';
insert into homepage_sections(section_key,section_title,section_description,section_content,image_url,display_order,is_active)
select 'about','எங்களைப் பற்றி',
       '<p>ஜீவனா வாழ்வியல் வழிகாட்டு மையம் திருமண வாழ்க்கை, குடும்ப உறவுகள், பணியிடம், சுற்றம் மற்றும் நட்பு சார்ந்த சவால்களைப் புரிந்துகொண்டு, மகிழ்ச்சியும் தெளிவும் நிலைநிறுத்த வழிகாட்டுகிறது.</p>',
       '{}','https://images.unsplash.com/photo-1545389336-cf090694435e?auto=format&fit=crop&w=1000&q=85',6,true
where not exists(select 1 from homepage_sections where section_key='about');
update homepage_sections
set is_active=true,
    image_url=coalesce(image_url,'https://images.unsplash.com/photo-1545389336-cf090694435e?auto=format&fit=crop&w=1000&q=85')
where section_key='about';
update homepage_sections set is_active=false
where section_key='articles' and section_title='வழிகாட்டுதல் கட்டுரைகள்'
  and not exists(select 1 from guidance_articles where status='published' and slug<>'sample-article');

insert into about_sections(title,description,content,image_url,display_order,status)
select 'ஜீவனா வாழ்வியல் வழிகாட்டு மையம்',
       'வாழ்க்கைச் சவால்களைக் கடந்து மகிழ்ச்சியை நிலைநிறுத்துவதற்கான வாழ்வியல் வழிகாட்டுதல்.',
       jsonb_build_object('html','<p>திருமண வாழ்க்கை, குடும்ப உறவுகள், பணிபுரியும் இடம், சுற்றம் மற்றும் நட்பு ஆகியவற்றில் சந்தர்ப்பங்களால் உண்டாகும் சங்கடங்களைக் கடந்து செல்லவும், சூழல் சிக்கல்களை எதிர்கொண்டு மீளவும், வாழ்வின் இலக்கான மகிழ்ச்சியை நிலைநிறுத்தவும் சரியான வழிகாட்டுதல் வழங்கும் மையம் இதுவாகும்.</p>'),
       'https://images.unsplash.com/photo-1545389336-cf090694435e?auto=format&fit=crop&w=1000&q=85',
       1,'published'
where not exists(select 1 from about_sections);
update about_sections
set image_url=coalesce(image_url,'https://images.unsplash.com/photo-1545389336-cf090694435e?auto=format&fit=crop&w=1000&q=85')
where title='ஜீவனா வாழ்வியல் வழிகாட்டு மையம்'
  and description='வாழ்க்கைச் சவால்களைக் கடந்து மகிழ்ச்சியை நிலைநிறுத்துவதற்கான வாழ்வியல் வழிகாட்டுதல்.'
  and image_url is null;

-- Hide only the known built-in demo categories, not edited or uploaded categories.
update service_categories set is_published=false
where image_url is null and (
 (slug='educational' and title in ('கல்வி ஆலோசனை','தனிநபர் ஆலோசனை')
   and (description is null or description='உங்கள் உணர்வுகளையும் சவால்களையும் புரிந்துகொண்டு, உங்களுக்கேற்ற வழியை கண்டறியுங்கள்.')) or
 (slug='personal' and title in ('தனிப்பட்ட வாழ்க்கை ஆலோசனை','தம்பதியர் ஆலோசனை')
   and (description is null or description='ஒருவரையொருவர் புரிந்துகொண்டு, உறவில் ஆரோக்கியமான உரையாடலை வளர்த்திடுங்கள்.')) or
 (slug='family' and title='குடும்ப ஆலோசனை'
   and (description is null or description='குடும்ப உறவுகளை வலுப்படுத்தவும், சவால்களை ஒன்றாக எதிர்கொள்ளவும் ஆதரவு.')) or
 (slug='career' and title='தொழில் வழிகாட்டுதல்'
   and (description is null or description='உங்கள் திறன்களுக்கும் இலக்குகளுக்கும் ஏற்ற அடுத்த படியைத் திட்டமிடுங்கள்.')) or
 (slug='relationship' and title='உறவுகள் தொடர்பான ஆலோசனை' and description is null) or
 (slug='mental-wellness' and title='மனநல வழிகாட்டுதல்' and description is null) or
 (slug='personality' and title='தனித்திறன் மற்றும் ஆளுமை மேம்பாடு' and description is null)
);

insert into service_categories(title,slug,description,display_order,is_published)
select t.title,t.slug,t.description,t.display_order,true
from jeevana_topics t
on conflict(slug) do nothing;

update service_subcategories s
set title=t.subheading,description=t.description
from jeevana_topics t
join service_categories c on c.slug=t.slug
where s.category_id=c.id and s.slug='details'
  and s.title='வழிகாட்டுதல் விவரங்கள்';

delete from service_subcategories s
using service_categories c
where s.category_id=c.id and c.slug='educational'
  and s.slug='course-selection'
  and s.title='தனிநபர் ஆலோசனை அமர்வு'
  and s.description is null;

insert into service_subcategories(category_id,title,slug,description,display_order,is_published)
select c.id,t.subheading,'details',t.description,1,true
from jeevana_topics t
join service_categories c on c.slug=t.slug
where not exists(
 select 1 from service_subcategories s where s.category_id=c.id and s.slug='details'
);

update service_content_blocks b
set title=c.title
from service_categories c
join service_subcategories s on s.category_id=c.id
join jeevana_topics t on t.slug=c.slug
where b.category_id=c.id and b.subcategory_id=s.id
  and s.slug='details' and b.block_type='paragraph'
  and b.title='வழிகாட்டுதல்';

insert into service_content_blocks(category_id,subcategory_id,block_type,title,content,status,display_order)
select c.id,s.id,'paragraph',t.title,jsonb_build_object('html',t.details),'published',1
from jeevana_topics t
join service_categories c on c.slug=t.slug
join service_subcategories s on s.category_id=c.id and s.slug='details'
where not exists(
 select 1 from service_content_blocks b where b.subcategory_id=s.id
);

update guidance_articles set status='draft',is_featured=false
where slug='sample-article' and title='மாதிரி கட்டுரை';
update guidance_categories c set is_published=false
where c.slug in ('students','awareness')
  and c.title in ('மாணவர்களுக்கான வழிகாட்டுதல்','மனநல விழிப்புணர்வு')
  and not exists(
    select 1 from guidance_articles a
    where a.category_id=c.id and a.slug<>'sample-article' and a.status='published'
  );

drop table jeevana_topics;
commit;
