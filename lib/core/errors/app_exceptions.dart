class AppException implements Exception {
  final String message;
  final Object? cause;

  const AppException(this.message, [this.cause]);

  @override
  String toString() => message;
}

class OfflineMapException extends AppException {
  const OfflineMapException([
    super.message =
        'Peta interaktif dan navigasi rute membutuhkan koneksi internet. Anda tetap dapat melihat alamat lengkap dan menyalin koordinat makam secara offline.',
  ]);
}
