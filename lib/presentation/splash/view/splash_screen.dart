import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/constansts/app_images.dart';
import '../../../core/route/route_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    Timer(const Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, Routes.bottomNavBarRoute));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.splashBackground,
              height: 250,
              width: 250,
            ),
          ],
        ),
      ),
    );
  }
}
