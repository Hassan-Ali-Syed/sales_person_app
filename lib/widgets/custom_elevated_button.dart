import 'package:flutter/material.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/themes/themes.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final double minHeight;
  final double minWidht;
  final Color? backgroundColor;
  final Color? fontColor;
  final void Function()? onPressed;
  final BorderRadius? borderRadiusCircular;
  final Color? borderColor;
  final double? borderWidth;

  const CustomElevatedButton({
    super.key,
    required this.title,
    required this.minWidht,
    required this.minHeight,
    this.backgroundColor,
    this.fontColor,
    this.onPressed,
    this.borderRadiusCircular,
    this.borderColor,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(minWidht, minHeight),
        backgroundColor: backgroundColor ?? LightTheme.buttonBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              borderRadiusCircular ?? BorderRadius.circular(Sizes.RADIUS_6),
          side: borderColor != null && borderWidth != null
              ? BorderSide(color: borderColor!, width: borderWidth!)
              : BorderSide.none,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: context.titleMedium
            .copyWith(color: fontColor ?? LightTheme.buttonTextColor),
      ),
    );
  }
}
