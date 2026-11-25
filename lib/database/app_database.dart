import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../core/constants/app_constants.dart';
import 'daos/etiquette_dao.dart';
import 'daos/makam_dao.dart';
import 'daos/prayer_dao.dart';
import 'tables/adab_ziarah_table.dart';
import 'tables/galeri_makam_table.dart';
import 'tables/makam_wali_table.dart';
import 'tables/panduan_doa_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    MakamWaliTable,
    GaleriMakamTable,
    PanduanDoaTable,
    AdabZiarahTable,
  ],
  daos: [
    MakamDao,
    PrayerDao,
    EtiquetteDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// Ensures pre-populated SQLite asset is copied and readable during Splash.
  Future<bool> verifyReady() async {
    final result = await customSelect('SELECT COUNT(*) AS total FROM makam_wali').getSingle();
    return (result.read<int>('total')) > 0;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, AppConstants.dbFileName));

    if (!await file.exists()) {
      final blob = await rootBundle.load(AppConstants.dbAssetPath);
      final buffer = blob.buffer;
      await file.writeAsBytes(
        buffer.asUint8List(blob.offsetInBytes, blob.lengthInBytes),
        flush: true,
      );
    }

    return NativeDatabase.createInBackground(file);
  });
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
