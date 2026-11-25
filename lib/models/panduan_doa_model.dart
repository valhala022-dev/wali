class PanduanDoaModel {
  final int id;
  final String kategori;
  final int urutan;
  final String? judulBagian;
  final String teksArab;
  final String? teksLatin;
  final String terjemahan;
  final String? catatan;

  const PanduanDoaModel({
    required this.id,
    required this.kategori,
    required this.urutan,
    this.judulBagian,
    required this.teksArab,
    this.teksLatin,
    required this.terjemahan,
    this.catatan,
  });
}

enum KategoriDoa {
  doaMasuk('doa_masuk', 'Doa Masuk Makam'),
  yasin('yasin', 'Surat Yasin'),
  tahlil('tahlil', 'Bacaan Tahlil'),
  doaTahlil('doa_tahlil', 'Doa Setelah Tahlil'),
  doaPenutup('doa_penutup', 'Doa Penutup Ziarah');

  final String dbKey;
  final String label;

  const KategoriDoa(this.dbKey, this.label);
}
