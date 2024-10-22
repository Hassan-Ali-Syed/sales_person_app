import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';

AppBar customAppBar({
  required BuildContext context,
  bool automaticallyImplyLeading = false,
  Widget? title,
  String? titleName,
  bool isMobile = false,
  bool customLeading = false,
  Widget? widget,
  void Function()? onTap,
  void Function()? backOnTap,
  bool isDrawerIcon = false,
  bool backButton = true,
  Color? appBarColor,
  // bool isBackButton = false,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: Sizes.ELEVATION_0,
    backgroundColor:
        appBarColor ?? Theme.of(context).appBarTheme.backgroundColor,
    title: Padding(
      padding: const EdgeInsets.only(left: Sizes.PADDING_2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          backButton
              ? GestureDetector(
                  onTap: backOnTap ?? () => Get.back(),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xff7C7A7A),
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            width: Sizes.WIDTH_8,
          ),
          title ?? const SizedBox()
        ],
      ),
    ),

    // customLeading
    //     ? widget
    //     : (automaticallyImplyLeading
    //         ? GestureDetector(
    //             onTap: backOnTap ?? () => Get.back(),
    //             child: Icon(Icons.arrow_back_ios,
    //                 color: Theme.of(context).iconTheme.color),
    //           )
    //         : const SizedBox.shrink()),
    // title: title,
    actions: [
      if (isDrawerIcon)
        Padding(
          padding: const EdgeInsets.only(right: Sizes.PADDING_20),
          child: InkWell(
            onTap: onTap,
            child: const Icon(
              Icons.menu,
              color: Color(0xff7C7A7A),
            ),
          ),
        ),
    ],
  );
}
