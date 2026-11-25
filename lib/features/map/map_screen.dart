import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/constants/app_constants.dart';
import '../../services/connectivity_service.dart';
import '../../services/location_permission_service.dart';
import '../../theme/app_colors.dart';
import 'map_controller.dart';
import 'widgets/makam_preview_sheet.dart';
import 'widgets/offline_map_fallback.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  GoogleMapController? _mapController;
  bool _myLocationEnabled = false;

  Future<void> _onMyLocationPressed() async {
    final pos = await ref
        .read(locationPermissionServiceProvider)
        .getCurrentPosition();
    if (!mounted) return;
    if (pos == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Izin lokasi diperlukan untuk menampilkan posisi Anda di peta.',
          ),
        ),
      );
      return;
    }
    setState(() => _myLocationEnabled = true);
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(pos.latitude, pos.longitude), 13),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isOnline = ref.watch(isOnlineProvider).valueOrNull ?? false;
    final makamAsync = ref.watch(allMakamForMapProvider);
    final selectedMakam = ref.watch(selectedMapMakamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta Sebaran Makam Wali'),
      ),
      body: makamAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Gagal memuat lokasi: $err')),
        data: (items) {
          if (!isOnline) {
            return OfflineMapFallback(
              items: items,
              onRetry: () => ref.invalidate(isOnlineProvider),
            );
          }

          final markers = items.map((m) {
            return Marker(
              markerId: MarkerId('wali_${m.id}'),
              position: LatLng(m.latitude, m.longitude),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen,
              ),
              infoWindow: InfoWindow(
                title: m.namaMakam,
                snippet: 'Kec. ${m.kecamatan}',
              ),
              onTap: () {
                ref.read(selectedMapMakamProvider.notifier).state = m;
              },
            );
          }).toSet();

          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(
                    AppConstants.tubanCenterLat,
                    AppConstants.tubanCenterLng,
                  ),
                  zoom: 10.6,
                ),
                markers: markers,
                myLocationEnabled: _myLocationEnabled,
                myLocationButtonEnabled: false,
                onMapCreated: (controller) => _mapController = controller,
                onTap: (_) {
                  ref.read(selectedMapMakamProvider.notifier).state = null;
                },
              ),
              Positioned(
                top: 14,
                right: 14,
                child: FloatingActionButton.small(
                  heroTag: 'my_location_btn',
                  backgroundColor: AppColors.surface,
                  foregroundColor: AppColors.primary,
                  onPressed: _onMyLocationPressed,
                  tooltip: 'Lokasi Saya',
                  child: const Icon(Icons.my_location_rounded),
                ),
              ),
              if (selectedMakam != null)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: MakamPreviewSheet(
                    makam: selectedMakam,
                    onClose: () {
                      ref.read(selectedMapMakamProvider.notifier).state = null;
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
