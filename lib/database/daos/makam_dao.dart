import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/galeri_makam_table.dart';
import '../tables/makam_wali_table.dart';

part 'makam_dao.g.dart';

@DriftAccessor(tables: [MakamWaliTable, GaleriMakamTable])
class MakamDao extends DatabaseAccessor<AppDatabase> with _$MakamDaoMixin {
  MakamDao(super.db);

  Future<List<MakamWaliTableData>> getAllMakam() {
    return (select(makamWaliTable)
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();
  }

  Future<List<MakamWaliTableData>> searchAndFilter({
    String query = '',
    String? kecamatan,
  }) {
    final trimmed = query.trim();
    return (select(makamWaliTable)
          ..where((t) {
            Expression<bool> predicate = const Constant(true);
            if (kecamatan != null && kecamatan.isNotEmpty) {
              predicate = predicate & t.kecamatan.equals(kecamatan);
            }
            if (trimmed.isNotEmpty) {
              final pattern = '%$trimmed%';
              predicate = predicate &
                  (t.namaWali.like(pattern) |
                      t.namaMakam.like(pattern) |
                      t.desa.like(pattern) |
                      t.kecamatan.like(pattern));
            }
            return predicate;
          })
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();
  }

  Future<MakamWaliTableData?> getMakamById(int id) {
    return (select(makamWaliTable)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<List<GaleriMakamTableData>> getGaleriByMakamId(int makamId) {
    return (select(galeriMakamTable)
          ..where((t) => t.makamId.equals(makamId))
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();
  }
}
