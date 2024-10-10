// import 'package:flutter/material.dart';
// import 'package:sales_person_app/constants/constants.dart';
// import 'package:sales_person_app/extensions/context_extension.dart';
// import 'package:sales_person_app/themes/themes.dart';

// class CustomRowCells extends StatelessWidget {
//   final String? itemName;
//   final String? price;
//   final void Function()? commentDialogBoxOnPressed;
//   final String? qty;
//   final void Function()? qtyOnTap;
//   final void Function(String)? qtyOnChanged;
//   final bool isQtyPressed;
//   final TextEditingController qntyController;
//   final String? notes;
//   final void Function()? notesOnTap;
//   final void Function(String)? notesOnChanged;
//   final bool isNotesPressed;

//   final TextEditingController notesController;

//   const CustomRowCells({
//     super.key,
//     this.itemName,
//     this.price,
//     this.qty,
//     this.commentDialogBoxOnPressed,
//     this.qtyOnTap,
//     this.qtyOnChanged,
//     this.isQtyPressed = false,
//     required this.qntyController,
//     this.notes,
//     this.notesOnTap,
//     this.notesOnChanged,
//     this.isNotesPressed = false,
//     required this.notesController,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         _buildCell(itemName ?? '', Sizes.WIDTH_118),
//         !isQtyPressed
//             ? GestureDetector(
//                 onTap: qtyOnTap,
//                 child: Container(
//                     width: Sizes.WIDTH_60,
//                     height: Sizes.HEIGHT_50,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: LightTheme.grayColorShade5,
//                         width: 2,
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         qty!,
//                         style: context.bodyMedium,
//                       ),
//                     )),
//               )
//             : SizedBox(
//                 width: Sizes.WIDTH_60,
//                 height: Sizes.HEIGHT_50,
//                 child: TextField(
//                   controller: qntyController,
//                   onChanged: qtyOnChanged,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                   ), // Or use t ,
//                   textAlign: TextAlign.center,
//                   textAlignVertical: TextAlignVertical.top,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           color: LightTheme.grayColorShade5, width: 2),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           color: LightTheme.grayColorShade5, width: 2),
//                     ),
//                   ),
//                 ),
//               ),
//         _buildCell(price ?? '', Sizes.WIDTH_80),
//         !isNotesPressed
//             ? GestureDetector(
//                 onTap: notesOnTap,
//                 child: Container(
//                     width: Sizes.WIDTH_118,
//                     height: Sizes.HEIGHT_50,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: LightTheme.grayColorShade5,
//                         width: 2,
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         notes!,
//                         style: context.bodyMedium,
//                       ),
//                     )),
//               )
//             : SizedBox(
//                 width: Sizes.WIDTH_118,
//                 height: Sizes.HEIGHT_50,
//                 child: TextField(
//                   controller: notesController,
//                   onChanged: (text) {
//                     if (text.length > 6) {}
//                   },
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                   ), // Or use t ,
//                   textAlign: TextAlign.center,
//                   textAlignVertical: TextAlignVertical.top,
//                   decoration: InputDecoration(
//                     suffixIcon: IconButton(
//                         onPressed: commentDialogBoxOnPressed,
//                         icon: const Icon(Icons.edit)),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           color: LightTheme.grayColorShade5, width: 2),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           color: LightTheme.grayColorShade5, width: 2),
//                     ),
//                   ),
//                 ),
//               ),
//       ],
//     );
//   }

//   Widget _buildCell(String value, double width) {
//     return Container(
//       height: Sizes.HEIGHT_50,
//       width: width,
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: LightTheme.grayColorShade5,
//           width: 2,
//         ),
//       ),
//       child: Center(
//         child: Text(
//           value,
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black,
//           ), // Or use the context's theme style if preferred
//         ),
//       ),
//     );
//   }
// }

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
  final bool isQtyPressed;
  final TextEditingController qntyController;
  final String? notes;
  final void Function()? notesOnTap;
  final void Function(String)? notesOnChanged;
  final bool isNotesPressed;

  final TextEditingController notesController;

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
    this.notes,
    this.notesOnTap,
    this.notesOnChanged,
    this.isNotesPressed = false,
    required this.notesController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Safely handle itemName with default value ''
        _buildCell(itemName ?? '', Sizes.WIDTH_118),

        // Handle qty display and editing
        !isQtyPressed
            ? GestureDetector(
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
              )
            : SizedBox(
                width: Sizes.WIDTH_60,
                height: Sizes.HEIGHT_50,
                child: TextField(
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
              ),

        // Safely handle price with a default value ''
        _buildCell(price ?? '', Sizes.WIDTH_80),

        // Handle notes display and editing
        !isNotesPressed
            ? GestureDetector(
                onTap: notesOnTap,
                child: Container(
                  width: Sizes.WIDTH_118,
                  height: Sizes.HEIGHT_50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: LightTheme.grayColorShade5,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      // Safeguard notes with a default value
                      notes ?? '',
                      style: context.bodyMedium,
                    ),
                  ),
                ),
              )
            : SizedBox(
                width: Sizes.WIDTH_118,
                height: Sizes.HEIGHT_50,
                child: TextField(
                  controller: notesController,
                  onChanged: (text) {
                    if (text.length > 6) {
                      // Handle text change logic here if needed
                    }
                  },
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: commentDialogBoxOnPressed,
                      icon: const Icon(Icons.edit),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: LightTheme.grayColorShade5, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: LightTheme.grayColorShade5, width: 2),
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
          ),
        ),
      ),
    );
  }
}
