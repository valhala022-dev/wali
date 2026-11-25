import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

/// Mengelola izin lokasi secara kontekstual (just-in-time) sesuai PRD Bagian 13.
/// Tidak pernah dipanggil di Splash Screen atau Halaman Beranda.
class LocationPermissionService {
  Future<bool> requestLocationPermissionIfNeeded() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  Future<Position?> getCurrentPosition() async {
    final granted = await requestLocationPermissionIfNeeded();
    if (!granted) return null;
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );
    } catch (_) {
      return null;
    }
  }
}

final locationPermissionServiceProvider =
    Provider<LocationPermissionService>((ref) {
  return LocationPermissionService();
});
