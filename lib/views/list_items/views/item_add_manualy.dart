import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/views/list_items/controllers/scanner_module_controller.dart';
import 'package:sales_person_app/widgets/custom_appbar.dart';
import 'package:sales_person_app/widgets/custom_elevated_button.dart';
import 'package:sales_person_app/widgets/custom_textfield.dart';

class ItemAddManualy extends GetView<ScannerModuleController> {
  const ItemAddManualy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        backOnTap: () {
          controller.selectedIndex.value = 0;
        },
        context: context,
        title: const Text('Add Manually'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.PADDING_22, vertical: Sizes.PADDING_10),
          child: Column(
            children: [
              Obx(
                () => !controller.isItemNameFieldExpanded.value
                    ? CustomTextField(
                        hintText: 'Item Name',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.isItemNameFieldExpanded.value = true;
                          },
                          child: const Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xff7C7A7A),
                          ),
                        ),
                      )
                    : Container(
                        height: Sizes.HEIGHT_250,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextField(
                                    style: context.bodySmall.copyWith(
                                        fontSize: Sizes.TEXT_SIZE_16,
                                        color: const Color(0xff58595B)),
                                    autofocus: true,
                                    onChanged: (value) {},
                                    controller: controller.itemNameController,
                                    onTapOutside: (event) {},
                                    decoration: InputDecoration(
                                      labelText: 'Item Name',
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xff7C7A7A),
                                        ),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xff7C7A7A),
                                        ),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: const Icon(
                                          Icons.search,
                                          color: Color(0xff58595B),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.isItemNameFieldExpanded.value =
                                        false;
                                  },
                                  child: const Icon(
                                    Icons.arrow_drop_up,
                                    size: Sizes.WIDTH_26,
                                    color: Color(0xff7C7A7A),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: Sizes.HEIGHT_10,
                            ),
                            Expanded(
                              child: Scrollbar(
                                trackVisibility: true,
                                radius: const Radius.circular(Sizes.RADIUS_6),
                                interactive: true,
                                thickness: 12,
                                thumbVisibility: true,
                                // controller: controller.customerScrollController,
                                child: ListView.builder(
                                  // controller: controller
                                  //     .customerScrollController,
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      visualDensity: VisualDensity.compact,
                                      dense: true,
                                      horizontalTitleGap: 0,
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        'Item Name',
                                        style: context.bodySmall.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: Sizes.TEXT_SIZE_16,
                                          color: const Color(0xff58595B),
                                        ),
                                      ),
                                      onTap: () {},
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: Sizes.PADDING_260),
                child: Center(
                  child: CustomElevatedButton(
                    onPressed: () {},
                    title: AppStrings.ADD,
                    minWidht: Sizes.WIDTH_170,
                    minHeight: Sizes.HEIGHT_36,
                    backgroundColor: LightTheme.buttonBackgroundColor2,
                    borderRadiusCircular: BorderRadius.circular(
                      Sizes.RADIUS_6,
                    ),
                    style: context.bodyMedium.copyWith(
                        color: LightTheme.buttonTextColor,
                        fontSize: Sizes.TEXT_SIZE_16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
