// MStream cloud layer (Supabase). Inactive until APP_CONFIG.supabaseUrl + supabaseKey are set.
(function () {
  document.addEventListener('click', e => {
    const b = e.target.closest('[data-report-reel]'); if (!b) return;
    if (window.MCloud && MCloud.report) MCloud.report(b.dataset.reportReel); else showToast('Report received (demo mode).');
  });
  const demo = document.getElementById('demoBadge');
  if (!APP_CONFIG.supabaseUrl || !APP_CONFIG.supabaseKey || !window.supabase) {
    if (demo) demo.classList.remove('hidden');
    window.MCloud = { enabled: false };
    return;
  }
  const sb = window.supabase.createClient(APP_CONFIG.supabaseUrl, APP_CONFIG.supabaseKey);
  const LISTS = { reel: 'reels', product_reel: 'reels', movie: 'movies', cartoon: 'cartoons', livetv: 'liveChannels', anime: 'animeSeries' };
  let uid = null;
  const emailBox = document.getElementById('adminEmailInput');
  if (emailBox) emailBox.classList.remove('hidden');
  // Wallet balances now live on the server; the browser-only Wallet payment option is removed.
  const walletOpt = document.querySelector('#boostPayMethod option[value="Wallet"]');
  if (walletOpt) walletOpt.remove();

  const isUuid = v => /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(v || '');
  try { const r = new URLSearchParams(location.search).get('ref'); if (isUuid(r)) localStorage.setItem('ms_ref', r); } catch (e) {}
  const hhmm = t => new Date(t).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
  const refresh = () => { saveState(); render(); };

  async function user() {
    let { data: { user: u } } = await sb.auth.getUser();
    if (!u) { const r = await sb.auth.signInAnonymously(); u = r.data && r.data.user; }
    uid = u && u.id;
    return u;
  }
  const fmtN = n => n >= 1e6 ? (n / 1e6).toFixed(1) + 'M' : n >= 1e3 ? (n / 1e3).toFixed(1) + 'K' : String(n || 0);
  let isAdmin = false;
  async function syncProfile(claim) {
    if (claim && state.currentUser.name !== 'Sajib Hasan') {
      const { data } = await sb.rpc('claim_name', { n: state.currentUser.name });
      if (data === false) showToast('The name “' + state.currentUser.name + '” is already taken. Choose another in Account.');
    }
    const { data: me } = await sb.from('profiles').select('display_name,role').eq('id', uid).single();
    if (!me) return;
    if (me.display_name) state.currentUser.name = me.display_name; else showToast('Welcome! Open Account and set your name to post and chat.');
    state.currentUser.role = me.role === 'user' ? 'user' : 'publisher'; // role is decided by the server, not the browser
    refresh();
  }
  async function adminSync() {
    isAdmin = true;
    const [h, u] = await Promise.all([sb.from('posts').select('id,kind,data').eq('hidden', true).limit(200), sb.from('profiles').select('id,display_name,role,banned').limit(500)]);
    (h.data || []).forEach(r => { const arr = state[r.kind], id = 'cloud_' + r.id; if (arr && !arr.some(x => x.id === id)) arr.push({ ...r.data, id, hidden: true }); });
    state.users = (u.data || []).filter(x => x.display_name).map(x => ({ name: x.display_name, contact: '', role: x.role === 'user' ? 'user' : 'publisher', banned: x.banned, _id: x.id, _role: x.role }));
    refresh();
  }
  async function openComments(pid) {
    const box = document.createElement('div'); box.className = 'border-t border-slate-200 pt-3';
    document.getElementById('playerMeta').appendChild(box);
    if (!String(pid).startsWith('cloud_')) { box.innerHTML = '<p class="text-xs text-slate-500">Comments are available on cloud posts.</p>'; return; }
    const n = Number(pid.replace('cloud_', '')); await user(); sb.rpc('add_view', { pid: n });
    const draw = async () => {
      const { data } = await sb.from('comments').select('author_name,text').eq('post_id', n).order('created_at', { ascending: false }).limit(50);
      box.innerHTML = '<h4 class="text-sm font-bold text-slate-900 mb-2">Comments (' + (data || []).length + ')</h4><div class="flex gap-2 mb-3"><input id="cmtInput" maxlength="300" placeholder="Add a comment..." class="flex-1 bg-slate-50 border border-slate-300 rounded-lg px-3 py-2 text-sm text-slate-900" /><button id="cmtSend" class="bg-rose-600 text-white text-sm font-semibold px-4 rounded-lg">Post</button></div>' + (data || []).map(x => '<div class="text-sm text-slate-800 mb-2"><b>' + escapeHtml(x.author_name) + '</b> ' + escapeHtml(x.text) + '</div>').join('');
      box.querySelector('#cmtSend').onclick = async () => {
        const v = box.querySelector('#cmtInput').value.trim(); if (!v) return;
        const { error } = await sb.rpc('add_comment', { pid: n, body: v }); if (error) showToast(error.message); else draw();
      };
    };
    draw();
  }
  async function refreshWallet() {
    const { data } = await sb.rpc('wallet_balance');
    Object.assign(state.wallet, { userAdEarn: data || 0, userAffiliateEarn: 0, userGiftEarn: 0 });
    refresh();
  }
  function addMsg(m) {
    const room = m.sender === uid ? m.recipient_name : m.sender_name;
    const arr = state.chats[room] || (state.chats[room] = []);
    if (arr.some(x => x.cid === m.id)) return;
    arr.push({ sender: m.sender === uid ? 'me' : 'them', text: m.text, time: hhmm(m.created_at), cid: m.id });
  }

  window.MCloud = {
    enabled: true,
    async adminLogin(email, pass) {
      const { data, error } = await sb.auth.signInWithPassword({ email, password: pass });
      if (error) return false;
      const { data: p } = await sb.from('profiles').select('role').eq('id', data.user.id).single();
      if (p && p.role === 'admin') { await adminSync(); return true; }
      await sb.auth.signOut();
      return false;
    },
    async publish(type, videoUrl) {
      if (String(videoUrl).startsWith('blob:')) { showToast('Local previews cannot be shared. Use Cloudinary upload or paste a link.'); return; }
      const u = await user(); if (!u) { showToast('Cloud sign-in failed.'); return; }
      const kind = LISTS[type];
      let item = state[kind][0];
      if (type === 'anime') item = state.animeSeries.find(a => a.episodes.some(e => e.videoUrl === videoUrl)) || item;
      const { data: row, error } = await sb.from('posts').insert({ owner: u.id, kind, data: item }).select('id').single();
      if (error) { showToast('Cloud sync failed: ' + error.message); return; }
      item.id = 'cloud_' + row.id; refresh(); showToast('Published for everyone!');
    },
    async like(postId, liked) {
      const u = await user(); if (!u) return;
      const pid = Number(String(postId).replace('cloud_', ''));
      if (liked) await sb.from('likes').insert({ post_id: pid, owner: u.id });
      else await sb.from('likes').delete().eq('post_id', pid).eq('owner', u.id);
    },
    async sendMsg(room, text, localMsg) {
      await user();
      const { data: id, error } = await sb.rpc('send_dm', { to_name: room, body: text });
      if (error) {
        const arr = state.chats[room], i = arr ? arr.indexOf(localMsg) : -1; if (i >= 0) arr.splice(i, 1); refresh();
        showToast(/not found/i.test(error.message) ? '“' + room + '” is not on MStream yet.' : 'Message not sent: ' + error.message);
      } else if (localMsg) { localMsg.cid = id; saveState(); }
    },
    refLink(reelId) { return location.origin + location.pathname + '?ref=' + uid + '&reel=' + reelId; },
    async withdraw() {
      await user();
      const { data: bal } = await sb.rpc('wallet_balance');
      const names = { bkash: 'bKash', nagad: 'Nagad', rocket: 'Rocket' };
      const m = names[(prompt('Payout method: bKash, Nagad or Rocket', 'bKash') || '').trim().toLowerCase()];
      if (!m) { showToast('Choose bKash, Nagad or Rocket.'); return; }
      const acct = (prompt('Payout number', state.currentUser.contact) || '').trim(); if (!acct) return;
      const { error } = await sb.rpc('request_withdraw', { m, acct, amt: bal || 0 });
      showToast(error ? error.message : 'Withdraw request sent. You will be paid after review.');
      refreshWallet();
    },
    async submitBoost(reel, pkg, trx) {
      if (!String(reel.id).startsWith('cloud_')) { showToast('Publish this reel to the cloud first, then boost it.'); return; }
      if (trx.length < 6) { showToast('Enter the TrxID of your payment.'); return; }
      const u = await user(); if (!u) return;
      const { error } = await sb.from('payments').insert({ owner: u.id, kind: 'boost', amount: pkg.amount, method: pkg.method, trx_id: trx,
        ref: { postId: Number(reel.id.replace('cloud_', '')), title: reel.title, boosted: { reach: pkg.reach, duration: pkg.duration, audience: pkg.audience } } });
      showToast(error ? 'Could not submit: ' + error.message : 'Payment submitted. Your boost starts after the owner verifies the TrxID.');
    },
    async submitOrder(prod, address, method) {
      const u = await user(); if (!u) return;
      let aff; try { const r = localStorage.getItem('ms_ref'); if (isUuid(r) && r !== uid) aff = r; } catch (e) {}
      const { error } = await sb.from('payments').insert({ owner: u.id, kind: 'order', amount: prod.price, method, trx_id: null,
        ref: { product: prod.name, affiliate: aff, address, buyer: state.currentUser.name, contact: state.currentUser.contact } });
      showToast(error ? 'Order failed: ' + error.message : 'Order received! The seller will contact you.');
    },
    async load() {
      await user();
      const [p, l, m] = await Promise.all([
        sb.from('posts').select('id,kind,data,view_count').eq('hidden', false).order('created_at', { ascending: false }).limit(200),
        sb.from('likes').select('post_id,owner').limit(5000),
        sb.from('dms').select('*').order('created_at', { ascending: false }).limit(300)]);
      const counts = {}, mine = new Set();
      (l.data || []).forEach(x => { counts[x.post_id] = (counts[x.post_id] || 0) + 1; if (x.owner === uid) mine.add(x.post_id); });
      (p.data || []).forEach(r => {
        const arr = state[r.kind]; if (!arr) return;
        const id = 'cloud_' + r.id, fresh = { ...r.data, id, likes: counts[r.id] || 0, liked: mine.has(r.id), views: fmtN(r.view_count) };
        if (fresh.boosted && fresh.boosted.until && new Date(fresh.boosted.until) < new Date()) delete fresh.boosted;
        const i = arr.findIndex(x => x.id === id);
        if (i >= 0) Object.assign(arr[i], { likes: fresh.likes, liked: fresh.liked, boosted: fresh.boosted, views: fresh.views }); else arr.unshift(fresh);
      });
      if (!p.error) {
        const live = new Set((p.data || []).map(r => 'cloud_' + r.id));
        Object.keys(LISTS).map(k => LISTS[k]).forEach(k => { state[k] = state[k].filter(x => !String(x.id).startsWith('cloud_') || live.has(x.id)); });
      }
      (m.data || []).reverse().forEach(addMsg);
      Object.assign(state.wallet, { adminAdCut: 0, adminOrderCut: 0, adminGiftCut: 0, adminBoostIncome: 0, withdrawals: [], boostCampaigns: [] });
      await syncProfile(true);
      const f = await sb.from('follows').select('creator');
      (f.data || []).forEach(x => { if (!state.following.includes(x.creator)) state.following.push(x.creator); });
      await refreshWallet();
      sb.channel('dms').on('postgres_changes', { event: 'INSERT', schema: 'public', table: 'dms' }, e => {
        if (e.new.sender === uid) return; addMsg(e.new); saveState(); if (state.activeTab === 'chat') render();
      }).subscribe();
    }
  };
  window.MCloud.openComments = openComments;
  window.MCloud.followers = async n => { const { data } = await sb.rpc('follower_count', { name: n }); return data || 0; };
  window.MCloud.report = async id => {
    const reason = (prompt('Why are you reporting this? (spam, nudity, copyright, other)') || '').trim(); if (!reason) return;
    await user();
    const { error } = await sb.from('reports').insert({ post_id: String(id).startsWith('cloud_') ? Number(String(id).slice(6)) : null, reporter: uid, reason: reason.slice(0, 200) });
    showToast(error ? 'Could not send report.' : 'Thanks. Our team will review this.');
  };
  const box = document.getElementById('cloudAuthBox');
  if (box) {
    box.classList.remove('hidden');
    const val = id => document.getElementById(id).value.trim();
    const fresh = () => { try { localStorage.removeItem('mstream_state_v1'); } catch (e) {} location.reload(); };
    const status = async () => { const u = await user(); document.getElementById('cloudStatus').textContent = u && u.email ? '· ' + u.email : '· Guest (this device only)'; };
    document.getElementById('btnCloudSignup').onclick = async () => {
      const u = await user(), cred = { email: val('cloudEmail'), password: document.getElementById('cloudPass').value };
      const r = u && u.is_anonymous ? await sb.auth.updateUser(cred) : await sb.auth.signUp(cred);
      showToast(r.error ? r.error.message : 'Account saved. If asked, confirm the email we sent.'); status();
    };
    document.getElementById('btnCloudLogin').onclick = async () => {
      const r = await sb.auth.signInWithPassword({ email: val('cloudEmail'), password: document.getElementById('cloudPass').value });
      if (r.error) showToast(r.error.message); else fresh();
    };
    document.getElementById('btnCloudGoogle').onclick = async () => {
      const r = await sb.auth.signInWithOAuth({ provider: 'google', options: { redirectTo: location.origin + location.pathname } });
      if (r.error) showToast(r.error.message);
    };
    document.getElementById('btnCloudLogout').onclick = async () => { await sb.auth.signOut(); fresh(); };
    status();
  }
  const sw = document.getElementById('btnQuickSwitchRole'); if (sw) sw.style.display = 'none';
  document.addEventListener('click', e => {
    if (!isAdmin) return;
    const role = e.target.closest('[data-admin-toggle-role]'), ban = e.target.closest('[data-admin-toggle-ban]'),
      hide = e.target.closest('[data-admin-hide]'), del = e.target.closest('[data-admin-delete]');
    setTimeout(async () => {
      if (role || ban) {
        const u = state.users[parseInt((role || ban).dataset.adminToggleRole || (role || ban).dataset.adminToggleBan, 10)];
        if (!u || !u._id || u._role === 'admin') return;
        const { error } = await sb.from('profiles').update(role ? { role: u.role } : { banned: u.banned }).eq('id', u._id);
        if (error) showToast('Not saved: ' + error.message);
      } else if (hide || del) {
        const [kind, id] = (hide || del).dataset[hide ? 'adminHide' : 'adminDelete'].split(':');
        if (!String(id).startsWith('cloud_')) return;
        const pid = Number(id.slice(6)), it = (state[kind] || []).find(x => x.id === id);
        const { error } = hide ? await sb.from('posts').update({ hidden: !!(it && it.hidden) }).eq('id', pid) : await sb.from('posts').delete().eq('id', pid);
        if (error) showToast('Not saved: ' + error.message);
      }
    }, 0);
  });
  window.MCloud.load();
  document.addEventListener('click', e => {
    const b = e.target.closest('[data-follow-creator]'); if (!b) return;
    const name = b.dataset.followCreator;
    setTimeout(async () => {
      const u = await user(); if (!u) return;
      if (state.following.includes(name)) await sb.from('follows').insert({ owner: u.id, creator: name });
      else await sb.from('follows').delete().eq('owner', u.id).eq('creator', name);
    }, 0);
  });
  const af = document.getElementById('authForm');
  if (af) af.addEventListener('submit', () => setTimeout(() => syncProfile(true), 400));
})();
