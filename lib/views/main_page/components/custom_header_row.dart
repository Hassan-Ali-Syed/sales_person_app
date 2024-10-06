import 'package:flutter/material.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/extensions/context_extension.dart';

class CustomHeaderRow extends StatelessWidget {
  const CustomHeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CustomHeaderCell(
          width: Sizes.WIDTH_120,
          text: 'Item Name',
        ),
        CustomHeaderCell(
          width: Sizes.WIDTH_60,
          text: 'Qty',
        ),
        CustomHeaderCell(
          width: Sizes.WIDTH_80,
          text: 'Price',
        ),
        CustomHeaderCell(
          width: Sizes.WIDTH_130,
          text: 'Notes',
        ),
      ],
    );
  }
}

class CustomHeaderCell extends StatelessWidget {
  final double width;
  final String text;

  const CustomHeaderCell({
    super.key,
    required this.width,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.HEIGHT_30,
      width: width,
      decoration: BoxDecoration(
        color: LightTheme.headingColor,
        border: Border.all(
          color: LightTheme.borderColor,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: context.bodyLarge,
        ),
      ),
    );
  }
}
