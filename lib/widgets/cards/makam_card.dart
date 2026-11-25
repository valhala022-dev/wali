import 'package:flutter/material.dart';

import '../../models/makam_wali_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../common/verification_badge.dart';

class MakamCard extends StatelessWidget {
  final MakamWaliModel makam;
  final VoidCallback onTap;

  const MakamCard({
    super.key,
    required this.makam,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    makam.fotoMakam,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.primary,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.mosque_rounded,
                        color: AppColors.secondary,
                        size: 48,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryVariant.withValues(alpha: 0.88),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          size: 13,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Kec. ${makam.kecamatan}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerificationBadge(
                    isVerified: makam.isTerverifikasi,
                    label: makam.labelVerifikasi,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    makam.namaWali,
                    style: AppTypography.titleSmall.copyWith(fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${makam.namaMakam} • ${makam.lokasiRingkas}',
                    style: AppTypography.bodySecondary.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    makam.deskripsiSingkat,
                    style: AppTypography.bodySecondary,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Lihat Detail',
                        style: AppTypography.titleSmall.copyWith(
                          color: AppColors.primary,
                          fontSize: 13.5,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 16,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
