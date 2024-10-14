import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';

AppBar customAppBar({
  required BuildContext context,
  required bool automaticallyImplyLeading,
  Widget? title,
  bool isMobile = false,
  bool customLeading = false,
  Widget? widget,
  void Function()? onTap,
  void Function()? backOnTap,
  bool isDrawerIcon = false,
  // bool isBackButton = false,
}) {
  return AppBar(
    automaticallyImplyLeading: automaticallyImplyLeading,
    elevation: Sizes.ELEVATION_0,
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    leading: customLeading
        ? widget
        : (automaticallyImplyLeading
            ? IconButton(
                onPressed: backOnTap ?? () => Get.back(),
                icon: const Icon(Icons.arrow_back_ios),
                color: Theme.of(context).iconTheme.color,
              )
            : const SizedBox.shrink()),
    title: title,
    actions: [
      if (isDrawerIcon)
        Padding(
          padding: const EdgeInsets.only(right: Sizes.PADDING_8),
          child: InkWell(
            onTap: onTap,
            child: const Icon(Icons.menu),
          ),
        ),
    ],
  );
}
