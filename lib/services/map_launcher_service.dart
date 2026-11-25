import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

/// Layanan pembuka navigasi rute Google Maps menggunakan Universal Google Maps URL
/// sesuai PRD Bagian 13 (tidak memakan kuota Directions API berbayar).
class MapLauncherService {
  Future<bool> openDirections({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude',
    );
    try {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      // Fallback ke browser bila aplikasi Google Maps tidak terpasang (PRD NFR #5)
      return await launchUrl(uri, mode: LaunchMode.platformDefault);
    } catch (_) {
      return false;
    }
  }
}

final mapLauncherServiceProvider = Provider<MapLauncherService>((ref) {
  return MapLauncherService();
});
