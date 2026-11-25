import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/adab_ziarah_model.dart';
import '../../repositories/etiquette_repository.dart';

final etiquetteListProvider = FutureProvider<List<AdabZiarahModel>>((ref) {
  return ref.watch(etiquetteRepositoryProvider).getAllAdab();
});
