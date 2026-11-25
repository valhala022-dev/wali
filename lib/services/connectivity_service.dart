import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectivityService {
  final Connectivity _connectivity;

  ConnectivityService([Connectivity? connectivity])
      : _connectivity = connectivity ?? Connectivity();

  Stream<bool> get onStatusChanged {
    return _connectivity.onConnectivityChanged.map(_hasNetwork);
  }

  Future<bool> isOnline() async {
    try {
      final results = await _connectivity.checkConnectivity();
      return _hasNetwork(results);
    } catch (_) {
      return false;
    }
  }

  bool _hasNetwork(List<ConnectivityResult> results) {
    return results.any(
      (r) =>
          r == ConnectivityResult.mobile ||
          r == ConnectivityResult.wifi ||
          r == ConnectivityResult.ethernet,
    );
  }
}

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

final isOnlineProvider = StreamProvider<bool>((ref) async* {
  final service = ref.watch(connectivityServiceProvider);
  yield await service.isOnline();
  yield* service.onStatusChanged;
});
