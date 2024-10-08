import 'package:flutter/material.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/themes/themes.dart';

class CustomRowCells extends StatelessWidget {
  final String? itemName;

  final String? price;

  final void Function()? commentDialogBoxOnPressed;
  final TextEditingController qntyController;
  final TextEditingController notesController;

  const CustomRowCells({
    super.key,
    this.itemName,
    this.price,
    this.commentDialogBoxOnPressed,
    required this.qntyController,
    required this.notesController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildCell(itemName ?? '', Sizes.WIDTH_118),
        SizedBox(
          width: Sizes.WIDTH_60,
          height: Sizes.HEIGHT_50,
          child: TextField(
            controller: qntyController,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ), // Or use t ,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: LightTheme.grayColorShade5, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: LightTheme.grayColorShade5, width: 2),
              ),
            ),
          ),
        ),
        _buildCell(price ?? '', Sizes.WIDTH_80),
        SizedBox(
          width: Sizes.WIDTH_118,
          height: Sizes.HEIGHT_50,
          child: TextField(
            controller: notesController,
            onChanged: (text) {
              if (text.length > 6) {}
            },
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ), // Or use t ,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: commentDialogBoxOnPressed,
                  icon: const Icon(Icons.edit)),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: LightTheme.grayColorShade5, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: LightTheme.grayColorShade5, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCell(String value, double width) {
    return Container(
      height: Sizes.HEIGHT_50,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: LightTheme.grayColorShade5,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ), // Or use the context's theme style if preferred
        ),
      ),
    );
  }
}
