import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/app_database.dart';

final splashInitProvider = FutureProvider<bool>((ref) async {
  final db = ref.watch(appDatabaseProvider);
  final minDelay = Future<void>.delayed(const Duration(milliseconds: 1800));
  final dbCheck = db.verifyReady();
  final results = await Future.wait([minDelay, dbCheck]);
  return results[1] as bool;
});
