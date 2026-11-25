import 'package:drift/drift.dart';

class AdabZiarahTable extends Table {
  @override
  String get tableName => 'adab_ziarah';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get urutan => integer().named('urutan')();
  TextColumn get judulAdab => text().named('judul_adab')();
  TextColumn get penjelasan => text().named('penjelasan')();
  TextColumn get pathIlustrasi => text().named('path_ilustrasi').nullable()();
}
