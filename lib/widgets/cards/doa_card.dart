import 'package:flutter/material.dart';

import '../../models/panduan_doa_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class DoaCard extends StatelessWidget {
  final PanduanDoaModel item;
  final double arabicFontSize;
  final bool showLatin;
  final bool showTranslation;

  const DoaCard({
    super.key,
    required this.item,
    required this.arabicFontSize,
    required this.showLatin,
    required this.showTranslation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (item.judulBagian != null && item.judulBagian!.isNotEmpty) ...[
              Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.softAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${item.urutan}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item.judulBagian!,
                      style: AppTypography.titleSmall.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
            ],
            Directionality(
              textDirection: TextDirection.rtl,
              child: SelectableText(
                item.teksArab,
                textAlign: TextAlign.right,
                style: AppTypography.arabic(arabicFontSize),
              ),
            ),
            if (showLatin &&
                item.teksLatin != null &&
                item.teksLatin!.isNotEmpty) ...[
              const SizedBox(height: 14),
              Text(
                item.teksLatin!,
                style: AppTypography.bodySecondary.copyWith(
                  fontStyle: FontStyle.italic,
                  color: AppColors.primary,
                  fontSize: (arabicFontSize * 0.56).clamp(13.0, 18.0),
                ),
              ),
            ],
            if (showTranslation) ...[
              const SizedBox(height: 10),
              Text(
                item.terjemahan,
                style: AppTypography.body.copyWith(
                  fontSize: (arabicFontSize * 0.58).clamp(13.5, 18.0),
                ),
              ),
            ],
            if (item.catatan != null && item.catatan!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.softAccent.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item.catatan!,
                        style: AppTypography.bodySecondary.copyWith(fontSize: 12.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
