import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../models/panduan_doa_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/cards/doa_card.dart';
import 'prayer_controller.dart';
import 'widgets/font_control_bar.dart';

class PrayerScreen extends ConsumerWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedKategoriDoaProvider);
    final itemsAsync = ref.watch(prayerItemsProvider);
    final fontSize = ref.watch(arabicFontSizeProvider);
    final showLatin = ref.watch(showLatinProvider);
    final showTranslation = ref.watch(showTranslationProvider);

    final categories = KategoriDoa.values;
    final currentIdx = categories.indexOf(selected);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panduan Doa Ziarah'),
      ),
      body: Column(
        children: [
          Container(
            height: 52,
            color: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = categories[index];
                final isSelected = cat == selected;
                return ChoiceChip(
                  label: Text(cat.label),
                  selected: isSelected,
                  showCheckmark: false,
                  selectedColor: AppColors.secondary,
                  backgroundColor: AppColors.primaryVariant,
                  labelStyle: TextStyle(
                    color: isSelected ? AppColors.textPrimary : Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.5,
                  ),
                  side: BorderSide.none,
                  onSelected: (_) {
                    ref.read(selectedKategoriDoaProvider.notifier).state = cat;
                  },
                );
              },
            ),
          ),
          const FontControlBar(),
          Expanded(
            child: itemsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Gagal memuat doa: $err')),
              data: (items) {
                return ListView(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
                  children: [
                    ...items.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: DoaCard(
                          item: item,
                          arabicFontSize: fontSize,
                          showLatin: showLatin,
                          showTranslation: showTranslation,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.softAccent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: Text(
                        AppConstants.prayerVariationNote,
                        style: AppTypography.bodySecondary.copyWith(fontSize: 12.5),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton.icon(
                          onPressed: currentIdx > 0
                              ? () => ref
                                  .read(selectedKategoriDoaProvider.notifier)
                                  .state = categories[currentIdx - 1]
                              : null,
                          icon: const Icon(Icons.arrow_back_rounded, size: 18),
                          label: const Text('Sebelumnya'),
                        ),
                        FilledButton.icon(
                          onPressed: currentIdx < categories.length - 1
                              ? () => ref
                                  .read(selectedKategoriDoaProvider.notifier)
                                  .state = categories[currentIdx + 1]
                              : null,
                          icon:
                              const Icon(Icons.arrow_forward_rounded, size: 18),
                          label: const Text('Selanjutnya'),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
