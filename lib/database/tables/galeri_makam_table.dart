import 'package:drift/drift.dart';
import 'makam_wali_table.dart';

class GaleriMakamTable extends Table {
  @override
  String get tableName => 'galeri_makam';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get makamId =>
      integer().named('makam_id').references(MakamWaliTable, #id)();
  TextColumn get pathGambar => text().named('path_gambar')();
  TextColumn get kategoriFoto => text().named('kategori_foto')();
  TextColumn get keterangan => text().named('keterangan')();
  TextColumn get sumberFoto => text().named('sumber_foto')();
}
