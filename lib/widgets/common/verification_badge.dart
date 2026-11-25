import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class VerificationBadge extends StatelessWidget {
  final bool isVerified;
  final String label;

  const VerificationBadge({
    super.key,
    required this.isVerified,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isVerified ? AppColors.verifiedBg : AppColors.unverifiedBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isVerified
              ? AppColors.primary.withValues(alpha: 0.25)
              : AppColors.secondary.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isVerified ? Icons.verified_rounded : Icons.info_outline_rounded,
            size: 14,
            color: isVerified ? AppColors.verifiedText : AppColors.unverifiedText,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color:
                  isVerified ? AppColors.verifiedText : AppColors.unverifiedText,
            ),
          ),
        ],
      ),
    );
  }
}
