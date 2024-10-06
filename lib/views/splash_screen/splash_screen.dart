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
  late AnimationController logoController;
  late AnimationController companyNameController;
  late Animation<double> logoAnimation;
  late Animation<double> companyNameAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animations
    logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    companyNameController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    logoAnimation = Tween<double>(begin: 544, end: 0).animate(
      CurvedAnimation(
          parent: logoController, curve: Curves.fastEaseInToSlowEaseOut),
    );
    companyNameAnimation = Tween<double>(begin: -200, end: 0).animate(
      CurvedAnimation(
          parent: companyNameController, curve: Curves.fastEaseInToSlowEaseOut),
    );

    // Start animations after a slight delay
    Future.delayed(const Duration(seconds: 1), () {
      logoController.forward();
      companyNameController.forward();
    });

    // Navigate to SignInScreen after 4 seconds
    Timer(const Duration(seconds: 4), () {
      Get.offNamed(AppRoutes.SIGN_IN);
    });
  }

  @override
  void dispose() {
    logoController.dispose();
    companyNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff7C7A7A),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AnimatedBuilder(
            animation: companyNameAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, companyNameAnimation.value),
                child: child,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: Sizes.PADDING_80, bottom: Sizes.PADDING_144),
              child: Text(
                'Posh Textiles',
                style: context.titleLarge.copyWith(
                  fontSize: Sizes.TEXT_SIZE_50,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffFAFAFA),
                  fontFamily: 'Nunito Sans',
                ),
              ),
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: logoAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, logoAnimation.value),
                  child: child,
                );
              },
              child: Image.asset(
                height: Sizes.HEIGHT_260,
                AppAssets.getPNGIcon(AppAssets.SPLASH_SCREEN_LOGO),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
