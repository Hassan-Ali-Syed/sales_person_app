import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/widgets/custom_elevated_button.dart';

void showCustomDialog(bool isCreated, String msg, {Row? action}) {
  if (isCreated) {
    Get.defaultDialog(
      backgroundColor: Colors.white,
      radius: Sizes.RADIUS_10,
      title: "",
      content: SizedBox(
        height: Sizes.HEIGHT_80,
        width: Get.width * 0.5,
        child: Row(
          children: [
            const SizedBox(
              width: Sizes.WIDTH_30,
            ),
            const Icon(
              Icons.check_circle_sharp,
              color: Colors.green,
              size: Sizes.ICON_SIZE_80,
            ),
            const SizedBox(
              width: Sizes.WIDTH_20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Complete',
                  style: GoogleFonts.roboto(
                      fontSize: Sizes.TEXT_SIZE_20,
                      fontWeight: FontWeight.w600),
                ),
                Expanded(
                  //width: Get.width * 0.35,
                  child: Text(
                    msg,
                    style: GoogleFonts.roboto(
                        fontSize: Sizes.TEXT_SIZE_12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            action ??
                CustomElevatedButton(
                  minWidht: Sizes.WIDTH_120,
                  minHeight: Sizes.HEIGHT_40,
                  title: 'Close',
                  onPressed: () {
                    Get.back();
                  },
                ),
          ],
        )
      ],
    );
  } else {
    Get.defaultDialog(
      backgroundColor: Colors.white,
      radius: Sizes.RADIUS_10,
      title: "",
      content: SizedBox(
        height: Sizes.HEIGHT_80,
        width: Get.width * 0.5,
        child: Row(
          children: [
            const SizedBox(
              width: Sizes.WIDTH_30,
            ),
            const Icon(
              Icons.question_mark_rounded,
              color: Colors.grey,
              size: Sizes.ICON_SIZE_80,
            ),
            const SizedBox(
              width: Sizes.WIDTH_20,
            ),
            FittedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width * 0.35,
                    child: Text(
                      msg,
                      style: GoogleFonts.roboto(
                          fontSize: Sizes.TEXT_SIZE_12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            action ??
                CustomElevatedButton(
                  title: 'Close',
                  onPressed: () {
                    Get.back();
                  },
                  minWidht: Sizes.WIDTH_120,
                  minHeight: Sizes.HEIGHT_40,
                ),
          ],
        )
      ],
    );
  }
}
