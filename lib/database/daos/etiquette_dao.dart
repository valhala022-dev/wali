import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/adab_ziarah_table.dart';

part 'etiquette_dao.g.dart';

@DriftAccessor(tables: [AdabZiarahTable])
class EtiquetteDao extends DatabaseAccessor<AppDatabase>
    with _$EtiquetteDaoMixin {
  EtiquetteDao(super.db);

  Future<List<AdabZiarahTableData>> getAllAdab() {
    return (select(adabZiarahTable)
          ..orderBy([(t) => OrderingTerm.asc(t.urutan)]))
        .get();
  }
}
