// Optional third-party ads. Does nothing until APP_CONFIG.ads is filled; loads only after the visitor accepts.
(function () {
  const A = APP_CONFIG.ads || {};
  if (!A.adsenseClient && !A.customHtml) return;
  let consent; try { consent = localStorage.getItem('ms_consent'); } catch (e) {}
  const main = document.getElementById('mainContainer');
  function start() {
    if (A.adsenseClient) { const s = document.createElement('script'); s.async = true; s.crossOrigin = 'anonymous'; s.src = 'https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=' + encodeURIComponent(A.adsenseClient); document.head.appendChild(s); }
    const d = document.createElement('div'); d.id = 'adSlot'; d.className = 'max-w-7xl w-full mx-auto px-3 sm:px-5 pt-4 text-center overflow-hidden';
    d.innerHTML = '<div class="text-[10px] uppercase tracking-wide text-slate-400 mb-1">Advertisement</div>';
    if (A.adsenseClient) {
      const ins = document.createElement('ins'); ins.className = 'adsbygoogle'; ins.style.display = 'block';
      ins.setAttribute('data-ad-client', A.adsenseClient); ins.setAttribute('data-ad-slot', A.adsenseSlot || ''); ins.setAttribute('data-ad-format', 'auto'); ins.setAttribute('data-full-width-responsive', 'true');
      d.appendChild(ins); main.before(d); try { (window.adsbygoogle = window.adsbygoogle || []).push({}); } catch (e) {}
    } else { d.appendChild(document.createRange().createContextualFragment(A.customHtml)); main.before(d); }
    const show = () => d.classList.toggle('hidden', !['reels', 'movies', 'games'].includes(state.activeTab));
    show(); new MutationObserver(show).observe(main, { childList: true });
  }
  if (consent === 'yes') start();
  else if (consent !== 'no') {
    const b = document.createElement('div'); b.className = 'fixed bottom-0 inset-x-0 z-[70] bg-slate-900 text-white text-xs p-3 flex items-center justify-between gap-3';
    b.innerHTML = '<span>We use cookies and show ads to keep MStream free. See our <a class="underline" href="privacy.html">Privacy Policy</a>.</span><span class="flex gap-2 shrink-0"><button data-c="no" class="px-3 py-1.5 rounded-lg bg-white/15">Decline</button><button data-c="yes" class="px-3 py-1.5 rounded-lg bg-emerald-500 font-bold">Accept</button></span>';
    b.onclick = e => { const v = e.target.dataset.c; if (!v) return; try { localStorage.setItem('ms_consent', v); } catch (x) {} b.remove(); if (v === 'yes') start(); };
    document.body.appendChild(b);
  }
})();
