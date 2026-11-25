import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/about/about_screen.dart';
import '../features/detail_wali/detail_wali_screen.dart';
import '../features/detail_wali/gallery_viewer_screen.dart';
import '../features/etiquette/etiquette_screen.dart';
import '../features/home/home_screen.dart';
import '../features/map/map_screen.dart';
import '../features/prayer/prayer_screen.dart';
import '../features/splash/splash_screen.dart';
import '../models/galeri_item_model.dart';
import '../screens/main_shell_screen.dart';
import 'app_routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.map,
                builder: (context, state) => const MapScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.prayer,
                builder: (context, state) => const PrayerScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.etiquette,
                builder: (context, state) => const EtiquetteScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.about,
                builder: (context, state) => const AboutScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/detail-wali/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 1;
          return DetailWaliScreen(makamId: id);
        },
        routes: [
          GoRoute(
            path: 'gallery-viewer',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              final items =
                  (extra?['items'] as List<GaleriItemModel>?) ?? const [];
              final initialIndex = (extra?['initialIndex'] as int?) ?? 0;
              return GalleryViewerScreen(
                items: items,
                initialIndex: initialIndex,
              );
            },
          ),
        ],
      ),
    ],
  );
});
