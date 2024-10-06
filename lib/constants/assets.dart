// ignore_for_file: constant_identifier_names

part of 'constants.dart';

class AppAssets {
  static const String SPLASH_SCREEN_LOGO = 'splash_screen_logo';
  static const String START_SCREEN_IMAGE = 'start_screen_image';
  static const String APPBAR_BELL_NOTIFICATION_ICON =
      'appbar_bell_notification_icon';
  static const String NAVIGATION_DRAWER_ICON = 'navigation_drawer_icon';
  static const String APPLE_LOGO = 'apple_logo';
  static const String MICROSOFT_LOGO = 'microsoft_logo';
  static const String GOOGLE_LOGO = 'google_logo';

  static String getSVGIcon(String iconName) => 'assets/icons/$iconName.svg';

  static String getPNGIcon(String iconName) => 'assets/icons/$iconName.png';

  static String getSVGImage(String imageName) => 'assets/images/$imageName.svg';

  static String getPNGImage(String imageName) => 'assets/images/$imageName.png';
}
