import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/routes/app_pages.dart';
import 'package:sales_person_app/routes/app_routes.dart';
import 'package:sales_person_app/themes/controller/theme_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(
    () => ThemeController(),
  );
  runApp(const MyApp());
}

class MyApp extends GetView<ThemeController> {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: controller.getTheme,
      debugShowCheckedModeBanner: false,
      title: AppStrings.APP_TITLE,
      initialRoute: AppRoutes.SPLASH_SCREEN,
      getPages: AppPages.pages,
      defaultTransition: Transition.cupertino,
    );
  }
}
