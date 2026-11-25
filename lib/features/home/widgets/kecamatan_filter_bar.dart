import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/tuban_kecamatan.dart';
import '../home_controller.dart';

class KecamatanFilterBar extends ConsumerWidget {
  const KecamatanFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(homeSelectedKecamatanProvider);

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: TubanKecamatan.daftarKecamatan.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final kec = TubanKecamatan.daftarKecamatan[index];
          final isSelected = selected == kec;
          return ChoiceChip(
            label: Text(kec),
            selected: isSelected,
            showCheckmark: false,
            onSelected: (_) {
              ref.read(homeSelectedKecamatanProvider.notifier).state = kec;
            },
          );
        },
      ),
    );
  }
}
