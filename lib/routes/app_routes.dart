class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String home = '/home';
  static const String map = '/map';
  static const String prayer = '/prayer';
  static const String etiquette = '/etiquette';
  static const String about = '/about';

  static String detailWali(int id) => '/detail-wali/$id';
  static String galleryViewer(int id) => '/detail-wali/$id/gallery-viewer';
}
