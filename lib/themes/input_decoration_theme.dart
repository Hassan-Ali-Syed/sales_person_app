part of 'themes.dart';

InputDecorationTheme inputDecorationTheme({
  required Color primaryColor,
  required Color errorColor,
  required Color fillColor,
  required Color hintColor,
}) =>
    InputDecorationTheme(
      fillColor: fillColor,
      filled: true,
      hintStyle: TextStyle(color: hintColor),
      border: outlineInputBorder,
      enabledBorder: outlineInputBorder,
      focusedBorder:
          focusedOutlineInputBorder(borderColor: const Color(0xff316463)),
      errorBorder: errorOutlineInputBorder(errorColor: errorColor),
      focusedErrorBorder: focusErrorOutlineInputBorder(errorColor: errorColor),
    );

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(Sizes.RADIUS_6)),
  borderSide: BorderSide(
    color: AppColors.primaryColor,
  ),
);

OutlineInputBorder focusedOutlineInputBorder({
  required Color borderColor,
}) =>
    OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(Sizes.RADIUS_6)),
      borderSide: BorderSide(color: borderColor, width: 0.5),
    );

OutlineInputBorder errorOutlineInputBorder({
  required Color errorColor,
}) =>
    OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(Sizes.RADIUS_6)),
      borderSide: BorderSide(color: errorColor, width: Sizes.WIDTH_2),
    );

OutlineInputBorder focusErrorOutlineInputBorder({
  required Color errorColor,
}) =>
    OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(Sizes.RADIUS_6)),
      borderSide: BorderSide(color: errorColor, width: Sizes.WIDTH_2),
    );

OutlineInputBorder secondaryOutlineInputBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(Sizes.RADIUS_6)),
    borderSide: BorderSide(
      color: context.bodyText1.color!.withOpacity(0.15),
    ),
  );
}
