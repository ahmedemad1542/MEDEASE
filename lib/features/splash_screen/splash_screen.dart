import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medease1/core/routing/app_routes.dart';
import 'package:medease1/core/storage/storage_helper.dart';
import 'package:medease1/core/storage/storage_keys.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    final isFirstTime = await StorageHelper().getData(key: StorageKeys.isFirstTime);

    if (isFirstTime == null || isFirstTime == 'true') {
      // first time opening app
      context.goNamed(AppRoutes.loginScreen);
    } else {
      // Have opened app before
      context.goNamed(AppRoutes.homeScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash.jpg', // ضع شعار التطبيق في مجلد assets
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
