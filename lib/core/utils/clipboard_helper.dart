import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClipboardHelper {
  ClipboardHelper._();

  static Future<void> copyText(
    BuildContext context, {
    required String text,
    required String label,
  }) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label berhasil disalin ke clipboard.'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
