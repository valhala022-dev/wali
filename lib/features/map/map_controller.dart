import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/makam_wali_model.dart';
import '../../repositories/makam_repository.dart';

final allMakamForMapProvider = FutureProvider<List<MakamWaliModel>>((ref) {
  return ref.watch(makamRepositoryProvider).getAllMakam();
});

final selectedMapMakamProvider = StateProvider<MakamWaliModel?>((ref) => null);
