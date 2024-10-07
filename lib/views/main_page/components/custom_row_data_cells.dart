import 'package:flutter/material.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/themes/themes.dart';

class CustomRowCells extends StatelessWidget {
  final String? itemName;
  final String? qty;
  final String? price;
  final String? notes;
  final void Function()? commentDialogBoxOnPressed;

  const CustomRowCells({
    super.key,
    this.itemName,
    this.qty,
    this.price,
    this.notes,
    this.commentDialogBoxOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildCell(itemName ?? '', Sizes.WIDTH_120),
        SizedBox(
          width: Sizes.WIDTH_60,
          height: Sizes.HEIGHT_40,
          child: TextField(
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ), // Or use t ,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: LightTheme.grayColorShade5, width: 2),
              ),
            ),
          ),
        ),
        _buildCell(price ?? '', Sizes.WIDTH_80),
        SizedBox(
          width: Sizes.WIDTH_130,
          height: Sizes.HEIGHT_40,
          child: TextField(
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
              border: OutlineInputBorder(
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
      height: Sizes.HEIGHT_40,
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
