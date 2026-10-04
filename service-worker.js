const CACHE='ders-programi-v12-push-2-unique';
const ASSETS=['./','./index.html','./style.css','./app.js','./config.js','./manifest.webmanifest','./icon-192.png','./icon-512.png','./apple-touch-icon.png'];
self.addEventListener('install',e=>{self.skipWaiting();e.waitUntil(caches.open(CACHE).then(c=>c.addAll(ASSETS)))});
self.addEventListener('activate',e=>{e.waitUntil(caches.keys().then(keys=>Promise.all(keys.filter(k=>k!==CACHE).map(k=>caches.delete(k)))).then(()=>self.clients.claim()))});
self.addEventListener('fetch',e=>{if(e.request.method!=='GET')return;e.respondWith(fetch(e.request).catch(()=>caches.match(e.request)))});

self.addEventListener('push', event => {
  let data = {title:'Ders Programı', body:'Programınızda değişiklik yapıldı.', url:'/DERS-PROGRAMI/'};
  try { if (event.data) data = {...data, ...event.data.json()}; } catch (_) {}
  event.waitUntil(self.registration.showNotification(data.title || 'Ders Programı', {
    body: data.body || '', icon:'./icon-192.png', badge:'./icon-192.png', data:{url:data.url || '/DERS-PROGRAMI/'}
  }));
});
self.addEventListener('notificationclick', event => {
  event.notification.close();
  event.waitUntil(clients.matchAll({type:'window', includeUncontrolled:true}).then(list => {
    for (const c of list) { if ('focus' in c) { c.navigate(event.notification.data?.url || './'); return c.focus(); } }
    return clients.openWindow(event.notification.data?.url || './');
  }));
});
