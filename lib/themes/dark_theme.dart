part of 'themes.dart';

class DarkTheme {
  static const List<Color> grayColors = [
    Color(0xff8e8e93),
    Color(0xff636366),
    Color(0xff48484a),
    Color(0xff3a3a3c),
    Color(0xff2c2c2e),
    Color(0xff1c1c1e),
  ];

  static Color get grayColorShade0 => grayColors[0];
  static Color get grayColorShade1 => grayColors[1];
  static Color get grayColorShade2 => grayColors[2];
  static Color get grayColorShade3 => grayColors[3];
  static Color get grayColorShade4 => grayColors[4];
  static Color get grayColorShade5 => grayColors[5];

  static const List<Color> backgroundColors = [
    Color(0xff232323),
    Color(0xff161616),
    Color(0xfffdfdfd),
    Color(0xff8c8c8c),
    Color(0xff0D0D0D),
  ];

  static const List<Color> aapBarColors = [
    Color(0xff232323),
    Color(0xff161616),
    Color(0xff232323),
    Color(0xff8c8c8c),
    Color(0xffe5e5e5),
  ];
//BACKGROUND COLORS
  static Color get darkShade0 => backgroundColors[0];
  static Color get darkShade1 => backgroundColors[1];
  static Color get darkShade2 => backgroundColors[2];
  static Color get darkShade3 => backgroundColors[3];
  static Color get darkShade4 => backgroundColors[4];

//scaffold portion
  static Color scaffoldBackgroundColor = darkShade2;
  static Color backgroundColor = darkShade1;
  //Appbar portion
  static Color appBarBackgroundColor = darkShade0;
  static const Color appBarIconsColor = Colors.white;
  static const Color appBarTitleColor = Colors.white;

  //divider color

  static const Color dividerColor = Color(0xff434343);

  // ICONS

  static const Color iconColor = Colors.white;

  // BUTTON

  static const Color buttonDisabledColor = Colors.grey;
  static const Color buttonDisabledTextColor = Colors.black;

  // TEXT
  static const Color textColor = Color(0xffC4C4C4);
  static const Color bodyTextColor = Colors.white70;
  static const Color headlinesTextColor = Colors.white38;
  static const Color captionTextColor = Colors.grey;
  static const Color hintTextColor = Color(0xff686868);

  static Color fillColor = grayColorShade4;

  // PROGRESS BAR INDICATOR
  static const Color progressIndicatorColor = Color(0xFF40A76A);

  static const Color errorColor = Color(0xFFF1291A);

  //Dialog Box Color
  static Color dialogBackgroundColor = grayColorShade4;
}
