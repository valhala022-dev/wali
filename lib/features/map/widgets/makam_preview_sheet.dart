import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../models/makam_wali_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/map_launcher_service.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';

class MakamPreviewSheet extends ConsumerWidget {
  final MakamWaliModel makam;
  final VoidCallback onClose;

  const MakamPreviewSheet({
    super.key,
    required this.makam,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(14),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    makam.fotoMakam,
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        makam.namaWali,
                        style: AppTypography.titleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${makam.namaMakam} • Kec. ${makam.kecamatan}',
                        style: AppTypography.bodySecondary,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onClose,
                  icon: const Icon(Icons.close_rounded, size: 20),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        context.push(AppRoutes.detailWali(makam.id)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                    ),
                    child: const Text('Lihat Detail'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => ref
                        .read(mapLauncherServiceProvider)
                        .openDirections(
                          latitude: makam.latitude,
                          longitude: makam.longitude,
                        ),
                    icon: const Icon(Icons.directions_rounded, size: 18),
                    label: const Text('Petunjuk Arah'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
