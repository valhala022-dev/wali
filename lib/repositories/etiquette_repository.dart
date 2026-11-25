import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../models/adab_ziarah_model.dart';

class EtiquetteRepository {
  final AppDatabase _db;

  EtiquetteRepository(this._db);

  Future<List<AdabZiarahModel>> getAllAdab() async {
    final rows = await _db.etiquetteDao.getAllAdab();
    return rows
        .map(
          (r) => AdabZiarahModel(
            id: r.id,
            urutan: r.urutan,
            judulAdab: r.judulAdab,
            penjelasan: r.penjelasan,
            pathIlustrasi: r.pathIlustrasi,
          ),
        )
        .toList();
  }
}

final etiquetteRepositoryProvider = Provider<EtiquetteRepository>((ref) {
  return EtiquetteRepository(ref.watch(appDatabaseProvider));
});
