import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/tuban_kecamatan.dart';
import '../../models/makam_wali_model.dart';
import '../../repositories/makam_repository.dart';

final homeSearchQueryProvider = StateProvider<String>((ref) => '');
final homeSelectedKecamatanProvider =
    StateProvider<String>((ref) => TubanKecamatan.semua);

final filteredMakamListProvider =
    FutureProvider<List<MakamWaliModel>>((ref) async {
  final repo = ref.watch(makamRepositoryProvider);
  final query = ref.watch(homeSearchQueryProvider);
  final kecamatan = ref.watch(homeSelectedKecamatanProvider);
  return repo.searchAndFilter(
    query: query,
    selectedKecamatan: kecamatan,
  );
});

final totalMakamCountProvider = FutureProvider<int>((ref) async {
  final repo = ref.watch(makamRepositoryProvider);
  final all = await repo.getAllMakam();
  return all.length;
});
