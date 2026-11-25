import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/app_constants.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Bumi Wali'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
        children: [
          Center(
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/images/branding/logo_bumi_wali.svg',
                  width: 84,
                  height: 84,
                ),
                const SizedBox(height: 12),
                Text(AppConstants.appName, style: AppTypography.headingLarge),
                const SizedBox(height: 4),
                Text(
                  AppConstants.appTagline,
                  style: AppTypography.bodySecondary,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.softAccent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Text(
                    AppConstants.appVersion,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const _InfoSectionCard(
            title: 'Tentang & Tujuan Aplikasi',
            content:
                'Bumi Wali adalah aplikasi panduan wisata religi offline-first untuk mengenal makam para wali dan ulama bersejarah di seluruh kecamatan Kabupaten Tuban. Aplikasi ini menghadirkan biografi terstruktur, sejarah kompleks makam, panduan bacaan doa ziarah (Yasin, Tahlil, dan doa penutup), serta edukasi 10 adab ziarah tanpa memerlukan login akun.',
          ),
          const SizedBox(height: 12),
          const _InfoSectionCard(
            title: 'Prinsip Etika & Sumber Data Sejarah',
            content:
                '''• Buku "Tuban Bumi Wali: The Spirit of Harmoni" (Pemerintah Daerah Kabupaten Tuban, 2013).
• Arsip Pusaka Jawatimuran – Dinas Perpustakaan dan Kearsipan Provinsi Jawa Timur.
• SIDITA (Sistem Informasi Destinasi Wisata) & INCAR Cagar Budaya Provinsi Jawa Timur.
• Dinas Perpustakaan dan Kearsipan Kabupaten Tuban (arsip.tubankab.go.id).

Setiap kisah karomah dipilah secara objektif antara fakta sejarah, riwayat tertulis, dan cerita tutur masyarakat. Ilustrasi tokoh wali diberi label representasi artistik secara eksplisit.''',
          ),
          const SizedBox(height: 12),
          const _InfoSectionCard(
            title: 'Atribusi Peta & Lisensi',
            content:
                'Layanan peta interaktif dan navigasi rute menggunakan Google Maps SDK for Android & Google Maps URLs (© Google). Font lokal yang dibundel menggunakan Inter (SIL Open Font License) dan Noto Naskh Arabic (SIL Open Font License).',
          ),
          const SizedBox(height: 14),
          OutlinedButton.icon(
            onPressed: () {
              showLicensePage(
                context: context,
                applicationName: AppConstants.appName,
                applicationVersion: AppConstants.appVersion,
              );
            },
            icon: const Icon(Icons.description_outlined),
            label: const Text('Lihat Lisensi Open-Source'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoSectionCard extends StatelessWidget {
  final String title;
  final String content;

  const _InfoSectionCard({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTypography.titleSmall.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            Text(content, style: AppTypography.body),
          ],
        ),
      ),
    );
  }
}
