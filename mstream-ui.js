// Basic dark mode, Bangla UI, and creator profile pages.
(function () {
  const BN = { 'Reels & Shop': 'রিলস ও শপ', 'Movies': 'মুভি', 'Live TV': 'লাইভ টিভি', 'Cartoon': 'কার্টুন', 'Anime Series': 'অ্যানিমে সিরিজ', 'Chat & Call': 'চ্যাট ও কল', 'Games': 'গেমস', 'Get APK': 'APK নিন', 'Upload': 'আপলোড', 'Account': 'অ্যাকাউন্ট', 'Publisher Studio': 'পাবলিশার স্টুডিও',
    'Active Role:': 'বর্তমান ভূমিকা:', 'Normal User (Reels Only)': 'সাধারণ ইউজার (শুধু রিলস)', 'Verified Publisher (All Uploads Unlocked)': 'ভেরিফাইড পাবলিশার', 'Buy Now': 'এখনই কিনুন', '+ Follow': '+ ফলো', 'Following': 'ফলো করছেন', 'For You': 'আপনার জন্য', 'Boost': 'বুস্ট', 'Boosted': 'বুস্টেড', 'Send': 'পাঠান',
    'Publish to MStream': 'MStream-এ প্রকাশ করুন', 'Reels & Shoppable Short Videos': 'রিলস ও শপযোগ্য শর্ট ভিডিও', 'Movies Section': 'মুভি সেকশন', '▶ Swipe Mode': '▶ সোয়াইপ মোড', 'Privacy Policy': 'গোপনীয়তা নীতি', 'Terms & Takedown': 'শর্তাবলি ও কনটেন্ট সরানো',
    'Install App Now (1-Tap PWA)': 'এখনই অ্যাপ ইনস্টল করুন', 'Free Games': 'ফ্রি গেমস', 'Play instantly. No download or sign-up needed.': 'সরাসরি খেলুন। ডাউনলোড বা সাইন-আপ লাগবে না।', 'Play': 'খেলুন', 'Advertisement': 'বিজ্ঞাপন', 'Decline': 'না', 'Accept': 'ঠিক আছে', 'Comments': 'মন্তব্য', 'Post': 'পোস্ট', 'Log in': 'লগ ইন', 'Log out': 'লগ আউট', 'Save / Sign up': 'সেভ / সাইন আপ',
    'Search reels, movies, anime, live TV, products...': 'রিল, মুভি, অ্যানিমে, লাইভ টিভি, পণ্য খুঁজুন...', 'Search reels, movies, live TV...': 'রিল, মুভি, লাইভ টিভি খুঁজুন...', 'Type a message...': 'মেসেজ লিখুন...' };
  let lang = 'en', dark = false;
  try { lang = localStorage.getItem('ms_lang') || 'en'; dark = localStorage.getItem('ms_dark') === '1'; } catch (e) {}
  const st = document.createElement('style');
  const M = ':is(img,video,iframe,canvas)', R = 'filter:invert(1) hue-rotate(180deg)';
  st.textContent = 'html.dark{' + R + '}html.dark ' + M + ',html.dark .bg-black,html.dark .bg-slate-900,html.dark .bg-slate-950,html.dark .brand-grad{' + R + '}html.dark :is(.bg-black,.bg-slate-900,.bg-slate-950,.brand-grad) ' + M + '{filter:none}';
  document.head.appendChild(st); document.documentElement.classList.toggle('dark', dark);
  if (lang === 'bn') document.documentElement.lang = 'bn';
  const trNode = n => { const t = n.nodeValue.trim(); if (BN[t]) n.nodeValue = n.nodeValue.replace(t, BN[t]); };
  function tr(root) {
    if (lang !== 'bn') return;
    if (root.nodeType === 3) { trNode(root); return; }
    if (root.nodeType !== 1) return;
    const w = document.createTreeWalker(root, NodeFilter.SHOW_TEXT); let n; while ((n = w.nextNode())) trNode(n);
    [root, ...root.querySelectorAll('[placeholder]')].forEach(e => { const p = e.getAttribute && BN[e.getAttribute('placeholder')]; if (p) e.setAttribute('placeholder', p); });
  }
  tr(document.body); new MutationObserver(ms => ms.forEach(m => m.addedNodes.forEach(tr))).observe(document.body, { childList: true, subtree: true });
  const bar = document.getElementById('btnOpenApk').parentElement;
  const mk = (id, label, aria, fn) => { const b = document.createElement('button'); b.id = id; b.textContent = label; b.setAttribute('aria-label', aria); b.className = 'bg-white hover:bg-slate-100 border border-slate-300 text-slate-800 text-xs font-semibold px-2.5 py-2 rounded-lg'; b.onclick = fn; bar.prepend(b); };
  mk('btnLang', lang === 'bn' ? 'EN' : 'বাং', 'Language', () => { try { localStorage.setItem('ms_lang', lang === 'bn' ? 'en' : 'bn'); } catch (e) {} location.reload(); });
  mk('btnTheme', dark ? '☀️' : '🌙', 'Theme', e => { dark = !dark; try { localStorage.setItem('ms_dark', dark ? '1' : '0'); } catch (x) {} document.documentElement.classList.toggle('dark', dark); e.currentTarget.textContent = dark ? '☀️' : '🌙'; });
  // ---- creator profile
  async function openProfile(name) {
    const reels = state.reels.filter(r => !r.hidden && r.creator === name), likes = reels.reduce((a, r) => a + (+r.likes || 0), 0);
    const u = (state.users || []).find(x => x.name === name) || {}; let fol = state.following.includes(name) ? 1 : 0;
    if (window.MCloud && MCloud.followers) fol = await MCloud.followers(name);
    const old = document.getElementById('profileOverlay'); if (old) old.remove();
    const ov = document.createElement('div'); ov.id = 'profileOverlay'; ov.className = 'fixed inset-0 z-[70] bg-white overflow-y-auto';
    ov.innerHTML = '<div class="max-w-3xl mx-auto p-4"><button data-profile-close class="float-right w-9 h-9 rounded-full bg-slate-100 text-xl leading-none" aria-label="Close">×</button><div class="flex items-center gap-4 mb-5"><div class="w-20 h-20 rounded-full brand-grad flex items-center justify-center text-3xl font-extrabold text-white">' + escapeHtml((name || '?')[0]) + '</div><div><h2 class="text-xl font-extrabold text-slate-900">@' + escapeHtml(name) + '</h2><p class="text-xs text-slate-500">' + (u.role === 'publisher' ? 'Verified Publisher' : 'Creator') + '</p><p class="text-sm text-slate-700 mt-1"><b>' + reels.length + '</b> videos · <b>' + fol + '</b> followers · <b>' + likes + '</b> likes</p></div></div>' +
      (name !== state.currentUser.name ? '<button data-follow-creator="' + escapeHtml(name) + '" class="mb-5 px-4 py-2 rounded-lg text-sm font-semibold bg-indigo-600 text-white">' + (state.following.includes(name) ? 'Following' : '+ Follow') + '</button>' : '') +
      '<div class="grid grid-cols-3 gap-2">' + (reels.map(r => '<button data-profile-play="' + escapeHtml(r.id) + '" class="relative aspect-[9/14] rounded-xl overflow-hidden bg-slate-900"><img src="' + escapeHtml(r.thumb) + '" alt="" class="w-full h-full object-cover"><span class="absolute bottom-1 left-1 text-[11px] text-white bg-black/50 rounded px-1">▶ ' + escapeHtml(r.views) + '</span></button>').join('') || '<p class="col-span-3 text-sm text-slate-500">No videos yet.</p>') + '</div></div>';
    document.body.appendChild(ov);
  }
  document.addEventListener('click', e => {
    const p = e.target.closest('[data-profile]'); if (p) { e.stopPropagation(); openProfile(p.dataset.profile); return; }
    const ov = document.getElementById('profileOverlay'); if (!ov) return;
    if (e.target.closest('[data-profile-close]')) { ov.remove(); return; }
    const pp = e.target.closest('[data-profile-play]');
    if (pp) { const r = state.reels.find(x => x.id === pp.dataset.profilePlay); if (r) { ov.remove(); openPlayer({ badge: 'REEL', title: r.title, subtitle: 'By @' + r.creator + ' • ' + r.views + ' views', thumb: r.thumb, videoUrl: r.videoUrl, postId: r.id }); } return; }
    const f = e.target.closest('[data-follow-creator]'); if (f) setTimeout(() => { f.textContent = state.following.includes(f.dataset.followCreator) ? 'Following' : '+ Follow'; }, 50);
  }, true);
  const me = document.createElement('button'); me.type = 'button'; me.className = 'w-full mt-3 text-xs font-semibold text-indigo-700 underline'; me.textContent = 'My Profile';
  me.onclick = () => { document.getElementById('authModal').classList.add('hidden'); openProfile(state.currentUser.name); };
  document.querySelector('#authModal form').after(me);
})();
