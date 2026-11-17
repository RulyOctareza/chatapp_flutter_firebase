<p align="center">
  <img src="docs/preview/hero.svg" alt="Chat App Firebase — ilustrasi aplikasi chat real-time" width="100%">
</p>

<h1 align="center">Chat App — Flutter + Firebase</h1>

<p align="center">
  <b>Chat real-time, lengkap dengan autentikasi dan notifikasi.</b><br>
  Firebase Auth · Cloud Firestore · FCM
</p>

<p align="center">
  <a href="https://flutter.dev"><img alt="Flutter" src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white"></a>
  <img alt="Provider" src="https://img.shields.io/badge/State-Provider-5C6BC0">
  <a href="https://firebase.google.com"><img alt="Firebase" src="https://img.shields.io/badge/Backend-Firebase-FFCA28?logo=firebase&logoColor=black"></a>
</p>

---

## ✨ Preview

<p align="center">
  <img src="docs/preview/hero.png" alt="Mockup gelap Chat App Firebase" width="90%">
</p>

> **Catatan:** gambar di atas adalah *ilustrasi konsep*, bukan screenshot asli.

---

## 📖 Tentang

Aplikasi chat yang memakai Firebase sebagai backend: pesan tersimpan di Cloud Firestore dan
langsung tersinkron ke semua perangkat, autentikasi lewat Firebase Auth, dan notifikasi push
lewat Firebase Cloud Messaging. Ada juga folder `functions/` untuk logika backend.

---

## 🌟 Fitur

- 🔐 **Registrasi & login** dengan Firebase Authentication
- 💬 **Chat real-time** di Cloud Firestore
- 🔔 **Push notification** dengan Firebase Messaging
- 👤 **Data pengguna** dan status
- 🎨 Tema aplikasi
- 🧩 Provider untuk state management
- ⚡ Stream reaktif dengan `rxdart`

---

## 🛠️ Tech Stack

| Area | Pilihan |
|---|---|
| Framework | Flutter |
| Auth | Firebase Authentication |
| Database | Cloud Firestore |
| Notifikasi | Firebase Cloud Messaging |
| State management | Provider |
| Reaktif | RxDart |
| Backend | Cloud Functions (`functions/`) |

---

## 🚀 Menjalankan

```bash
flutter pub get
flutter run
```

Sesuaikan `firebase_options.dart`, aktifkan Authentication, Firestore, dan Cloud Messaging
di project Firebase-mu.

Untuk Cloud Functions:

```bash
cd functions
npm install
firebase deploy --only functions
```

---

## 🧪 Testing

```bash
flutter analyze
flutter test
```
