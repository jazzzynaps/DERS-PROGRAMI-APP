DERS PROGRAMI - Supabase bağlı sürüm

- Giriş: Supabase Authentication e-posta/şifre
- Oturum tarayıcıda kalıcıdır.
- Admin ve öğretmen yetkileri RLS ile veritabanında korunur.
- Dersler, öğrenciler, öğretmenler ve program ayarları Supabase'den okunur/yazılır.
- Ders/öğrenci/öğretmen değişiklikleri canlı olarak diğer açık cihazlara yansır.
- Öğretmen ekranı salt okunurdur.

Notlar:
1) Yeni öğretmenin uygulamaya giriş yapabilmesi için Supabase Authentication'da ayrıca kullanıcı hesabı oluşturulmalı ve profiles/teachers bağlantısı kurulmalıdır.
2) "Her hafta tekrarla" alanı arayüzde korunmuştur ancak tekrar serisi için veritabanı şeması henüz eklenmediğinden bu sürümde tek ders kaydeder.
3) change_log tablosu hazırdır; otomatik audit trigger'ları sonraki adımda eklenecektir.

V8: Haftalık tekrar desteği eklendi. "Her hafta tekrarla" ile lesson_series kaydı oluşturulur. Haftalık görünüm serileri otomatik gösterir; tek bir haftadaki durum değişikliği o tarih için ayrı lessons kaydı olarak tutulur.
