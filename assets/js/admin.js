const sb=supabase.createClient(SB_URL,SB_KEY),$=(s,e=document)=>e.querySelector(s),root=$('#root');
const esc=s=>String(s??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
const toast=(m,e)=>{const t=document.createElement('div');t.className='toast'+(e?' err':'');t.textContent=m;document.body.append(t);setTimeout(()=>t.remove(),3500)};
let dirty=false;addEventListener('beforeunload',e=>{if(dirty){e.preventDefault();e.returnValue=''}});
const PUB={k:'is_published',t:'bool'},ACT={k:'is_active',t:'bool'},ST={k:'status',t:'sel',o:['draft','published']};
const M={
service_categories:{l:'Service Categories',c:['title','slug','is_published'],o:1,f:[{k:'title',r:1},{k:'slug'},{k:'description',t:'ta'},{k:'image_url',t:'img',b:'service-images'},PUB]},
service_subcategories:{l:'Service Subcategories',c:['title','is_published'],o:1,f:[{k:'category_id',t:'fk',ref:'service_categories',r:1},{k:'title',r:1},{k:'slug'},{k:'description',t:'ta'},PUB]},
service_content_blocks:{l:'Service Content Blocks',c:['title','block_type','status'],o:1,f:[{k:'category_id',l:'Service category',t:'fk',ref:'service_categories',r:1},{k:'content.html',t:'rich'},ST]},
guidance_categories:{l:'Guidance Categories',c:['title','slug','is_published'],o:1,f:[{k:'title',r:1},{k:'slug'},{k:'description',t:'ta'},PUB]},
guidance_articles:{l:'Guidance Articles',c:['title','status','is_featured'],o:1,view:'../article.html?slug=',f:[{k:'category_id',t:'fk',ref:'guidance_categories'},{k:'title',r:1},{k:'slug'},{k:'short_description',t:'ta'},{k:'content',t:'rich'},{k:'featured_image',t:'img',b:'guidance-images'},{k:'seo_title'},{k:'seo_description',t:'ta'},{k:'is_featured',t:'bool'},{k:'published_at',t:'date'},ST]},
about_sections:{l:'About Us',c:['title','status'],o:1,f:[{k:'title',l:'Title (Tamil / primary)',r:1},{k:'title_en',l:'Title (English)'},{k:'description',l:'Description (Tamil / primary)',t:'ta'},{k:'description_en',l:'Description (English)',t:'ta'},{k:'content.html',l:'Rich content (Tamil / primary)',t:'rich'},{k:'content_en.html',l:'Rich content (English)',t:'rich'},{k:'image_url',t:'img',b:'about-images'},{k:'content.gallery',t:'lines',b:'gallery-images'},ST]},
counsellor_profiles:{l:'Counsellor Profiles',c:['name','designation','qualifications','experience','specialization'],o:1,f:[{k:'name',l:'Name (Tamil / primary)',r:1},{k:'name_en',l:'Name (English)'},{k:'photo_url',l:'Profile photo',t:'img',b:'counsellor-images'},{k:'qualifications',l:'Qualifications (Tamil / primary)',t:'ta',r:1},{k:'qualifications_en',l:'Qualifications (English)',t:'ta'},{k:'designation',l:'Professional designation (Tamil / primary)',t:'ta',r:1},{k:'designation_en',l:'Professional designation (English)',t:'ta'},{k:'experience',l:'Experience (Tamil / primary)',t:'ta',r:1},{k:'experience_en',l:'Experience (English)',t:'ta'},{k:'specialization',l:'Specialization (Tamil / primary)',t:'ta'},{k:'specialization_en',l:'Specialization (English)',t:'ta'},{k:'bio',l:'Short description (Tamil / primary)',t:'ta'},{k:'bio_en',l:'Short description (English)',t:'ta'}]},
homepage_sections:{l:'Home Page',c:['section_key','section_title','is_active'],o:1,f:[{k:'section_key',t:'sel',o:['hero','intro','services','why','articles','about','contact'],r:1},{k:'section_title'},{k:'section_description',t:'ta'},{k:'section_content',t:'json'},{k:'image_url',t:'img',b:'website-assets'},ACT],hint:'hero content: {"badge","btn1","btn1_url","btn2","btn2_url"}; why: {"items":[{"icon","title","desc"}]}; services: {"ids":[category uuids]}'},
navigation_links:{l:'Navigation Links',c:['title','url','is_active'],o:1,f:[{k:'title',r:1},{k:'url',r:1},ACT]},
footer_links:{l:'Footer Links',c:['title','url','is_active'],o:1,f:[{k:'title',r:1},{k:'url',r:1},ACT]},
social_links:{l:'Social Links',c:['platform','url','is_active'],o:1,f:[{k:'platform',t:'sel',o:['Facebook','Instagram','YouTube','X','LinkedIn','WhatsApp','Telegram'],r:1},{k:'url',r:1},ACT]},
contact_settings:{l:'Contact Settings',one:1,f:['phone','whatsapp','email',{k:'address',t:'ta'},'google_maps_url','working_days','working_hours']},
footer_settings:{l:'Footer Settings',one:1,f:[{k:'footer_description',t:'ta'},'copyright_text',{k:'footer_logo',t:'img',b:'website-assets'}]},
site_settings:{l:'Website Settings',one:1,f:['website_name',{k:'website_logo',t:'img',b:'website-assets'},{k:'favicon',t:'img',b:'website-assets'},'tamil_slogan','default_seo_title',{k:'default_seo_description',t:'ta'},{k:'social_image',t:'img',b:'website-assets'},'primary_color','secondary_color']}};
Object.values(M).forEach(m=>m.f=m.f.map(x=>typeof x==='string'?{k:x}:x));
const CORE_NAV=[['dashboard','Dashboard'],['service_categories'],['service_content_blocks']];
const SETTINGS_NAV=[['homepage_sections'],['about_sections'],['counsellor_profiles'],['contact_settings'],['footer_settings'],['navigation_links'],['footer_links'],['social_links'],['site_settings'],['profile','Admin Profile']];
const getp=(o,k)=>k.split('.').reduce((a,p)=>a?.[p],o);const setp=(o,k,v)=>{const p=k.split('.');p.slice(0,-1).forEach(x=>o=o[x]??={});o[p.at(-1)]=v};
const slug=s=>s.trim().toLowerCase().replace(/\s+/g,'-').replace(/[^\p{L}\p{N}\p{M}-]/gu,'')||crypto.randomUUID().slice(0,8);
async function boot(){const{data:{session}}=await sb.auth.getSession();if(!session)return login();
const{data:p,error:profileError}=await sb.from('admin_profiles').select('id,role').eq('id',session.user.id).maybeSingle();
if(profileError){login(`Could not verify administrator access: ${profileError.message}`);return}
if(!p||p.role!=='admin'){await sb.auth.signOut();login('Signed in, but this Auth user has no administrator profile. Add its matching user ID to admin_profiles in Supabase.');return}
document.body.classList.remove('login-page');
root.innerHTML=`<div class="shell"><div class="mobile-bar"><strong>Counselling Admin</strong><button id="nav-toggle" aria-label="Open navigation menu" aria-controls="admin-sidebar" aria-expanded="false">☰</button></div><div class="nav-overlay" id="nav-overlay" hidden></div><aside id="admin-sidebar"><div class="aside-heading"><h2>Counselling Admin</h2><button id="nav-close" aria-label="Close navigation menu">×</button></div><div class="nav-box nav-core">${CORE_NAV.map(([k,l])=>`<a data-r="${k}">${l||M[k].l}</a>`).join('')}</div><details class="nav-box nav-settings" id="settings-menu"><summary>Settings</summary><div class="settings-links">${SETTINGS_NAV.map(([k,l])=>`<a data-r="${k}">${l||M[k].l}</a>`).join('')}</div></details><a id="lo">Logout</a></aside><main id="mn"></main></div>`;
const shell=$('.shell'),sidebar=$('#admin-sidebar'),toggle=$('#nav-toggle'),overlay=$('#nav-overlay'),mobileNav=matchMedia('(max-width:760px)');
const setNavOpen=open=>{const visible=open&&mobileNav.matches;shell.classList.toggle('nav-open',visible);toggle.setAttribute('aria-expanded',String(visible));toggle.setAttribute('aria-label',visible?'Close navigation menu':'Open navigation menu');sidebar.setAttribute('aria-hidden',String(mobileNav.matches&&!visible));sidebar.inert=mobileNav.matches&&!visible;overlay.hidden=!visible;document.body.style.overflow=visible?'hidden':'';if(visible)$('#nav-close').focus();else if(mobileNav.matches&&sidebar.contains(document.activeElement))toggle.focus()};
setNavOpen(false);
toggle.onclick=()=>setNavOpen(toggle.getAttribute('aria-expanded')!=='true');
$('#nav-close').onclick=()=>setNavOpen(false);overlay.onclick=()=>setNavOpen(false);
addEventListener('keydown',e=>{if(e.key==='Escape'&&shell.classList.contains('nav-open'))setNavOpen(false)});
addEventListener('resize',()=>setNavOpen(false));
$('#lo').onclick=async()=>{await sb.auth.signOut();location.reload()};
root.onclick=e=>{const a=e.target.closest('[data-r]');if(a){if(dirty&&!confirm('You have unsaved changes. Leave this page?'))return;dirty=false;location.hash='/'+a.dataset.r;setNavOpen(false)}};
addEventListener('hashchange',route);route(session.user)}
function login(msg){document.body.classList.add('login-page');root.innerHTML=`<div class="login card"><h2>Admin Login</h2>${msg?`<p class="login-error">${esc(msg)}</p>`:''}<label for="em">Email</label><input id="em" type="email" autocomplete="username"><label for="pw">Password</label><div class="password-field"><input id="pw" type="password" autocomplete="current-password"><button id="pw-toggle" class="password-toggle" type="button" aria-label="Show password" aria-pressed="false" title="Show password"><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M2 12s3.6-7 10-7 10 7 10 7-3.6 7-10 7S2 12 2 12Z"></path><circle cx="12" cy="12" r="3"></circle><path class="eye-slash" d="m3 3 18 18"></path></svg></button></div><p class="login-actions"><button id="go" type="button">Log in</button></p></div>`;
const password=$('#pw'),toggle=$('#pw-toggle');
toggle.onclick=()=>{const visible=password.type==='password';password.type=visible?'text':'password';toggle.setAttribute('aria-pressed',String(visible));toggle.setAttribute('aria-label',visible?'Hide password':'Show password');toggle.title=visible?'Hide password':'Show password'};
$('#go').onclick=async()=>{const{error}=await sb.auth.signInWithPassword({email:$('#em').value,password:password.value});error?toast(error.message,1):boot()}}
async function route(u){const[t,id]=(location.hash.slice(2)||'dashboard').split('/');document.querySelectorAll('aside a').forEach(a=>a.classList.toggle('on',a.dataset.r===t));const settings=$('#settings-menu');if(settings)settings.open=SETTINGS_NAV.some(([key])=>key===t);
const mn=$('#mn');try{if(t==='dashboard')return dash(mn);if(t==='profile')return prof(mn);const m=M[t];if(!m)return;m.one?single(mn,t,m):id?form(mn,t,m,id):list(mn,t,m)}catch(e){toast(e.message,1)}}
async function dash(mn){const c=async(t,f=x=>x)=>(await f(sb.from(t).select('*',{count:'exact',head:true}))).count??0;
const S=[['Service categories',await c('service_categories')],['Published content blocks',await c('service_content_blocks',f=>f.eq('status','published'))],['About sections',await c('about_sections')]];
mn.innerHTML=`<h1>Dashboard</h1><div class="stats">${S.map(s=>`<div class="card"><b>${s[1]}</b>${s[0]}</div>`).join('')}</div>`}
async function prof(mn){const{data:{user}}=await sb.auth.getUser();mn.innerHTML=`<h1>Admin Profile</h1><div class="card"><p>Email: <b>${esc(user.email)}</b></p></div>`}
async function list(mn,t,m){const{data,error}=await sb.from(t).select('*').order(m.o?'display_order':'created_at',{ascending:!!m.o});if(error)return toast(error.message,1);let rows=data;const cols=m.c.filter(c=>c!=='slug');
const draw=()=>{mn.innerHTML=`<div class="row"><h1>${m.l}</h1><button id="ad">Add new</button></div>${m.hint?`<p>${esc(m.hint)}</p>`:''}<div class="card" style="overflow:auto"><table><tr>${m.o?'<th></th>':''}${cols.map(c=>`<th>${c.replace(/_/g,' ')}</th>`).join('')}<th>Actions</th></tr>${rows.map(r=>`<tr data-id="${r.id}" ${m.o?'draggable="true"':''}>${m.o?'<td>⠿</td>':''}${cols.map(c=>{const v=r[c];return`<td>${typeof v==='boolean'?`<span class="pill ${v?'pub':''}">${v?'Yes':'No'}</span>`:c==='status'?`<span class="pill ${v==='published'?'pub':''}">${v}</span>`:esc(v)}</td>`}).join('')}<td><button class="s" data-e>Edit</button> <button class="s" data-d>Duplicate</button> ${m.view?`<a class="btn s" target="_blank" href="${m.view+encodeURIComponent(r.slug)}">Preview</a> `:''}<button class="r" data-x>Delete</button></td></tr>`).join('')||`<tr><td colspan="${cols.length+1+(m.o?1:0)}">Nothing here yet. Click "Add new" to create the first item.</td></tr>`}</table></div>`;
$('#ad').onclick=()=>location.hash=`/${t}/new`;
mn.querySelectorAll('tr[data-id]').forEach(tr=>{const id=tr.dataset.id;
tr.querySelector('[data-e]').onclick=()=>location.hash=`/${t}/${id}`;
tr.querySelector('[data-x]').onclick=async()=>{if(!confirm('Delete this item permanently?'))return;const{error}=await sb.from(t).delete().eq('id',id);error?toast(error.message,1):(toast('Deleted.'),list(mn,t,m))};
tr.querySelector('[data-d]').onclick=async()=>{const{id:_,created_at,updated_at,...c}=rows.find(r=>r.id===id);if(c.slug)c.slug+='-copy-'+Math.random().toString(36).slice(2,6);if(c.title)c.title+=' (copy)';if(c.status)c.status='draft';if(c.is_published)c.is_published=false;const{error}=await sb.from(t).insert(c);error?toast(error.message,1):(toast('Duplicated.'),list(mn,t,m))};
if(m.o){tr.ondragstart=e=>e.dataTransfer.setData('t',id);tr.ondragover=e=>{e.preventDefault();tr.classList.add('ov')};tr.ondragleave=()=>tr.classList.remove('ov');
tr.ondrop=async e=>{e.preventDefault();const f=e.dataTransfer.getData('t');if(f===id)return;const a=rows.findIndex(r=>r.id===f);const[x]=rows.splice(a,1);rows.splice(rows.findIndex(r=>r.id===id),0,x);
const res=await Promise.all(rows.map((r,i)=>sb.from(t).update({display_order:i+1}).eq('id',r.id)));res.find(r=>r.error)?toast('Reorder failed.',1):toast('Order saved.');draw()}}})};draw()}
async function upload(file,bucket){if(!/^image\/(png|jpe?g|webp|gif|svg\+xml)$/.test(file.type))throw Error('Only PNG, JPG, WEBP, GIF or SVG images are allowed.');if(file.size>5*1048576)throw Error('Image must be smaller than 5 MB.');
const ext=file.name.split('.').pop().toLowerCase().replace(/[^a-z0-9]/g,''),path=`${Date.now()}-${crypto.randomUUID().slice(0,8)}.${ext}`;
const{error}=await sb.storage.from(bucket).upload(path,file,{cacheControl:'31536000'});if(error)throw error;return sb.storage.from(bucket).getPublicUrl(path).data.publicUrl}
async function fields(t,m,row){const fk={};for(const f of m.f)if(f.t==='fk'){const sel=f.ref==='service_subcategories'?'*,service_categories(title)':'*';const{data}=await sb.from(f.ref).select(sel).order('display_order');fk[f.k]=data||[]}
return m.f.map(f=>{const v=getp(row,f.k);if(f.k==='slug')return`<input type="hidden" data-k="slug" value="${esc(v)}">`;const l=(f.l||f.k.replace('content.','').replace(/_/g,' '))+(f.r?' *':''),a=`data-k="${f.k}" data-t="${f.t||''}"`;let i;
switch(f.t){case'ta':i=`<textarea ${a}>${esc(v)}</textarea>`;break;
case'bool':return`<label><input type="checkbox" ${a} ${v?'checked':''}> ${l}</label>`;
case'sel':i=`<select ${a}><option value=""></option>${f.o.map(o=>`<option ${o===v?'selected':''}>${o}</option>`).join('')}</select>`;break;
case'fk':i=`<select ${a}><option value=""></option>${fk[f.k].map(o=>`<option value="${o.id}" ${o.id===v?'selected':''}>${esc(o.service_categories?o.service_categories.title+' › ':'')}${esc(o.title)}</option>`).join('')}</select>`;break;
case'rich':i=`<div class="tb">${[['bold','B'],['italic','I'],['insertUnorderedList','• List'],['h3','H']].map(c=>`<button type="button" class="s" data-cmd="${c[0]}">${c[1]}</button>`).join('')}</div><div class="rich" contenteditable="true" ${a}>${v||''}</div>`;break;
case'img':i=`<input type="file" accept="image/*" data-up="${f.b}" ${a} data-v="${esc(v)}">${v?`<img class="prev" src="${esc(v)}" alt="">`:''}<button type="button" class="s" data-clr>Remove image</button>`;break;
case'lines':i=`<textarea ${a} placeholder="One image URL per line">${esc((v||[]).join('\n'))}</textarea><input type="file" accept="image/*" multiple data-gal="${f.b}">`;break;
case'json':i=`<textarea ${a}>${esc(JSON.stringify(v??{},null,1))}</textarea>`;break;
case'date':i=`<input type="date" ${a} value="${v?String(v).slice(0,10):''}">`;break;
default:i=`<input ${a} value="${esc(v)}">`}return`<label>${l}</label>${i}`}).join('')}
function wire(box){box.oninput=()=>dirty=true;box.onclick=e=>{if(e.target.closest('[data-clr]')){const inp=e.target.parentElement.querySelector('[data-up]');inp.dataset.v='';inp.value='';e.target.parentElement.querySelectorAll('.prev').forEach(p=>p.remove());dirty=true}};
box.querySelectorAll('.tb').forEach(tb=>{const editor=tb.nextElementSibling;let savedRange=null;
const remember=()=>{const sel=getSelection();if(sel?.rangeCount&&editor.contains(sel.anchorNode)&&editor.contains(sel.focusNode))savedRange=sel.getRangeAt(0).cloneRange()};
['keyup','mouseup','input','focus','blur'].forEach(type=>editor.addEventListener(type,remember));
const applyCommand=button=>{const command=button.dataset.cmd;editor.focus();const sel=getSelection();if(savedRange&&sel){sel.removeAllRanges();sel.addRange(savedRange)}const range=sel?.rangeCount?sel.getRangeAt(0):null;
if(command==='bold'&&(!range||range.collapsed||!editor.contains(range.commonAncestorContainer))){toast('Select only the words you want to make bold.',1);return}
if(command==='h3')document.execCommand('formatBlock',false,'<h3>');else document.execCommand(command);remember();dirty=true};
tb.addEventListener('PointerEvent'in window?'pointerdown':'mousedown',e=>{const button=e.target.closest('[data-cmd]');if(button){remember();e.preventDefault();applyCommand(button)}});
tb.onclick=e=>{const button=e.target.closest('[data-cmd]');if(button&&e.detail===0){e.preventDefault();applyCommand(button)}}});
box.querySelectorAll('.rich').forEach(r=>r.onpaste=e=>{e.preventDefault();r.focus();document.execCommand('insertText',false,e.clipboardData.getData('text/plain'));dirty=true});
box.onchange=async e=>{const el=e.target;try{if(el.dataset.up&&el.files[0]){el.dataset.v=await upload(el.files[0],el.dataset.up);let p=el.parentElement.querySelector('.prev');if(!p){p=document.createElement('img');p.className='prev';el.after(p)}p.src=el.dataset.v;toast('Image uploaded.')}
if(el.dataset.gal){const ta=el.previousElementSibling;for(const f of el.files)ta.value+=(ta.value?'\n':'')+await upload(f,el.dataset.gal);toast('Images uploaded.')}}catch(x){toast(x.message,1);el.value=''}dirty=true}}
function collect(box,m){const o={},bad=[];m.f.forEach(f=>{const el=box.querySelector(`[data-k="${CSS.escape(f.k)}"]`);let v;
if(f.t==='bool')v=el.checked;else if(f.t==='rich')v=el.innerHTML;else if(f.t==='img')v=el.dataset.v||null;else if(f.t==='lines')v=el.value.split('\n').map(s=>s.trim()).filter(Boolean);
else if(f.t==='json'){try{v=JSON.parse(el.value||'{}')}catch{bad.push(f.k+' must be valid JSON')}}else v=el.value.trim()||null;
if(f.r&&(v==null||v===''))bad.push(f.k.replace(/_/g,' ')+' is required');setp(o,f.k,v)});return{o,bad}}
async function form(mn,t,m,id){const{data:row}=id==='new'?{data:{}}:await sb.from(t).select('*').eq('id',id).single();
mn.innerHTML=`<h1>${id==='new'?'Add':'Edit'} — ${m.l}</h1><div class="card" id="fm">${await fields(t,m,row||{})}<p><button id="sv">Save</button> <button class="s" id="cn">Cancel</button></p></div>`;wire($('#fm'));
$('#cn').onclick=()=>{if(dirty&&!confirm('Discard unsaved changes?'))return;dirty=false;location.hash='/'+t};
$('#sv').onclick=async()=>{const{o,bad}=collect($('#fm'),m);if(bad.length)return toast(bad[0],1);
if('slug'in o&&!o.slug)o.slug=slug(o.title||'');
if(t==='service_content_blocks'){const{data:category,error:categoryError}=await sb.from('service_categories').select('id,title,description').eq('id',o.category_id).single();if(categoryError)return toast(categoryError.message,1);
let{data:sub,error:subError}=await sb.from('service_subcategories').select('id').eq('category_id',category.id).order('display_order').limit(1).maybeSingle();if(subError)return toast(subError.message,1);
if(!sub){const created=await sb.from('service_subcategories').insert({category_id:category.id,title:category.title,slug:'details',description:category.description,display_order:1,is_published:true}).select('id').single();if(created.error)return toast(created.error.message,1);sub=created.data}
o.subcategory_id=sub.id;o.title=category.title;o.block_type=row?.block_type||'paragraph'}
if(t==='guidance_articles'&&o.status==='published'&&!o.published_at)o.published_at=new Date().toISOString();
if(m.o&&id==='new'){const{data:mx}=await sb.from(t).select('display_order').order('display_order',{ascending:false}).limit(1);o.display_order=(mx?.[0]?.display_order||0)+1}
const{error}=id==='new'?await sb.from(t).insert(o):await sb.from(t).update(o).eq('id',id);
if(error)return toast(error.message,1);dirty=false;toast('Saved.');location.hash='/'+t}}
async function single(mn,t,m){let{data}=await sb.from(t).select('*').limit(1);let row=data?.[0];if(!row){const r=await sb.from(t).insert({}).select().single();row=r.data}
mn.innerHTML=`<h1>${m.l}</h1><div class="card" id="fm">${await fields(t,m,row)}<p><button id="sv">Save changes</button></p></div>`;wire($('#fm'));
$('#sv').onclick=async()=>{const{o,bad}=collect($('#fm'),m);if(bad.length)return toast(bad[0],1);const{error}=await sb.from(t).update(o).eq('id',row.id);error?toast(error.message,1):(dirty=false,toast('Saved.'))}}
boot();
