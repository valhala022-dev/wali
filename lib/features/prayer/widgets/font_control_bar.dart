import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../theme/app_colors.dart';
import '../prayer_controller.dart';

class FontControlBar extends ConsumerWidget {
  const FontControlBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontSize = ref.watch(arabicFontSizeProvider);
    final showLatin = ref.watch(showLatinProvider);
    final showTranslation = ref.watch(showTranslationProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.cardBorder)),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 6,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton(
                onPressed: fontSize > AppConstants.minArabicFontSize
                    ? () => ref.read(arabicFontSizeProvider.notifier).state =
                        (fontSize - AppConstants.fontSizeStep).clamp(
                          AppConstants.minArabicFontSize,
                          AppConstants.maxArabicFontSize,
                        )
                    : null,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(42, 34),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                child: const Text('A-'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '${fontSize.toInt()}sp',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    fontSize: 12.5,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: fontSize < AppConstants.maxArabicFontSize
                    ? () => ref.read(arabicFontSizeProvider.notifier).state =
                        (fontSize + AppConstants.fontSizeStep).clamp(
                          AppConstants.minArabicFontSize,
                          AppConstants.maxArabicFontSize,
                        )
                    : null,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(42, 34),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                child: const Text('A+'),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FilterChip(
                label: const Text('Latin'),
                selected: showLatin,
                onSelected: (v) =>
                    ref.read(showLatinProvider.notifier).state = v,
              ),
              const SizedBox(width: 6),
              FilterChip(
                label: const Text('Arti'),
                selected: showTranslation,
                onSelected: (v) =>
                    ref.read(showTranslationProvider.notifier).state = v,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
