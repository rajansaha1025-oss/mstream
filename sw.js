const C='mstream-v12',A=['./','index.html','manifest.json','assets/logo.png','assets/favicon.png','icon-192.png','icon-512.png'];
self.addEventListener('install',e=>{e.waitUntil(caches.open(C).then(c=>c.addAll(A)).then(()=>self.skipWaiting()))});
self.addEventListener('activate',e=>{e.waitUntil(caches.keys().then(k=>Promise.all(k.filter(x=>x!==C).map(x=>caches.delete(x)))).then(()=>clients.claim()))});
self.addEventListener('message',e=>{if(e.data==='SKIP_WAITING')self.skipWaiting()});
self.addEventListener('fetch',e=>{
  const r=e.request,u=new URL(r.url);
  if(r.method!=='GET'||u.origin!==location.origin||u.pathname.endsWith('version.json'))return;
  if(r.mode==='navigate'){
    e.respondWith(fetch(r).then(x=>{if(!u.search)caches.open(C).then(c=>c.put(r,x.clone()));return x}).catch(()=>caches.match('index.html')));
    return;
  }
  e.respondWith(caches.match(r).then(h=>h||fetch(r).then(x=>{caches.open(C).then(c=>c.put(r,x.clone()));return x})));
});
