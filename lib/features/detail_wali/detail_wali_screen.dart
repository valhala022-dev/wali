import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/clipboard_helper.dart';
import '../../core/utils/coordinate_formatter.dart';
import '../../models/galeri_item_model.dart';
import '../../models/makam_wali_model.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/common/verification_badge.dart';
import 'detail_wali_controller.dart';
import 'widgets/lokasi_peta_section.dart';

class DetailWaliScreen extends ConsumerWidget {
  final int makamId;

  const DetailWaliScreen({super.key, required this.makamId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(detailWaliProvider(makamId));

    return detailAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Scaffold(
        appBar: AppBar(title: const Text('Detail Makam')),
        body: Center(child: Text('Terjadi kesalahan: $err')),
      ),
      data: (data) {
        if (data == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Detail Makam')),
            body: const Center(child: Text('Data makam tidak ditemukan.')),
          );
        }

        final makam = data.makam;
        final galeri = data.galeri;

        return DefaultTabController(
          length: 4,
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  expandedHeight: 240,
                  pinned: true,
                  title: Text(
                    makam.namaMakam,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.copy_all_rounded),
                      tooltip: 'Salin alamat & koordinat',
                      onPressed: () {
                        final text =
                            '${makam.namaMakam}\n${makam.alamat}, Desa ${makam.desa}, Kec. ${makam.kecamatan}, Tuban\nKoordinat: ${CoordinateFormatter.format(makam.latitude, makam.longitude)}';
                        ClipboardHelper.copyText(
                          context,
                          text: text,
                          label: 'Alamat & koordinat',
                        );
                      },
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(makam.fotoMakam, fit: BoxFit.cover),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.35),
                                Colors.transparent,
                                AppColors.primaryVariant.withValues(alpha: 0.85),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottom: const TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    indicatorColor: AppColors.secondary,
                    labelColor: Colors.white,
                    unselectedLabelColor: AppColors.softAccent,
                    tabs: [
                      Tab(text: 'Profil & Biografi'),
                      Tab(text: 'Sejarah & Karomah'),
                      Tab(text: 'Galeri'),
                      Tab(text: 'Lokasi'),
                    ],
                  ),
                ),
              ],
              body: TabBarView(
                children: [
                  _ProfilBiografiTab(makam: makam),
                  _SejarahKaromahTab(makam: makam),
                  _GaleriTab(makamId: makam.id, galeri: galeri),
                  LokasiPetaSection(makam: makam),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProfilBiografiTab extends StatelessWidget {
  final MakamWaliModel makam;

  const _ProfilBiografiTab({required this.makam});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        VerificationBadge(
          isVerified: makam.isTerverifikasi,
          label: makam.labelVerifikasi,
        ),
        const SizedBox(height: 10),
        Text(makam.namaWali, style: AppTypography.headingLarge),
        const SizedBox(height: 4),
        Text(
          makam.namaMakam,
          style: AppTypography.titleSmall.copyWith(color: AppColors.primary),
        ),
        const SizedBox(height: 14),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Informasi Utama', style: AppTypography.titleSmall),
                const SizedBox(height: 8),
                Text(
                  '${makam.alamat}, Desa ${makam.desa}, Kecamatan ${makam.kecamatan}, Kabupaten Tuban',
                  style: AppTypography.bodySecondary,
                ),
                const SizedBox(height: 6),
                Text(
                  'Koordinat: ${CoordinateFormatter.format(makam.latitude, makam.longitude)}',
                  style: AppTypography.bodySecondary.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(makam.deskripsiSingkat, style: AppTypography.body),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('Biografi Wali', style: AppTypography.headingMedium),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(makam.biografi, style: AppTypography.body),
          ),
        ),
      ],
    );
  }
}

class _SejarahKaromahTab extends StatelessWidget {
  final MakamWaliModel makam;

  const _SejarahKaromahTab({required this.makam});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Sejarah Makam', style: AppTypography.headingMedium),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(makam.sejarahMakam, style: AppTypography.body),
          ),
        ),
        const SizedBox(height: 18),
        Text('Karomah & Keistimewaan Wali', style: AppTypography.headingMedium),
        const SizedBox(height: 6),
        Text(
          'Narasi dipilah antara fakta sejarah, riwayat tertulis, dan cerita tutur masyarakat sesuai prinsip etika konten Bumi Wali.',
          style: AppTypography.bodySecondary,
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(makam.karomahKeistimewaan, style: AppTypography.body),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.softAccent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.menu_book_rounded,
                    size: 18,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Sumber Informasi & Rujukan',
                    style: AppTypography.titleSmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(makam.sumberInformasi, style: AppTypography.bodySecondary),
            ],
          ),
        ),
      ],
    );
  }
}

class _GaleriTab extends StatelessWidget {
  final int makamId;
  final List<GaleriItemModel> galeri;

  const _GaleriTab({required this.makamId, required this.galeri});

  @override
  Widget build(BuildContext context) {
    if (galeri.isEmpty) {
      return const Center(child: Text('Belum ada foto galeri.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: galeri.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final item = galeri[index];
        return Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => context.push(
              AppRoutes.galleryViewer(makamId),
              extra: {'items': galeri, 'initialIndex': index},
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.asset(item.pathGambar, fit: BoxFit.cover),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: item.isIlustrasiWali
                              ? AppColors.secondary
                              : AppColors.primaryVariant.withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          item.isIlustrasiWali
                              ? AppConstants.artisticIllustrationLabel
                              : item.labelKategori,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: item.isIlustrasiWali
                                ? AppColors.textPrimary
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.keterangan, style: AppTypography.body),
                      const SizedBox(height: 4),
                      Text(
                        'Kredit: ${item.sumberFoto}',
                        style: AppTypography.bodySecondary.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
