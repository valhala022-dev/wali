class AppConstants {
  AppConstants._();

  static const String appName = 'Bumi Wali';
  static const String appTitleUpper = 'BUMI WALI';
  static const String appTagline = 'Jelajahi Sejarah dan Wisata Religi Tuban';
  static const String appVersion = 'Versi 1.0.0';

  // Default camera center: Kabupaten Tuban
  static const double tubanCenterLat = -6.894850;
  static const double tubanCenterLng = 112.063780;

  // Database asset
  static const String dbAssetPath = 'assets/database/bumi_wali_initial.db';
  static const String dbFileName = 'bumi_wali_v1.db';

  // Arabic font size limits (PRD Section 11.2)
  static const double defaultArabicFontSize = 24.0;
  static const double minArabicFontSize = 18.0;
  static const double maxArabicFontSize = 36.0;
  static const double fontSizeStep = 2.0;

  // Ethics & Attribution labels (PRD Section 6.3)
  static const String artisticIllustrationLabel =
      'Ilustrasi Tokoh Wali – Representasi Artistik';
  static const String prayerVariationNote =
      'Catatan: Susunan bacaan doa dan tahlil mengikuti tradisi umum masyarakat Tuban dan sekitarnya. Peziarah dapat menyesuaikan dengan amalan masing-masing.';
}
