import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Cari nama wali, makam, desa, atau kecamatan...',
        hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13.5),
        prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primary),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                onPressed: onClear,
                icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                tooltip: 'Hapus pencarian',
              )
            : null,
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.cardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
