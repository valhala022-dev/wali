import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import 'splash_controller.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<bool>>(splashInitProvider, (_, next) {
      next.whenData((ready) {
        if (ready && context.mounted) {
          context.go(AppRoutes.home);
        }
      });
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primary, AppColors.primaryVariant],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SvgPicture.asset(
                  'assets/images/branding/islamic_ornament.svg',
                  height: 110,
                  fit: BoxFit.fill,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/images/branding/logo_bumi_wali.svg',
                        width: 112,
                        height: 112,
                      ),
                      const SizedBox(height: 22),
                      const Text(
                        AppConstants.appTitleUpper,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 4.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        AppConstants.appTagline,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.5,
                          color: AppColors.softAccent,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Positioned(
                bottom: 44,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.6,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.secondary),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Menyiapkan basis data offline...',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.softAccent,
                      ),
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
