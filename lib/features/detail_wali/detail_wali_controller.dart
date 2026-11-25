import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/galeri_item_model.dart';
import '../../models/makam_wali_model.dart';
import '../../repositories/makam_repository.dart';

class DetailWaliData {
  final MakamWaliModel makam;
  final List<GaleriItemModel> galeri;

  const DetailWaliData({required this.makam, required this.galeri});
}

final detailWaliProvider =
    FutureProvider.family<DetailWaliData?, int>((ref, makamId) async {
  final repo = ref.watch(makamRepositoryProvider);
  final makam = await repo.getById(makamId);
  if (makam == null) return null;
  final galeri = await repo.getGaleri(makamId);
  return DetailWaliData(makam: makam, galeri: galeri);
});
