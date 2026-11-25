import 'package:drift/drift.dart';

class MakamWaliTable extends Table {
  @override
  String get tableName => 'makam_wali';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get namaWali => text().named('nama_wali')();
  TextColumn get namaMakam => text().named('nama_makam')();
  TextColumn get deskripsiSingkat => text().named('deskripsi_singkat')();
  TextColumn get biografi => text().named('biografi')();
  TextColumn get sejarahMakam => text().named('sejarah_makam')();
  TextColumn get karomahKeistimewaan => text().named('karomah_keistimewaan')();
  TextColumn get alamat => text().named('alamat')();
  TextColumn get desa => text().named('desa')();
  TextColumn get kecamatan => text().named('kecamatan')();
  RealColumn get latitude => real().named('latitude')();
  RealColumn get longitude => real().named('longitude')();
  TextColumn get fotoMakam => text().named('foto_makam')();
  TextColumn get gambarIlustrasiWali =>
      text().named('gambar_ilustrasi_wali').nullable()();
  TextColumn get sumberInformasi => text().named('sumber_informasi')();
  TextColumn get statusVerifikasi => text().named('status_verifikasi')();
}
