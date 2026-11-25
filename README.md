# Aplikasi Bumi Wali – Wisata Religi Ziarah Makam Wali di Tuban

Aplikasi mobile Android berbasis **Flutter (Dart)** dengan arsitektur **Offline-First** (SQLite + Drift) sesuai spesifikasi *Product Requirement Document (PRD) Bumi Wali v1.0*.

## Fitur Utama
1. **Splash Screen & Inisialisasi Offline:** Memuat basis data SQLite pre-populated (`assets/database/bumi_wali_initial.db`) ke penyimpanan internal perangkat secara otomatis tanpa wajib login.
2. **Direktori, Pencarian & Filter Kecamatan (Beranda):** Pencarian real-time lokal berdasarkan nama wali, nama makam, desa, dan filter 20 kecamatan se-Kabupaten Tuban.
3. **Detail Makam Wali (6 Bagian Terstruktur):** Informasi Utama, Biografi Wali, Sejarah Makam, Karomah dengan pemilahan `[Fakta Sejarah]`, `[Riwayat Tertulis]`, dan `[Cerita Tutur Masyarakat]`, Galeri Foto layar penuh (*pinch-to-zoom*) dengan label wajib *"Ilustrasi Tokoh Wali – Representasi Artistik"*, serta Lokasi & Peta.
4. **Panduan Doa Ziarah Offline:** Doa Masuk Makam, Surat Yasin, Bacaan Tahlil, Doa Setelah Tahlil, dan Doa Penutup Ziarah dengan kontrol ukuran huruf Arab (`A-` / `A+` dari `18sp`–`36sp`) serta sakelar teks Latin & Terjemahan.
5. **Tata Tertib & Adab Ziarah:** 10 pedoman etika berziarah lengkap dengan ikon vektor SVG lokal.
6. **Peta Sebaran Makam Wali:** Integrasi `google_maps_flutter` + peluncuran navigasi rute Google Maps (`url_launcher`), izin lokasi kontekstual (*just-in-time*), dan *offline fallback* informatif berisi alamat serta koordinat presisi 6 angka desimal yang dapat disalin.
7. **Tentang Aplikasi:** Profil aplikasi, daftar sumber rujukan sejarah, atribusi Google Maps, dan halaman lisensi open-source.

## Cara Menjalankan Proyek

### Prasyarat
- Flutter SDK (Stable, Dart >= 3.4.0)
- Android Studio / Android SDK (Min SDK 24 / Android 7.0+)

### Langkah Instalasi
```bash
# 1. Masuk ke direktori proyek
cd bumi_wali

# 2. Unduh dependensi Flutter
flutter pub get

# 3. Generate kode Drift (app_database.g.dart & DAO *.g.dart)
dart run build_runner build --delete-conflicting-outputs

# 4. Masukkan Google Maps API Key di:
#    android/app/src/main/AndroidManifest.xml
#    ganti YOUR_GOOGLE_MAPS_API_KEY dengan API Key Anda (batasi via Package Name & SHA-1)

# 5. Jalankan aplikasi pada emulator / perangkat Android
flutter run
```

## Catatan Kustomisasi Aset
- **Font Arab:** Proyek sudah membundel `NotoNaskhArabic` (SIL OFL) agar langsung berjalan 100% offline. Anda dapat menggantinya dengan `LPMQ Isep Misbah` di `assets/fonts/Arabic/` dan memperbarui entri `pubspec.yaml`.
- **Foto Dokumentasi Asli:** Aset gambar di `assets/images/makam/` berupa ilustrasi arsitektur WebP terkompresi sebagai visual awal yang bebas hak cipta. Ganti file WebP tersebut dengan foto dokumentasi lapangan berizin resmi dan perbarui kolom `sumber_foto` pada tabel `galeri_makam`.
- **Ekspansi Data Makam & Ayat Yasin:** Tambah entri baru langsung di `assets/database/bumi_wali_initial.db` tanpa perlu mengubah kode UI.
