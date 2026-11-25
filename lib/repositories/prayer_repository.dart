import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../models/panduan_doa_model.dart';

class PrayerRepository {
  final AppDatabase _db;

  PrayerRepository(this._db);

  Future<List<PanduanDoaModel>> getByKategori(KategoriDoa kategori) async {
    final rows = await _db.prayerDao.getDoaByKategori(kategori.dbKey);
    return rows
        .map(
          (r) => PanduanDoaModel(
            id: r.id,
            kategori: r.kategori,
            urutan: r.urutan,
            judulBagian: r.judulBagian,
            teksArab: r.teksArab,
            teksLatin: r.teksLatin,
            terjemahan: r.terjemahan,
            catatan: r.catatan,
          ),
        )
        .toList();
  }
}

final prayerRepositoryProvider = Provider<PrayerRepository>((ref) {
  return PrayerRepository(ref.watch(appDatabaseProvider));
});
