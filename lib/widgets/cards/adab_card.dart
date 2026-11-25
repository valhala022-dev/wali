import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/adab_ziarah_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class AdabCard extends StatelessWidget {
  final AdabZiarahModel adab;

  const AdabCard({super.key, required this.adab});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (adab.pathIlustrasi != null)
              SvgPicture.asset(
                adab.pathIlustrasi!,
                width: 46,
                height: 46,
              )
            else
              Container(
                width: 46,
                height: 46,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.softAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${adab.urutan}',
                  style: AppTypography.titleSmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${adab.urutan}. ${adab.judulAdab}',
                    style: AppTypography.titleSmall,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    adab.penjelasan,
                    style: AppTypography.bodySecondary,
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
