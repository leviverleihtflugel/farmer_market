**Çiftçilerle Doğrudan Alışveriş Platformu** 🌱
# Farmer Market
![image](https://github.com/user-attachments/assets/94cb8923-d9e0-4b9c-876d-3aab705f5547)

![Flutter](https://img.shields.io/badge/Flutter-3.22-blue?logo=flutter) ![Firebase](https://img.shields.io/badge/Firebase-BaaS-yellow?logo=firebase)

## Proje Tanımı
Farmer Market, küçük ve orta ölçekli çiftçilerin ürünlerini doğrudan tüketicilere sunabilmesi için geliştirilen Flutter tabanlı bir **mobil pazar uygulamasıdır**. Uygulama, Firebase ile gerçek zamanlı senkronizasyon, güvenli kimlik doğrulama ve medya yönetimi desteği sunar.

---
## Özellikler
- **Rol Tabanlı Giriş:** Çiftçi veya Tüketici olarak kayıt olup role özel arayüz görme
- **Ürün Yönetimi (Çiftçi):** Ürün ekleme, düzenleme, silme, stok (kg) güncelleme
- **Ürün Keşfi (Tüketici):** Arama, fiyata göre artan–azalan sıralama, detay görüntüleme
- **Doğrudan İletişim:** Tüketici, ürün detay sayfasından üreticinin telefonuna erişebilir
- **Karanlık / Aydınlık Tema:** Tek tıkla tema değişimi
- **Firebase Entegrasyonu:** Authentication, Cloud Firestore, Storage ile gerçek zamanlı veri

---
## Kullanılan Teknolojiler
| Katman | Teknoloji |
|--------|-----------|
| **Frontend** | Flutter 3, Dart |
| **Backend‑as‑a‑Service** | Firebase Authentication, Cloud Firestore, Firebase Storage |
| **State Management** | Provider |
| **Tasarım** | Material Design 3 |


---
## Proje Yapısı 
```
lib/
 ├─ core/          # Tema & global yardımcılar
 ├─ auth/          # Giriş / kayıt akışı
 ├─ product/       # Ürün model, servis ve arayüzleri
 ├─ profile/       # Profil & ayarlar
 ├─ router/        # Sayfa yönlendirme
 └─ main.dart      # Uygulama başlangıcı
```

---
## Ekran Görüntüleri







