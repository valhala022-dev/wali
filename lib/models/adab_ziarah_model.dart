class AdabZiarahModel {
  final int id;
  final int urutan;
  final String judulAdab;
  final String penjelasan;
  final String? pathIlustrasi;

  const AdabZiarahModel({
    required this.id,
    required this.urutan,
    required this.judulAdab,
    required this.penjelasan,
    this.pathIlustrasi,
  });
}
