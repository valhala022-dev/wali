import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/clipboard_helper.dart';
import '../../../core/utils/coordinate_formatter.dart';
import '../../../models/makam_wali_model.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/common/offline_banner.dart';

class OfflineMapFallback extends StatelessWidget {
  final List<MakamWaliModel> items;
  final VoidCallback onRetry;

  const OfflineMapFallback({
    super.key,
    required this.items,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        OfflineBanner(onRetry: onRetry),
        const SizedBox(height: 18),
        Text(
          'Daftar Koordinat Makam Wali (Offline)',
          style: AppTypography.headingMedium,
        ),
        const SizedBox(height: 10),
        ...items.map((m) {
          final coord = CoordinateFormatter.format(m.latitude, m.longitude);
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                title: Text(m.namaWali, style: AppTypography.titleSmall),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 2),
                    Text(
                      '${m.alamat}, Desa ${m.desa}, Kec. ${m.kecamatan}',
                      style: AppTypography.bodySecondary,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Koordinat: $coord',
                      style: AppTypography.bodySecondary.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.copy_rounded, color: AppColors.primary),
                  tooltip: 'Salin koordinat',
                  onPressed: () => ClipboardHelper.copyText(
                    context,
                    text: coord,
                    label: 'Koordinat ${m.namaMakam}',
                  ),
                ),
                onTap: () => context.push(AppRoutes.detailWali(m.id)),
              ),
            ),
          );
        }),
      ],
    );
  }
}
