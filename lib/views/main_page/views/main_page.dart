import 'package:bottom_navbar_with_indicator/bottom_navbar_with_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/views/main_page/controllers/main_page_controller.dart';
import 'package:sales_person_app/widgets/custom_appbar.dart';
import 'package:sales_person_app/widgets/custom_drawer.dart';

class MainPage extends GetView<MainPageController> {
  const MainPage({super.key});
  static const String routeName = '/main_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.mainPageScaffoldKey,
      appBar: customAppBar(
          onTap: () {
            controller.mainPageScaffoldKey.currentState!.openEndDrawer();
          },
          context: context,
          automaticallyImplyLeading: false,
          customLeading: true,
          title: Obx(
            () => Text(controller.appBarTitle[controller.selectedIndex.value]),
          ),
          isDrawerIcon: true),
      bottomNavigationBar: Obx(
        () => CustomLineIndicatorBottomNavbar(
          selectedColor: const Color(0xff0A0A0B),
          unSelectedColor: const Color(0xff98A2B3),
          backgroundColor: LightTheme.appBarBackgroundColor,
          unselectedIconSize: Sizes.ICON_SIZE_24,
          selectedIconSize: Sizes.ICON_SIZE_28,
          selectedFontSize: Sizes.TEXT_SIZE_16,
          unselectedFontSize: Sizes.TEXT_SIZE_14,
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            controller.updateSelectedIndex(index);
          },
          enableLineIndicator: false,
          customBottomBarItems: [
            CustomBottomBarItems(
              label: AppStrings.HOME,
              icon: Icons.home_filled,
              isAssetsImage: false,
            ),
            CustomBottomBarItems(
              label: AppStrings.CUSTOMER,
              icon: Icons.apartment,
              isAssetsImage: false,
            ),
            CustomBottomBarItems(
              label: AppStrings.CONTACT,
              icon: Icons.perm_contact_cal_outlined,
              isAssetsImage: false,
            ),
            CustomBottomBarItems(
              label: AppStrings.MORE,
              icon: Icons.sort,
              isAssetsImage: false,
            ),
          ],
        ),
      ),
      endDrawer: CustomDrawer(
        logOutOnTap: () => controller.userLogOut(),
      ),
      body: Obx(
        () => controller.pages[controller.selectedIndex.value],
      ),
    );
  }
}
