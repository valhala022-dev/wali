import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/utils/clipboard_helper.dart';
import '../../../core/utils/coordinate_formatter.dart';
import '../../../models/makam_wali_model.dart';
import '../../../services/connectivity_service.dart';
import '../../../services/map_launcher_service.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/common/offline_banner.dart';

class LokasiPetaSection extends ConsumerWidget {
  final MakamWaliModel makam;

  const LokasiPetaSection({super.key, required this.makam});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnline = ref.watch(isOnlineProvider).valueOrNull ?? false;
    final coordString =
        CoordinateFormatter.format(makam.latitude, makam.longitude);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Informasi Lokasi', style: AppTypography.titleSmall),
                const SizedBox(height: 10),
                _LocationRow(label: 'Alamat', value: makam.alamat),
                _LocationRow(label: 'Desa / Kel.', value: makam.desa),
                _LocationRow(label: 'Kecamatan', value: makam.kecamatan),
                _LocationRow(label: 'Kabupaten', value: 'Tuban, Jawa Timur'),
                const Divider(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Koordinat GPS',
                            style: AppTypography.bodySecondary,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            coordString,
                            style: AppTypography.titleSmall.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton.filledTonal(
                      onPressed: () => ClipboardHelper.copyText(
                        context,
                        text: coordString,
                        label: 'Koordinat',
                      ),
                      icon: const Icon(Icons.copy_rounded, size: 18),
                      tooltip: 'Salin koordinat',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        if (isOnline) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 220,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(makam.latitude, makam.longitude),
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('makam_${makam.id}'),
                    position: LatLng(makam.latitude, makam.longitude),
                    infoWindow: InfoWindow(
                      title: makam.namaMakam,
                      snippet: makam.lokasiRingkas,
                    ),
                  ),
                },
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
              ),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () async {
                final ok = await ref
                    .read(mapLauncherServiceProvider)
                    .openDirections(
                      latitude: makam.latitude,
                      longitude: makam.longitude,
                    );
                if (!ok && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Gagal membuka aplikasi Google Maps.'),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.directions_rounded),
              label: const Text('Petunjuk Arah (Google Maps)'),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ] else ...[
          OfflineBanner(
            message:
                'Tampilan peta interaktif dan navigasi rute Google Maps membutuhkan koneksi internet. Anda tetap dapat menggunakan alamat dan menyalin koordinat di atas secara offline.',
            onRetry: () => ref.invalidate(isOnlineProvider),
          ),
        ],
      ],
    );
  }
}

class _LocationRow extends StatelessWidget {
  final String label;
  final String value;

  const _LocationRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            child: Text(label, style: AppTypography.bodySecondary),
          ),
          const Text(': '),
          Expanded(child: Text(value, style: AppTypography.body)),
        ],
      ),
    );
  }
}
