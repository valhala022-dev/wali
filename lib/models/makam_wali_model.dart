class MakamWaliModel {
  final int id;
  final String namaWali;
  final String namaMakam;
  final String deskripsiSingkat;
  final String biografi;
  final String sejarahMakam;
  final String karomahKeistimewaan;
  final String alamat;
  final String desa;
  final String kecamatan;
  final double latitude;
  final double longitude;
  final String fotoMakam;
  final String? gambarIlustrasiWali;
  final String sumberInformasi;
  final String statusVerifikasi;

  const MakamWaliModel({
    required this.id,
    required this.namaWali,
    required this.namaMakam,
    required this.deskripsiSingkat,
    required this.biografi,
    required this.sejarahMakam,
    required this.karomahKeistimewaan,
    required this.alamat,
    required this.desa,
    required this.kecamatan,
    required this.latitude,
    required this.longitude,
    required this.fotoMakam,
    this.gambarIlustrasiWali,
    required this.sumberInformasi,
    required this.statusVerifikasi,
  });

  bool get isTerverifikasi => statusVerifikasi == 'terverifikasi';

  String get labelVerifikasi =>
      isTerverifikasi ? 'Data Terverifikasi' : 'Membutuhkan Verifikasi Lanjutan';

  String get lokasiRingkas => 'Desa $desa, Kec. $kecamatan';
}
