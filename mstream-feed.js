// TikTok-style full-screen vertical swipe feed (works in demo and cloud mode).
(function () {
  const isVid = u => /\.(mp4|webm|mov)(\?|#|$)/i.test(u || '');
  let ov = null, muted = true;
  let mode = 'foryou';
  const num = v => { const t = String(v || 0); return (parseFloat(t) * (/K$/i.test(t) ? 1e3 : /M$/i.test(t) ? 1e6 : 1)) || 0; };
  const score = r => (r.likes || 0) * 2 + num(r.views) * .1 + (r.boosted ? 100 : 0) + Math.random() * 10;
  function ranked() { let a = state.reels.filter(r => !r.hidden); if (mode === 'following') a = a.filter(r => state.following.includes(r.creator)); return a.sort((x, y) => score(y) - score(x)); }
  function close() { if (ov) { ov.querySelectorAll('video').forEach(v => v.pause()); ov.remove(); ov = null; } }
  function open() {
    const items = ranked();
    if (!items.length) { showToast(mode === 'following' ? 'Follow creators to fill this feed.' : 'No reels yet.'); mode = 'foryou'; return; }
    ov = document.createElement('div'); ov.className = 'fixed inset-0 z-[60] bg-black';
    ov.innerHTML = '<div class="absolute top-3 inset-x-0 z-10 flex justify-center gap-2 pointer-events-none"><button data-feed-mode="following" class="pointer-events-auto px-3 h-10 rounded-full text-sm text-white ' + (mode === 'following' ? 'bg-white/40 font-bold' : 'bg-white/15') + '">Following</button><button data-feed-mode="foryou" class="pointer-events-auto px-3 h-10 rounded-full text-sm text-white ' + (mode === 'foryou' ? 'bg-white/40 font-bold' : 'bg-white/15') + '">For You</button></div><button data-feed-close aria-label="Close" class="absolute top-3 right-3 z-10 w-10 h-10 rounded-full bg-white/25 text-white text-2xl leading-none">×</button><button data-feed-mute aria-label="Sound" class="absolute top-3 left-3 z-10 px-3 h-10 rounded-full bg-white/25 text-white text-sm">🔇</button><div class="h-full overflow-y-scroll snap-y snap-mandatory no-scrollbar">' +
      items.map(r => '<section class="snap-start h-full w-full relative flex items-center justify-center">' +
        (isVid(r.videoUrl) ? '<video src="' + escapeHtml(r.videoUrl) + '" poster="' + escapeHtml(r.thumb) + '" loop playsinline muted preload="metadata" class="h-full w-full object-contain"></video>'
          : '<img src="' + escapeHtml(r.thumb) + '" alt="" class="h-full w-full object-contain opacity-80"><span class="absolute top-16 text-xs text-white/80 bg-black/50 px-3 py-1 rounded-full">No playable video link</span>') +
        '<div class="absolute bottom-0 inset-x-0 p-4 pb-8 bg-gradient-to-t from-black/80 to-transparent text-white pointer-events-none"><button data-profile="' + escapeHtml(r.creator) + '" class="text-sm font-bold underline pointer-events-auto">@' + escapeHtml(r.creator) + '</button><div class="text-sm">' + escapeHtml(r.title) + '</div></div>' +
        '<div class="absolute right-3 bottom-28 flex flex-col items-center gap-1 text-white"><button data-feed-like="' + escapeHtml(r.id) + '" class="w-12 h-12 rounded-full bg-white/25 text-xl" aria-label="Like">' + (r.liked ? '❤️' : '🤍') + '</button><span class="text-xs" data-lc>' + r.likes + '</span></div></section>').join('') + '</div>';
    document.body.appendChild(ov);
    const io = new IntersectionObserver(es => es.forEach(en => {
      const v = en.target.querySelector('video'); if (!v) return;
      if (en.isIntersecting) { v.muted = muted; v.play().catch(() => {}); } else v.pause();
    }), { threshold: 0.6 });
    ov.querySelectorAll('section').forEach(s => io.observe(s));
  }
  document.addEventListener('click', e => {
    if (e.target.closest('[data-open-feed]')) { open(); return; }
    if (!ov) return;
    const md = e.target.closest('[data-feed-mode]'); if (md) { mode = md.dataset.feedMode; close(); open(); return; }
    if (e.target.closest('[data-feed-close]')) { close(); return; }
    const mu = e.target.closest('[data-feed-mute]');
    if (mu) { muted = !muted; ov.querySelectorAll('video').forEach(v => { v.muted = muted; }); mu.textContent = muted ? '🔇' : '🔊'; return; }
    const lk = e.target.closest('[data-feed-like]');
    if (lk) {
      const r = state.reels.find(x => x.id === lk.dataset.feedLike); if (!r) return;
      r.liked = !r.liked; r.likes += r.liked ? 1 : -1;
      if (window.MCloud && MCloud.enabled && String(r.id).startsWith('cloud_')) MCloud.like(r.id, r.liked);
      saveState(); lk.textContent = r.liked ? '❤️' : '🤍'; lk.parentElement.querySelector('[data-lc]').textContent = r.likes; return;
    }
    const v = e.target.closest('video'); if (v) { if (v.paused) v.play(); else v.pause(); }
  });
  document.addEventListener('keydown', e => { if (e.key === 'Escape') close(); });
})();
