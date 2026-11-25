import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/tuban_kecamatan.dart';
import '../database/app_database.dart';
import '../models/galeri_item_model.dart';
import '../models/makam_wali_model.dart';

class MakamRepository {
  final AppDatabase _db;

  MakamRepository(this._db);

  Future<List<MakamWaliModel>> getAllMakam() async {
    final rows = await _db.makamDao.getAllMakam();
    return rows.map(_mapMakam).toList();
  }

  Future<List<MakamWaliModel>> searchAndFilter({
    String query = '',
    String selectedKecamatan = TubanKecamatan.semua,
  }) async {
    final filterKec =
        selectedKecamatan == TubanKecamatan.semua ? null : selectedKecamatan;
    final rows = await _db.makamDao.searchAndFilter(
      query: query,
      kecamatan: filterKec,
    );
    return rows.map(_mapMakam).toList();
  }

  Future<MakamWaliModel?> getById(int id) async {
    final row = await _db.makamDao.getMakamById(id);
    if (row == null) return null;
    return _mapMakam(row);
  }

  Future<List<GaleriItemModel>> getGaleri(int makamId) async {
    final rows = await _db.makamDao.getGaleriByMakamId(makamId);
    return rows
        .map(
          (r) => GaleriItemModel(
            id: r.id,
            makamId: r.makamId,
            pathGambar: r.pathGambar,
            kategoriFoto: r.kategoriFoto,
            keterangan: r.keterangan,
            sumberFoto: r.sumberFoto,
          ),
        )
        .toList();
  }

  MakamWaliModel _mapMakam(MakamWaliTableData r) {
    return MakamWaliModel(
      id: r.id,
      namaWali: r.namaWali,
      namaMakam: r.namaMakam,
      deskripsiSingkat: r.deskripsiSingkat,
      biografi: r.biografi,
      sejarahMakam: r.sejarahMakam,
      karomahKeistimewaan: r.karomahKeistimewaan,
      alamat: r.alamat,
      desa: r.desa,
      kecamatan: r.kecamatan,
      latitude: r.latitude,
      longitude: r.longitude,
      fotoMakam: r.fotoMakam,
      gambarIlustrasiWali: r.gambarIlustrasiWali,
      sumberInformasi: r.sumberInformasi,
      statusVerifikasi: r.statusVerifikasi,
    );
  }
}

final makamRepositoryProvider = Provider<MakamRepository>((ref) {
  return MakamRepository(ref.watch(appDatabaseProvider));
});
