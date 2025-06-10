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

![image](https://github.com/user-attachments/assets/fc829c37-6937-404c-9761-31b481293a26)

![image](https://github.com/user-attachments/assets/96b7df3b-6a40-41eb-a199-0fba1e999bee)

![image](https://github.com/user-attachments/assets/fde09aa9-e471-41fc-be79-55006bc1a631)

![image](https://github.com/user-attachments/assets/86fa65ab-ed86-4cc7-a349-e87adf48afcf)

![image](https://github.com/user-attachments/assets/50f67160-36db-4c07-9a9f-4594c739f34d)

![image](https://github.com/user-attachments/assets/b164a439-cd04-444f-be87-2f90dca16d9c)

![image](https://github.com/user-attachments/assets/63777c63-e74b-4f8a-b810-a33b049bc7c6)


