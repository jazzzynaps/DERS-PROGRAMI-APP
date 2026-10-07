V18 Teacher Accounts Cache Fix
- V17 öğretmen hesabı oluşturma kodu korunmuştur.
- app.js -> app-v18.js ve style.css -> style-v18.css yapıldı.
- service worker sw-v18.js olarak yenilendi.
- Amaç: tarayıcının eski V16 JavaScript dosyasını kullanmasını engellemek.
- Mevcut profile_id olmayan öğretmen kaydı açıldığında buton 'Hesap Oluştur' olur ve create-teacher-user Edge Function çağrılır.
