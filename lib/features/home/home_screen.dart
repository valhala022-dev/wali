import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/tuban_kecamatan.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/cards/makam_card.dart';
import '../../widgets/common/search_bar_widget.dart';
import 'home_controller.dart';
import 'widgets/hero_banner.dart';
import 'widgets/kecamatan_filter_bar.dart';
import 'widgets/quick_access_row.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final makamAsync = ref.watch(filteredMakamListProvider);
    final totalCount = ref.watch(totalMakamCountProvider).valueOrNull ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/images/branding/logo_bumi_wali.svg',
              width: 32,
              height: 32,
            ),
            const SizedBox(width: 10),
            const Text(
              AppConstants.appName,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            tooltip: 'Tentang Aplikasi',
            onPressed: () => context.go(AppRoutes.about),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SearchBarWidget(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() {});
                    ref.read(homeSearchQueryProvider.notifier).state = val;
                  },
                  onClear: () {
                    _searchController.clear();
                    setState(() {});
                    ref.read(homeSearchQueryProvider.notifier).state = '';
                  },
                ),
                const SizedBox(height: 14),
                HeroBanner(totalSites: totalCount),
                const SizedBox(height: 14),
                const QuickAccessRow(),
                const SizedBox(height: 18),
                Text('Filter Wilayah Kecamatan', style: AppTypography.titleSmall),
                const SizedBox(height: 8),
                const KecamatanFilterBar(),
                const SizedBox(height: 16),
                Text('Daftar Makam Wali Tuban', style: AppTypography.headingMedium),
                const SizedBox(height: 10),
              ]),
            ),
          ),
          makamAsync.when(
            loading: () => const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, _) => SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text('Gagal memuat data lokal: $err'),
                ),
              ),
            ),
            data: (items) {
              if (items.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.search_off_rounded,
                            size: 48,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Belum ada data makam untuk pencarian atau kecamatan ini.',
                            textAlign: TextAlign.center,
                            style: AppTypography.bodySecondary,
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () {
                              _searchController.clear();
                              setState(() {});
                              ref.read(homeSearchQueryProvider.notifier).state =
                                  '';
                              ref
                                  .read(homeSelectedKecamatanProvider.notifier)
                                  .state = TubanKecamatan.semua;
                            },
                            child: const Text('Tampilkan Semua Wilayah'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                sliver: SliverList.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return MakamCard(
                      makam: item,
                      onTap: () => context.push(AppRoutes.detailWali(item.id)),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
