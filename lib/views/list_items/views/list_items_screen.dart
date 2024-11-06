import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/views/list_items/controllers/list_items_controller.dart';

class ListItemsScreen extends GetView<ListItemsController> {
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
                onTap: () => Get.back(),
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
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.delete_outlined),
                        ),
                        const SizedBox(width: Sizes.WIDTH_8),
                        const Text('Select All'),
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
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: controller.items.length,
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Dismissible(
                      key: Key(item['id'].toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.red,
                        child: const Text(
                          'Delete',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xffE9E8E7),
                          ),
                        ),
                      ),
                      // confirmDismiss: (direction) =>
                      //     controller.confirmDismiss(index),
                      onDismissed: (direction) {
                        controller.deleteItem(index);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: const Color(0xff646667),
                        child: ListTile(
                          visualDensity: VisualDensity.compact,
                          dense: true,
                          horizontalTitleGap: 0,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          title: GestureDetector(
                            onLongPress: () {
                              controller.ischeckBox.value = true;
                            },
                            child: Text(
                              'LOT: ${item['lot']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xffE9E8E7),
                              ),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Total QTY: ${item['qty']}',
                                style: const TextStyle(color: Colors.white),
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
