import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/views/list_items/views/item_add_manualy.dart';
import 'package:sales_person_app/views/list_items/views/list_items_screen.dart';
import 'package:sales_person_app/widgets/custom_elevated_button.dart';

class ScannerModuleController extends GetxController {
  RxBool ischeckBox = false.obs;
  RxBool isSelectAllChecked = false.obs;
  RxInt selectedIndex = 0.obs;
  RxBool isItemNameFieldExpanded = false.obs;
  RxBool isLoading = false.obs;
  RxBool itemsFieldRefresh = false.obs;
  List<Widget> pages = [const ItemAddManualy(), const ListItemsScreen()];
  late TextEditingController itemNameController;
  var items = [
    {
      'id': 1,
      'lot': 'LOT1234',
      'qty': 36,
    },
    {
      'id': 2,
      'lot': 'LOT5678',
      'qty': 45,
    },
  ].obs;
  @override
  void onInit() {
    itemNameController = TextEditingController();
    super.onInit();
  }

  // Toggle select all checkbox state
  void toggleSelectAll() {
    isSelectAllChecked.value = !isSelectAllChecked.value;
  }

  void deleteItem(int index) {
    items.removeAt(index);
  }

  Future<bool?> confirmDismiss() {
    return Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: const Color(0xffFFFFFF),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(Sizes.PADDING_5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.warning_amber,
                    color: Colors.red,
                    size: Sizes.WIDTH_35,
                  ),
                  const SizedBox(height: Sizes.HEIGHT_8),
                  Text(
                    'Are you sure?',
                    style: Get.textTheme.titleLarge?.copyWith(
                      fontSize: Sizes.TEXT_SIZE_18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff393939),
                    ),
                  ),
                  const SizedBox(height: Sizes.HEIGHT_12),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.PADDING_18),
                    child: Text(
                      AppStrings.CONFIRMATION_ITEM_DELETE_MESSAGE,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.titleMedium?.copyWith(
                        fontSize: Sizes.TEXT_SIZE_14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff393939),
                      ),
                    ),
                  ),
                  const SizedBox(height: Sizes.HEIGHT_14),
                  Container(
                    padding: const EdgeInsets.only(
                      top: Sizes.PADDING_8,
                      bottom: Sizes.PADDING_12,
                      left: Sizes.PADDING_10,
                      right: Sizes.PADDING_10,
                    ),
                    color: const Color(0xffF1F5F8),
                    height: Sizes.HEIGHT_60,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomElevatedButton(
                          onPressed: () {
                            Get.back(result: false);
                          },
                          title: 'No',
                          minWidht: Sizes.WIDTH_130,
                          minHeight: Sizes.HEIGHT_30,
                          backgroundColor: LightTheme.buttonBackgroundColor2,
                          borderRadiusCircular:
                              BorderRadius.circular(Sizes.RADIUS_6),
                        ),
                        const SizedBox(width: Sizes.WIDTH_20),
                        CustomElevatedButton(
                          onPressed: () {
                            Get.back(result: true);
                          },
                          title: 'Yes',
                          minWidht: Sizes.WIDTH_130,
                          minHeight: Sizes.HEIGHT_30,
                          backgroundColor: LightTheme.buttonBackgroundColor2,
                          borderRadiusCircular:
                              BorderRadius.circular(Sizes.RADIUS_6),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
