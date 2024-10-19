import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController fadeControllerTitle;
  late Animation<double> fadeAnimationTitle;
  late AnimationController fadeControllerLogo;
  late Animation<double> fadeAnimationLogo;

  @override
  void initState() {
    super.initState();

    fadeControllerTitle = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    fadeAnimationTitle = Tween<double>(begin: 0.0, end: 1).animate(
      CurvedAnimation(
        parent: fadeControllerTitle,
        curve: Curves.easeInOut,
      ),
    );

    fadeControllerLogo = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    fadeAnimationLogo = Tween<double>(begin: 0.2, end: 1).animate(
      CurvedAnimation(
        parent: fadeControllerLogo,
        curve: Curves.easeInOut,
      ),
    );
    Future.delayed(const Duration(seconds: 1), () {
      fadeControllerTitle.forward();
      Future.delayed(const Duration(seconds: 1), () {
        fadeControllerLogo.forward();
      });
    });

    Timer(const Duration(seconds: 4), () {
      Get.offNamed(AppRoutes.SIGN_IN);
    });
  }

  @override
  void dispose() {
    fadeControllerTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE9E8E7),
      body: Center(
        child: Column(children: [
          FadeTransition(
            opacity: fadeAnimationTitle,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: Sizes.PADDING_80, bottom: Sizes.PADDING_144),
              child: Text(
                'posh textiles',
                style: context.titleLarge.copyWith(
                  fontSize: Sizes.TEXT_SIZE_50,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff58595B),
                  fontFamily: 'Nunito Sans',
                ),
              ),
            ),
          ),
          FadeTransition(
            opacity: fadeAnimationLogo,
            child: Image.asset(
              height: Sizes.HEIGHT_260,
              AppAssets.getPNGIcon(AppAssets.SPLASH_SCREEN_LOGO),
            ),
          ),
        ]),
      ),
    );
  }
}
