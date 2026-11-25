import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static const String uiFont = 'Inter';
  static const String arabicFont = 'ArabicNaskh';

  static TextStyle get headingLarge => const TextStyle(
        fontFamily: uiFont,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get headingMedium => const TextStyle(
        fontFamily: uiFont,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.35,
      );

  static TextStyle get titleSmall => const TextStyle(
        fontFamily: uiFont,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get body => const TextStyle(
        fontFamily: uiFont,
        fontSize: 14.5,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.6, // PRD Section 11.2 line-height 1.6
      );

  static TextStyle get bodySecondary => const TextStyle(
        fontFamily: uiFont,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  static TextStyle arabic(double fontSize) => TextStyle(
        fontFamily: arabicFont,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 2.0, // Generous line-height so Arabic harakat never clip
      );
}
