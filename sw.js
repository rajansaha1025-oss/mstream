const CACHE = 'mstream-v6';
const ASSETS = ['./', 'index.html', 'manifest.json', 'mstream-cloud.js', 'mstream-feed.js', 'games.js', 'mstream-ads.js', 'mstream-ui.js', 'assets/logo.webp', 'assets/movie.webp', 'assets/anime.webp', 'assets/cartoon.webp', 'assets/favicon.png', 'mstream-icon-192.png', 'mstream-icon-512.png'];
self.addEventListener('install', e => { e.waitUntil(caches.open(CACHE).then(c => c.addAll(ASSETS)).then(() => self.skipWaiting())); });
self.addEventListener('activate', e => { e.waitUntil(caches.keys().then(ks => Promise.all(ks.filter(k => k !== CACHE).map(k => caches.delete(k)))).then(() => clients.claim())); });
self.addEventListener('fetch', e => {
  const req = e.request, url = new URL(req.url);
  if (req.method !== 'GET' || url.origin !== location.origin) return; // never touch API/video/CDN requests
  if (req.mode === 'navigate') { e.respondWith(fetch(req).then(r => { caches.open(CACHE).then(c => c.put(req, r.clone())); return r; }).catch(() => caches.match('index.html'))); return; }
  e.respondWith(caches.match(req).then(hit => hit || fetch(req).then(r => { caches.open(CACHE).then(c => c.put(req, r.clone())); return r; })));
});
