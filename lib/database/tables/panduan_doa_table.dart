import 'package:drift/drift.dart';

class PanduanDoaTable extends Table {
  @override
  String get tableName => 'panduan_doa';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get kategori => text().named('kategori')();
  IntColumn get urutan => integer().named('urutan')();
  TextColumn get judulBagian => text().named('judul_bagian').nullable()();
  TextColumn get teksArab => text().named('teks_arab')();
  TextColumn get teksLatin => text().named('teks_latin').nullable()();
  TextColumn get terjemahan => text().named('terjemahan')();
  TextColumn get catatan => text().named('catatan').nullable()();
}
