import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/panduan_doa_table.dart';

part 'prayer_dao.g.dart';

@DriftAccessor(tables: [PanduanDoaTable])
class PrayerDao extends DatabaseAccessor<AppDatabase> with _$PrayerDaoMixin {
  PrayerDao(super.db);

  Future<List<PanduanDoaTableData>> getDoaByKategori(String kategori) {
    return (select(panduanDoaTable)
          ..where((t) => t.kategori.equals(kategori))
          ..orderBy([(t) => OrderingTerm.asc(t.urutan)]))
        .get();
  }
}
