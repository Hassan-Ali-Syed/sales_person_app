part of 'themes.dart';

class LightTheme {
  //static const List<Color> accentColors = [Color(0xff44B2BC)];
  static const List<Color> accentColors = [
    Color(0xffff3b30),
    Color(0xffff9500),
    Color(0xffffcc00),
    Color(0xff34c759),
    Color(0xffe2f8f9),
    Color(0xff66d5dc),
    Color(0xff44B2BC),
    Color(0xff3f9ca3),
    Color(0xff316463),
    Color(0xffaf52de),
    Color(0xffff2d55),
    Color(0xffa2845e),
  ];

  static const List<Color> grayColors = [
    Color(0xff8e8e93),
    Color(0xffaeaeb2),
    Color(0xffc7c7cc),
    Color(0xffd1d1d6),
    Color(0xffe5e5ea),
    Color(0xfff2f2f7),
  ];

  static Color get grayColorShade0 => grayColors[0];
  static Color get grayColorShade1 => grayColors[1];
  static Color get grayColorShade2 => grayColors[2];
  static Color get grayColorShade3 => grayColors[3];
  static Color get grayColorShade4 => grayColors[4];
  static Color get grayColorShade5 => grayColors[5];

  static const List<Color> backgroundColors = [
    Color(0xffffffff),
    Color(0xfff6f6f6),
    Color(0xffeeeeee),
    Color(0xff676767),
  ];

  static Color get darkShade0 => backgroundColors[0];
  static Color get darkShade1 => backgroundColors[1];
  static Color get darkShade2 => backgroundColors[2];
  static Color get darkShade3 => backgroundColors[3];

  // SCAFFOLD
  static const Color scaffoldBackgroundColor = Color(0xfffdfdfd);
  static Color appBarBackgroundColor = const Color(0xffE9E8E7);
  static Color backgroundColor = Colors.white;
  static Color onBackground = grayColorShade1;
  static Color backgroundColorLight = grayColorShade4;
  static Color canvasColor = grayColorShade4;
  static const Color cardColor = Color(0xffe5eced);
  static const Color textBoxColor = Color(0xFFFFFFFF);
  static const Color dividerColor = Color(0xff9F9F9F);
  static const Color headingColor = Color(0xffE9E8E7);

  // ICONS
  static const Color iconColor1 = AppColors.white;
  static const Color iconColor = AppColors.primaryColor;
  static const Color navigationIconColor = Color(0xff535763);

  // BUTTON

  static const Color acceptButtonColor = AppColors.greenShade1;
  static const Color backButtonColor = AppColors.redShade5;
  static const Color buttonDisabledColor = Colors.grey;
  static const Color buttonDisabledTextColor = Colors.black;
  static const Color buttonBackgroundColor = Color(0xff7C7A7A);
  static const Color buttonBackgroundColor2 = Color(0xff939598);
  static const Color dateSelectedColor = Color(0xff58595B);

  // TEXT
  static const Color appBarTextColor = Color(0xff58595B);
  static const Color textColor = Color(0xff2B2829);
  static const Color buttonTextColor = Color(0xffFAFAFA);
  static const Color bodyTextColor = Colors.black;
  static const Color headlinesTextColor = Colors.black;
  static const Color captionTextColor = Colors.grey;
  static const Color hintTextColor = Color(0xff686868);
  static const Color fillColor = Color(0xfff7f7f7);

  //
  static const Color borderColor = Color(0xffF3F3F3);
  // Shimmers
  static const Color shimmerBaseColor = Color.fromRGBO(0, 0, 0, 0.1);
  static const Color shimmerHighlightColor = Color(0x44CCCCCC);

  // CHIP
  static const Color chipTextColor = Colors.white;

  // PROGRESS BAR INDICATOR
  static const Color progressIndicatorColor = Color(0xFF40A76A);

  static const Color errorColor = Color(0xFFD42D21);

  //DIALOG BOX COLOR
  static const Color dialogBackgroundColor = Colors.white;

  //BOTTOM SHEET COLOR
  static const Color bottomSheetBackgroundColor = Color(0xFFe6f5ea);
}
