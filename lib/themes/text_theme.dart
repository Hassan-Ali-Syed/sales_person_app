// ignore_for_file: unused_element

part of 'themes.dart';

const _bold = FontWeight.w700;
const _semiBold = FontWeight.w600;
const _medium = FontWeight.w500;
const _regular = FontWeight.w400;
const _light = FontWeight.w300;

TextTheme buildTextTheme({
  required Color textColor,
  // required Color buttonColor,
}) =>
    TextTheme(
      titleLarge: GoogleFonts.manrope(
        textStyle: TextStyle(
          fontSize: Sizes.TEXT_SIZE_32,
          color: textColor,
          fontWeight: _bold,
        ),
      ),
      titleMedium: GoogleFonts.manrope(
          textStyle: TextStyle(
        fontSize: Sizes.TEXT_SIZE_18,
        color: textColor,
        fontWeight: _bold,
      )),
      titleSmall: GoogleFonts.manrope(
        textStyle: TextStyle(
          fontSize: Sizes.TEXT_SIZE_16,
          color: textColor,
          fontWeight: _light,
        ),
      ),
      bodyLarge: GoogleFonts.manrope(
        textStyle: TextStyle(
          fontSize: Sizes.TEXT_SIZE_18,
          fontWeight: _semiBold,
          color: textColor,
        ),
      ),
      bodyMedium: GoogleFonts.manrope(
        textStyle: TextStyle(
          fontWeight: _medium,
          fontSize: Sizes.TEXT_SIZE_16,
          color: textColor,
        ),
      ),
      bodySmall: GoogleFonts.manrope(
        fontWeight: _medium,
        textStyle: TextStyle(
          fontSize: Sizes.TEXT_SIZE_14,
          color: textColor,
        ),
      ),
    );
