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
        Expanded(
          flex: 3,
          child: CustomHeaderCell(
            text: 'Item Name',
          ),
        ),
        Expanded(
          flex: 2,
          child: CustomHeaderCell(
            text: 'Qty',
          ),
        ),
        Expanded(
          flex: 2,
          child: CustomHeaderCell(
            text: 'Price',
          ),
        ),
        Expanded(
          flex: 4,
          child: CustomHeaderCell(
            text: 'Notes',
          ),
        ),
      ],
    );
  }
}

class CustomHeaderCell extends StatelessWidget {
  final String text;

  const CustomHeaderCell({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.HEIGHT_30,
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
          style: context.bodySmall.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: Sizes.TEXT_SIZE_14,
            color: const Color(0xff58595B),
          ),
        ),
      ),
    );
  }
}
