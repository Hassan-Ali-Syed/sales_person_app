import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/themes/themes.dart';

class ThemeController extends GetxController {
  late Rx<Color> accentColor;
  late Rx<bool> isDarkMode;
  Rx<Color> backgroundColor = AppColors.backgroundColor.obs;

  @override
  void onInit() {
    isDarkMode = getSystemDefaultTheme().obs;
    accentColor = getColors[3].obs;
    //isDarkMode.value = box.read(AppStrings.THEME_MODE_KEY);
    isDarkMode.value = false;
    super.onInit();
  }

  List<Color> get getColors => LightTheme.backgroundColors;

  intToColor(int indexColor) => getColors.elementAt(indexColor);

  int colorToInt(Color color) => getColors.indexWhere((item) => item == color);

  void changeThemeMode(bool val) {
    isDarkMode.value = val;

    Get.changeThemeMode(ThemeMode.light);
  }

  void changeAccent(Color color) {
    accentColor.value = color;

    Get.changeTheme(getTheme);
  }

  bool getSystemDefaultTheme() =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
      Brightness.light;

  ThemeData get getTheme => AppTheme.build(
        brightness: Brightness.light,
        swatchColors: MaterialColor(
          accentColor.value.value,
          AppTheme.getSwatch(accentColor.value),
        ),
        primaryColor: const Color(0xff44B2BC),
      );
}
