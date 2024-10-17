import 'package:flutter/material.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/themes/themes.dart';

class CustomRowCells extends StatelessWidget {
  final String? itemName;
  final String? price;
  final void Function()? commentDialogBoxOnPressed;
  final String? qty;
  final void Function()? qtyOnTap;
  final void Function(String)? qtyOnChanged;
  final TextEditingController qntyController;

  final void Function(String)? notesOnChanged;
  final bool isQtyPressed;
  final int rowIndex;

  final int selectedIndex;

  final String notes;

  const CustomRowCells({
    super.key,
    this.itemName,
    this.price,
    this.qty,
    this.commentDialogBoxOnPressed,
    this.qtyOnTap,
    this.qtyOnChanged,
    this.isQtyPressed = false,
    required this.qntyController,
    this.notesOnChanged,
    required this.notes,
    required this.rowIndex,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Safely handle itemName with default value ''
        _buildCell(itemName ?? '', Sizes.WIDTH_118),

        // Handle qty display and editing
        isQtyPressed && rowIndex == selectedIndex
            ? SizedBox(
                width: Sizes.WIDTH_60,
                height: Sizes.HEIGHT_50,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: qntyController,
                  onChanged: qtyOnChanged,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: LightTheme.grayColorShade5, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: LightTheme.grayColorShade5, width: 2),
                    ),
                  ),
                ),
              )
            : GestureDetector(
                onTap: qtyOnTap,
                child: Container(
                  width: Sizes.WIDTH_60,
                  height: Sizes.HEIGHT_50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: LightTheme.grayColorShade5,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      // Safeguard qty with a default value
                      qty ?? '0',
                      style: context.bodyMedium,
                    ),
                  ),
                ),
              ),

        // Safely handle price with a default value ''
        _buildCell(price ?? '', Sizes.WIDTH_80),

        // Handle notes display and editing
        Container(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.PADDING_4),
          height: Sizes.HEIGHT_50,
          width: Sizes.WIDTH_118,
          decoration: BoxDecoration(
            border: Border.all(
              color: LightTheme.grayColorShade5,
              width: 2,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  maxLines: 2,
                  notes,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: commentDialogBoxOnPressed,
                  child: const Icon(
                    Icons.edit,
                    color: LightTheme.appBarTextColor,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  // height: Sizes.HEIGHT_50,

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
          ),
        ),
      ),
    );
  }
}
