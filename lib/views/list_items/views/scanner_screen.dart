import 'package:bottom_navbar_with_indicator/bottom_navbar_with_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/views/list_items/components/barcode_scanner_simple.dart';
import 'package:sales_person_app/views/list_items/controllers/scanner_module_controller.dart';

class ScannerScreen extends GetView<ScannerModuleController> {
  const ScannerScreen({super.key});
  static const String routeName = '/scanner_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.selectedIndex.value == 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: SizedBox(height: 500, child: ContinuousScanner()))
            ],
          );
        } else {
          return controller.pages[controller.selectedIndex.value - 1];
        }
      }),
      bottomNavigationBar: CustomLineIndicatorBottomNavbar(
        selectedColor: const Color(0xff58595B),
        unSelectedColor: const Color(0xff7C7A7A),
        backgroundColor: LightTheme.appBarBackgroundColor,
        unselectedIconSize: Sizes.ICON_SIZE_28,
        selectedIconSize: Sizes.ICON_SIZE_28,
        selectedFontSize: Sizes.TEXT_SIZE_12,
        unselectedFontSize: Sizes.TEXT_SIZE_12,
        currentIndex: controller.selectedIndex.value - 1,
        onTap: (index) {
          controller.selectedIndex.value = index + 1;
        },
        enableLineIndicator: false,
        customBottomBarItems: [
          CustomBottomBarItems(
            label: AppStrings.ADD_MANUAL,
            icon: Icons.dashboard_customize_outlined,
            isAssetsImage: false,
          ),
          CustomBottomBarItems(
            label: AppStrings.LIST_ITEM,
            icon: Icons.fact_check_outlined,
            isAssetsImage: false,
          ),
        ],
      ),
    );
  }
}
