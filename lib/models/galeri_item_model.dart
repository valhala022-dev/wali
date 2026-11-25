class GaleriItemModel {
  final int id;
  final int makamId;
  final String pathGambar;
  final String kategoriFoto;
  final String keterangan;
  final String sumberFoto;

  const GaleriItemModel({
    required this.id,
    required this.makamId,
    required this.pathGambar,
    required this.kategoriFoto,
    required this.keterangan,
    required this.sumberFoto,
  });

  bool get isIlustrasiWali => kategoriFoto == 'ilustrasi_wali';

  String get labelKategori {
    switch (kategoriFoto) {
      case 'kompleks':
        return 'Kompleks Makam';
      case 'pintu_masuk':
        return 'Pintu Masuk / Gapura';
      case 'lingkungan':
        return 'Lingkungan Sekitar';
      case 'fasilitas':
        return 'Fasilitas Umum';
      case 'sejarah':
        return 'Dokumentasi Sejarah';
      case 'ilustrasi_wali':
        return 'Ilustrasi Tokoh Wali';
      default:
        return 'Galeri';
    }
  }
}
