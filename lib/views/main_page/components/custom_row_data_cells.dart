import 'package:flutter/material.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/themes/themes.dart';

class CustomRowCells extends StatelessWidget {
  final String? itemName;
  final String? qty;
  final String? price;
  final String? notes;

  const CustomRowCells({
    super.key,
    this.itemName,
    this.qty,
    this.price,
    this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildCell(itemName ?? '', Sizes.WIDTH_120),
        _buildCell(qty ?? '', Sizes.WIDTH_60),
        _buildCell(price ?? '', Sizes.WIDTH_80),
        _buildCell(notes ?? '', Sizes.WIDTH_130),
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
