import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../models/galeri_item_model.dart';
import '../../theme/app_colors.dart';

class GalleryViewerScreen extends StatefulWidget {
  final List<GaleriItemModel> items;
  final int initialIndex;

  const GalleryViewerScreen({
    super.key,
    required this.items,
    this.initialIndex = 0,
  });

  @override
  State<GalleryViewerScreen> createState() => _GalleryViewerScreenState();
}

class _GalleryViewerScreenState extends State<GalleryViewerScreen> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Galeri')),
        body: const Center(child: Text('Tidak ada gambar tersedia.')),
      );
    }

    final current = widget.items[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        title: Text('${_currentIndex + 1} / ${widget.items.length}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.items.length,
              onPageChanged: (i) => setState(() => _currentIndex = i),
              itemBuilder: (context, index) {
                final item = widget.items[index];
                return InteractiveViewer(
                  minScale: 1.0,
                  maxScale: 4.0,
                  child: Center(
                    child: Image.asset(
                      item.pathGambar,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.black87,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (current.isIlustrasiWali)
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      AppConstants.artisticIllustrationLabel,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                Text(
                  current.keterangan,
                  style: const TextStyle(color: Colors.white, fontSize: 13.5),
                ),
                const SizedBox(height: 4),
                Text(
                  'Sumber: ${current.sumberFoto}',
                  style: const TextStyle(color: Colors.white70, fontSize: 11.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
