// Free instant games (original, self-hosted) + optional licensed embeds via APP_CONFIG.externalGames.
(function () {
  let cleanup = null;
  function swipe(el, cb) {
    let sx, sy;
    const a = e => { sx = e.touches[0].clientX; sy = e.touches[0].clientY; };
    const b = e => { const dx = e.changedTouches[0].clientX - sx, dy = e.changedTouches[0].clientY - sy; if (Math.max(Math.abs(dx), Math.abs(dy)) < 24) return; cb(Math.abs(dx) > Math.abs(dy) ? (dx > 0 ? 'right' : 'left') : (dy > 0 ? 'down' : 'up')); };
    el.addEventListener('touchstart', a, { passive: true }); el.addEventListener('touchend', b);
    return () => { el.removeEventListener('touchstart', a); el.removeEventListener('touchend', b); };
  }
  function snake(el) {
    el.innerHTML = '<canvas width="300" height="300" class="bg-slate-900 rounded-xl mx-auto block max-w-full"></canvas><p class="text-center text-white mt-3 text-sm">Score <b id="gs">0</b> · Arrow keys or swipe · Tap board to restart</p>';
    const c = el.querySelector('canvas'), x = c.getContext('2d'), N = 15, S = 20;
    let s = [{ x: 7, y: 7 }], d = { x: 1, y: 0 }, nd = d, f = { x: 3, y: 3 }, sc = 0, t;
    const turn = (dx, dy) => { if (!(dx === -d.x && dy === -d.y)) nd = { x: dx, y: dy }; };
    const K = { ArrowUp: [0, -1], ArrowDown: [0, 1], ArrowLeft: [-1, 0], ArrowRight: [1, 0] };
    const key = e => { if (K[e.key]) { turn(...K[e.key]); e.preventDefault(); } };
    const sw = swipe(el, v => turn(...{ up: [0, -1], down: [0, 1], left: [-1, 0], right: [1, 0] }[v]));
    const draw = () => { x.fillStyle = '#0f172a'; x.fillRect(0, 0, 300, 300); x.fillStyle = '#f43f5e'; x.fillRect(f.x * S, f.y * S, S - 2, S - 2); x.fillStyle = '#34d399'; s.forEach(p => x.fillRect(p.x * S, p.y * S, S - 2, S - 2)); };
    const tick = () => {
      d = nd; const h = { x: s[0].x + d.x, y: s[0].y + d.y };
      if (h.x < 0 || h.y < 0 || h.x >= N || h.y >= N || s.some(p => p.x === h.x && p.y === h.y)) { clearInterval(t); x.fillStyle = '#fff'; x.font = 'bold 22px sans-serif'; x.fillText('Game over', 95, 150); return; }
      s.unshift(h);
      if (h.x === f.x && h.y === f.y) { sc++; el.querySelector('#gs').textContent = sc; f = { x: Math.floor(Math.random() * N), y: Math.floor(Math.random() * N) }; } else s.pop();
      draw();
    };
    document.addEventListener('keydown', key); t = setInterval(tick, 130); draw();
    c.onclick = () => launch('snake');
    return () => { clearInterval(t); document.removeEventListener('keydown', key); sw(); };
  }
  function g2048(el) {
    let g = [0, 1, 2, 3].map(() => [0, 0, 0, 0]), sc = 0;
    const add = () => { const e = []; g.forEach((r, i) => r.forEach((v, j) => { if (!v) e.push([i, j]); })); if (e.length) { const [a, b] = e[Math.floor(Math.random() * e.length)]; g[a][b] = Math.random() < .9 ? 2 : 4; } };
    const slide = r => { r = r.filter(Boolean); for (let i = 0; i < r.length - 1; i++) if (r[i] === r[i + 1]) { r[i] *= 2; sc += r[i]; r.splice(i + 1, 1); } while (r.length < 4) r.push(0); return r; };
    const draw = () => { el.innerHTML = '<div class="grid grid-cols-4 gap-2 max-w-xs mx-auto bg-slate-700 p-2 rounded-xl">' + g.flat().map(v => '<div class="aspect-square rounded-lg flex items-center justify-center font-extrabold text-lg" style="background:' + (v ? 'hsl(' + (40 - Math.log2(v) * 3) + ',90%,' + Math.max(35, 85 - Math.log2(v) * 5) + '%)' : '#475569') + ';color:' + (v > 4 ? '#fff' : '#334155') + '">' + (v || '') + '</div>').join('') + '</div><p class="text-center text-white mt-3 text-sm">Score ' + sc + ' · Arrow keys or swipe</p>'; };
    const move = v => {
      const o = JSON.stringify(g);
      if (v === 'left') g = g.map(slide); else if (v === 'right') g = g.map(r => slide([...r].reverse()).reverse());
      else for (let j = 0; j < 4; j++) { let col = g.map(r => r[j]); col = v === 'down' ? slide(col.reverse()).reverse() : slide(col); col.forEach((n, i) => { g[i][j] = n; }); }
      if (JSON.stringify(g) !== o) { add(); draw(); }
    };
    const key = e => { const m = { ArrowLeft: 'left', ArrowRight: 'right', ArrowUp: 'up', ArrowDown: 'down' }[e.key]; if (m) { e.preventDefault(); move(m); } };
    document.addEventListener('keydown', key); const sw = swipe(el, move); add(); add(); draw();
    return () => { document.removeEventListener('keydown', key); sw(); };
  }
  function memory(el) {
    const E = ['🍎', '🍌', '🍇', '🍉', '🍓', '🥝', '🍍', '🍒'], cards = [...E, ...E].sort(() => Math.random() - .5);
    let open = [], done = new Set(), mv = 0, lock = false;
    const draw = () => { el.innerHTML = '<div class="grid grid-cols-4 gap-2 max-w-xs mx-auto">' + cards.map((e, i) => { const sh = open.includes(i) || done.has(i); return '<button data-mi="' + i + '" class="aspect-square rounded-xl text-3xl ' + (sh ? 'bg-white' : 'bg-indigo-600') + '">' + (sh ? e : '') + '</button>'; }).join('') + '</div><p class="text-center text-white mt-3 text-sm">Moves: ' + mv + (done.size === 16 ? ' · 🎉 You win! Close and play again' : '') + '</p>'; };
    el.onclick = ev => {
      const b = ev.target.closest('[data-mi]'); if (!b || lock) return;
      const i = +b.dataset.mi; if (open.includes(i) || done.has(i)) return;
      open.push(i);
      if (open.length === 2) {
        mv++;
        if (cards[open[0]] === cards[open[1]]) { open.forEach(k => done.add(k)); open = []; }
        else { lock = true; draw(); setTimeout(() => { open = []; lock = false; draw(); }, 700); return; }
      }
      draw();
    };
    draw(); return () => { el.onclick = null; };
  }
  function ttt(el) {
    let b = Array(9).fill(''), msg = 'Your turn (X)', over = false;
    const L = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]];
    const win = (q, p) => L.some(l => l.every(i => q[i] === p));
    const mm = (q, p) => {
      if (win(q, 'O')) return 1; if (win(q, 'X')) return -1; if (q.every(Boolean)) return 0;
      let best = p === 'O' ? -2 : 2;
      q.forEach((v, i) => { if (!v) { q[i] = p; const s = mm(q, p === 'O' ? 'X' : 'O'); q[i] = ''; best = p === 'O' ? Math.max(best, s) : Math.min(best, s); } });
      return best;
    };
    const ai = () => {
      const free = b.map((v, i) => v ? -1 : i).filter(i => i >= 0);
      if (Math.random() < .25) { b[free[Math.floor(Math.random() * free.length)]] = 'O'; return; } // not unbeatable
      let bi = -1, bs = -2; free.forEach(i => { b[i] = 'O'; const s = mm(b, 'X'); b[i] = ''; if (s > bs) { bs = s; bi = i; } }); b[bi] = 'O';
    };
    const end = () => { if (win(b, 'X')) { msg = 'You win! 🎉 Tap to restart'; return true; } if (win(b, 'O')) { msg = 'Computer wins. Tap to restart'; return true; } if (b.every(Boolean)) { msg = 'Draw. Tap to restart'; return true; } return false; };
    const draw = () => { el.innerHTML = '<div class="grid grid-cols-3 gap-2 max-w-[240px] mx-auto">' + b.map((v, i) => '<button data-ti="' + i + '" class="aspect-square rounded-xl bg-white text-4xl font-extrabold ' + (v === 'X' ? 'text-rose-600' : 'text-indigo-600') + '">' + v + '</button>').join('') + '</div><p class="text-center text-white mt-3 text-sm">' + msg + '</p>'; };
    el.onclick = ev => {
      const t = ev.target.closest('[data-ti]'); if (!t) return;
      if (over) { launch('ttt'); return; }
      const i = +t.dataset.ti; if (b[i]) return;
      b[i] = 'X'; if (end()) { over = true; draw(); return; }
      ai(); if (end()) over = true; draw();
    };
    draw(); return () => { el.onclick = null; };
  }
  const BUILTIN = [
    { id: 'snake', title: 'Snake', emoji: '🐍', desc: 'Eat, grow, don’t crash', fn: snake },
    { id: '2048', title: '2048', emoji: '🔢', desc: 'Merge tiles to 2048', fn: g2048 },
    { id: 'memory', title: 'Memory Match', emoji: '🧠', desc: 'Find all the pairs', fn: memory },
    { id: 'ttt', title: 'Tic-Tac-Toe', emoji: '❌', desc: 'Beat the computer', fn: ttt }];
  const games = () => BUILTIN.concat((APP_CONFIG.externalGames || []).filter(g => /^https:\/\//.test(g.url || '')).map((g, i) => ({ id: 'ext' + i, title: g.title, emoji: g.emoji || '🎮', desc: g.desc || 'Online game', url: g.url })));
  function closeGame() { if (cleanup) { cleanup(); cleanup = null; } const o = document.getElementById('gameOverlay'); if (o) o.remove(); }
  function launch(id) {
    if (cleanup) { cleanup(); cleanup = null; }
    const g = games().find(x => x.id === id); if (!g) return;
    let ov = document.getElementById('gameOverlay');
    if (!ov) { ov = document.createElement('div'); ov.id = 'gameOverlay'; ov.className = 'fixed inset-0 z-[60] bg-slate-900 flex flex-col'; document.body.appendChild(ov); }
    ov.innerHTML = '<div class="flex items-center justify-between p-3 text-white"><b>' + escapeHtml(g.title) + '</b><button data-game-close class="w-9 h-9 rounded-full bg-white/20 text-xl leading-none" aria-label="Close">×</button></div><div class="flex-1 overflow-auto p-3 flex items-center justify-center" style="touch-action:none"><div class="w-full' + (g.url ? ' h-full' : '') + '"></div></div>';
    const st = ov.querySelector('.flex-1 > div');
    if (g.url) st.innerHTML = '<iframe src="' + escapeHtml(g.url) + '" class="w-full h-full rounded-xl bg-black" allow="fullscreen; autoplay; gamepad" sandbox="allow-scripts allow-same-origin allow-popups allow-forms"></iframe>';
    else cleanup = g.fn(st);
  }
  window.gamesPage = () => '<div class="mb-5"><h1 class="text-xl sm:text-2xl font-extrabold text-slate-900">Free Games</h1><p class="text-xs sm:text-sm text-slate-600">Play instantly. No download or sign-up needed.</p></div><div class="grid grid-cols-2 md:grid-cols-4 gap-4">' +
    games().map(g => '<button data-play-game="' + escapeHtml(g.id) + '" class="bg-white border border-slate-200 rounded-2xl p-5 text-center shadow-sm hover:border-rose-400 transition"><div class="text-5xl mb-2">' + g.emoji + '</div><div class="font-bold text-slate-900">' + escapeHtml(g.title) + '</div><div class="text-xs text-slate-500 mt-1">' + escapeHtml(g.desc) + '</div><div class="mt-3 brand-grad text-white text-xs font-semibold py-1.5 rounded-lg">Play</div></button>').join('') + '</div>';
  document.addEventListener('click', e => {
    const p = e.target.closest('[data-play-game]'); if (p) { launch(p.dataset.playGame); return; }
    if (e.target.closest('[data-game-close]')) closeGame();
  });
  document.addEventListener('keydown', e => { if (e.key === 'Escape') closeGame(); });
})();
