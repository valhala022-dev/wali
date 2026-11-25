import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class OfflineBanner extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const OfflineBanner({
    super.key,
    this.message =
        'Mode Offline: Peta interaktif membutuhkan koneksi internet. Seluruh data sejarah, doa, adab, alamat, dan koordinat tetap tersedia penuh.',
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.softAccent,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.wifi_off_rounded, color: AppColors.primary, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Koneksi Internet Tidak Tersedia',
                  style: AppTypography.titleSmall.copyWith(
                    color: AppColors.primary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(message, style: AppTypography.bodySecondary),
                if (onRetry != null) ...[
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: const Text('Coba Muat Ulang'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
