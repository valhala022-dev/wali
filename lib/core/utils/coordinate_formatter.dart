class CoordinateFormatter {
  CoordinateFormatter._();

  static String format(double latitude, double longitude) {
    return '${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}';
  }
}
