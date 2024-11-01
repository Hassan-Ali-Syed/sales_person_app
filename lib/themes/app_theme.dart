// ignore_for_file: deprecated_member_use

part of 'themes.dart';

class AppTheme {
  const AppTheme._();

  static Map<int, Color> getSwatch(Color color) {
    final hslColor = HSLColor.fromColor(color);
    final lightness = hslColor.lightness;

    /// if [500] is the default color, there are at LEAST five
    /// steps below [500]. (i.e. 400, 300, 200, 100, 50.) A
    /// divisor of 5 would mean [50] is a lightness of 1.0 or
    /// a color of #ffffff. A value of six would be near white
    /// but not quite.
    const lowDivisor = 6;

    /// if [500] is the default color, there are at LEAST four
    /// steps above [500]. A divisor of 4 would mean [900] is
    /// a lightness of 0.0 or color of #000000
    const highDivisor = 5;

    final lowStep = (1.0 - lightness) / lowDivisor;
    final highStep = lightness / highDivisor;

    return {
      50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
      100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
      200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
      300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
      400: (hslColor.withLightness(lightness + lowStep)).toColor(),
      500: (hslColor.withLightness(lightness)).toColor(),
      600: (hslColor.withLightness(lightness - highStep)).toColor(),
      700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
      800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
      900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
    };
  }

  static ThemeData build({
    required Brightness brightness,
    required MaterialColor swatchColors,
    required Color primaryColor,
  }) =>
      ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: swatchColors),
        textTheme: buildTextTheme(
          textColor: LightTheme.textColor,
        ),
        useMaterial3: false,
      ).copyWith(
        primaryIconTheme:
            const IconThemeData(color: AppColors.primaryIconColor),
        appBarTheme: AppBarTheme(
          color: LightTheme.appBarBackgroundColor,
          titleTextStyle: GoogleFonts.nunitoSans(
              textStyle: const TextStyle(
            fontSize: Sizes.TEXT_SIZE_20,
            fontWeight: FontWeight.bold,
            color: LightTheme.appBarTextColor,
          )),
          iconTheme: const IconThemeData(color: LightTheme.iconColor),
        ),
        brightness: brightness,
        dialogBackgroundColor: LightTheme.dialogBackgroundColor,

        primaryColor: const Color(0xffE9E8E7),
        primaryColorLight: swatchColors.shade200,
        primaryColorDark: const Color(0xff007e87),
        scaffoldBackgroundColor: LightTheme.scaffoldBackgroundColor,

        dividerColor: LightTheme.dividerColor,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: LightTheme.progressIndicatorColor,
        ),
        // errorColor: LightTheme.errorColor ,
        // inputDecorationTheme: inputDecorationTheme(
        //   primaryColor: primaryColor,
        //   errorColor: LightTheme.errorColor ,
        //   fillColor: LightTheme.fillColor ,
        //   hintColor: swatchColors.shade300,
        // ),
        elevatedButtonTheme: elevatedButtonTheme(primaryColor: primaryColor),
        textButtonTheme: textButtonTheme(primaryColor: primaryColor),
        outlinedButtonTheme: outlinedButtonTheme(
          primaryColor: primaryColor,
          borderColor: swatchColors.shade700,
        ),
        iconTheme: const IconThemeData(
          color: LightTheme.iconColor,
        ),
        scrollbarTheme: scrollbarTheme(primaryColor: primaryColor),
        dataTableTheme: dataTableTheme(
          primaryColor: primaryColor,
          textColor: swatchColors.shade400,
        ),
      );
}
