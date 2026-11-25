import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../models/panduan_doa_model.dart';
import '../../repositories/prayer_repository.dart';

final selectedKategoriDoaProvider =
    StateProvider<KategoriDoa>((ref) => KategoriDoa.doaMasuk);

final arabicFontSizeProvider =
    StateProvider<double>((ref) => AppConstants.defaultArabicFontSize);

final showLatinProvider = StateProvider<bool>((ref) => true);
final showTranslationProvider = StateProvider<bool>((ref) => true);

final prayerItemsProvider =
    FutureProvider<List<PanduanDoaModel>>((ref) async {
  final repo = ref.watch(prayerRepositoryProvider);
  final kategori = ref.watch(selectedKategoriDoaProvider);
  return repo.getByKategori(kategori);
});
