import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';

class QuickAccessRow extends StatelessWidget {
  const QuickAccessRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ShortcutTile(
            icon: Icons.menu_book_rounded,
            title: 'Panduan Doa',
            subtitle: 'Yasin, Tahlil & Doa',
            onTap: () => context.go(AppRoutes.prayer),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ShortcutTile(
            icon: Icons.volunteer_activism_rounded,
            title: 'Adab Ziarah',
            subtitle: '10 Tata Tertib',
            onTap: () => context.go(AppRoutes.etiquette),
          ),
        ),
      ],
    );
  }
}

class _ShortcutTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ShortcutTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.softAccent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.secondary, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.titleSmall.copyWith(fontSize: 13.5),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      subtitle,
                      style: AppTypography.bodySecondary.copyWith(fontSize: 11.5),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
