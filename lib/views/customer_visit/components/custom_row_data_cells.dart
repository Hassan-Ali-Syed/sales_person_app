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
  final void Function(String)? onSubmitted;

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
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Safely handle itemName with default value ''
        Expanded(flex: 3, child: _buildCell(itemName ?? '', context)),

        // Handle qty display and editing
        Expanded(
          flex: 2,
          child: isQtyPressed && rowIndex == selectedIndex
              ? SizedBox(
                  height: Sizes.HEIGHT_50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: qntyController,
                    onChanged: qtyOnChanged,
                    style: context.bodySmall.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: Sizes.TEXT_SIZE_14,
                      color: const Color(0xff58595B),
                    ),
                    onSubmitted: onSubmitted,
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
                        style: context.bodySmall.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: Sizes.TEXT_SIZE_14,
                          color: const Color(0xff58595B),
                        ),
                      ),
                    ),
                  ),
                ),
        ),

        // Safely handle price with a default value ''
        Expanded(flex: 2, child: _buildCell(price ?? '', context)),

        // Handle notes display and editing
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.PADDING_4),
            height: Sizes.HEIGHT_50,
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
                  Flexible(
                    child: Text(
                      overflow:
                          TextOverflow.ellipsis, // Add ellipsis for overflow
                      maxLines: 1,

                      notes == 'null' ? '' : notes,
                      textAlign: TextAlign.center,
                      style: context.bodySmall.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: Sizes.TEXT_SIZE_14,
                        color: const Color(0xff58595B),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: commentDialogBoxOnPressed,
                    child: const Icon(
                      Icons.edit_note,
                      color: LightTheme.appBarTextColor,
                      size: Sizes.ICON_SIZE_30,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  // height: Sizes.HEIGHT_50,

  Widget _buildCell(String value, BuildContext context) {
    return Container(
      height: Sizes.HEIGHT_50,
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
          style: context.bodySmall.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: Sizes.TEXT_SIZE_14,
            color: const Color(0xff58595B),
          ),
        ),
      ),
    );
  }
}
