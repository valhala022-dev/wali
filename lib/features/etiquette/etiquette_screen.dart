import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/cards/adab_card.dart';
import 'etiquette_controller.dart';

class EtiquetteScreen extends ConsumerWidget {
  const EtiquetteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adabAsync = ref.watch(etiquetteListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tata Tertib & Adab Ziarah'),
      ),
      body: adabAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Gagal memuat adab ziarah: $err')),
        data: (items) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryVariant],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Menjaga Kekhusyukan & Cagar Budaya',
                      style: AppTypography.headingMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Ziarah kubur bertujuan mengingat akhirat, mendoakan para wali dan ulama, serta mengambil hikmah sejarah. Mari jaga adab dan kelestarian situs bersejarah di Kabupaten Tuban.',
                      style: TextStyle(
                        color: AppColors.softAccent,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ...items.map(
                (adab) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AdabCard(adab: adab),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
