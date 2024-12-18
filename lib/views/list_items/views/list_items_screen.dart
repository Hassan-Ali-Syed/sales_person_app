import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/views/list_items/controllers/scanner_module_controller.dart';

class ListItemsScreen extends GetView<ScannerModuleController> {
  const ListItemsScreen({super.key});
  static const String routeName = '/list_items_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: Sizes.ELEVATION_0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Padding(
          padding: const EdgeInsets.only(left: Sizes.PADDING_2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => controller.selectedIndex.value = 0,
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xff7C7A7A),
                ),
              ),
              const SizedBox(width: Sizes.WIDTH_8),
              const Text(AppStrings.LIST_ITEMS),
            ],
          ),
        ),
        actions: [
          Obx(
            () => controller.ischeckBox.value
                ? Padding(
                    padding: const EdgeInsets.only(right: Sizes.PADDING_20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.delete_outlined,
                            size: Sizes.ICON_SIZE_28,
                          ),
                        ),
                        const SizedBox(width: Sizes.WIDTH_8),
                        Text(
                          'Select All',
                          style: context.bodySmall.copyWith(
                              color: Color(0xff7C7A7A),
                              fontSize: Sizes.TEXT_SIZE_18),
                        ),
                        Checkbox(
                          value: controller.isSelectAllChecked.value,
                          onChanged: (value) {
                            controller.toggleSelectAll();
                          },
                          activeColor: const Color(0xff7C7A7A),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
      body: Obx(() => controller.items.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.PADDING_14),
              child: ListView.builder(
                itemCount: controller.items.length,
                padding: const EdgeInsets.symmetric(vertical: Sizes.PADDING_10),
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: Sizes.PADDING_2),
                    child: Dismissible(
                      key: Key(item['id'].toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.symmetric(
                            vertical: Sizes.PADDING_4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        color: Colors.red,
                        child: Text(
                          'Delete',
                          style: context.bodySmall.copyWith(
                              color: Colors.white,
                              fontSize: Sizes.TEXT_SIZE_18),
                        ),
                      ),
                      // confirmDismiss: (direction) =>
                      //     controller.confirmDismiss(index),
                      onDismissed: (direction) {
                        controller.deleteItem(index);
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
                        ),
                        color: const Color(0xff646667),
                        child: ListTile(
                          visualDensity: VisualDensity.compact,
                          dense: true,
                          horizontalTitleGap: 0,
                          contentPadding: const EdgeInsets.only(
                              left: Sizes.PADDING_18, right: Sizes.PADDING_28),
                          title: GestureDetector(
                            onLongPress: () {
                              controller.ischeckBox.value = true;
                            },
                            child: Text(
                              'ALEXANDRIA-INDIGO',
                              style: context.bodySmall.copyWith(
                                  color: Colors.white,
                                  fontSize: Sizes.TEXT_SIZE_14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'QTY: ${item['qty']}',
                                style: context.bodySmall.copyWith(
                                    color: const Color(0xffE9E8E7),
                                    fontSize: Sizes.TEXT_SIZE_14,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          : const SizedBox()),
    );
  }
}
