import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/views/main_page/components/contact_page_textfield.dart';

import 'package:sales_person_app/views/main_page/controllers/main_page_controller.dart';
import 'package:sales_person_app/widgets/custom_elevated_button.dart';

class ContactPageScreen extends GetView<MainPageController> {
  const ContactPageScreen({super.key});
  static const String routeName = '/contact_page_screen';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Sizes.PADDING_22, vertical: Sizes.PADDING_28),
        child: Column(
          children: [
            ContactPageTextField(
              hintText: 'Attendee Full Name',
              controller: TextEditingController(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.PADDING_10),
              child: Obx(
                () => !controller.isCustomerExpanded.value
                    ? Padding(
                        padding: const EdgeInsets.only(
                          top: Sizes.PADDING_8,
                        ),
                        child: TextField(
                          controller: controller.customerTextFieldController,
                          textAlign: TextAlign.left,
                          onSubmitted: (value) {
                            controller.isAddressFieldVisible.value = true;
                          },
                          // onChanged: (value) =>,
                          decoration: InputDecoration(
                            labelText: 'Customer ',
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.isCustomerExpanded.value = true;
                              },
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                size: Sizes.WIDTH_30,
                                color: Colors.black,
                              ),
                            ),
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
                                controller.isCustomerSearch.value
                                    ? Expanded(
                                        child: TextField(
                                          controller: controller
                                              .searchCustomerController,
                                          autofocus: true,
                                          decoration: InputDecoration(
                                            labelText: 'Search customer',
                                            border:
                                                const UnderlineInputBorder(),
                                            suffixIcon: IconButton(
                                                icon: const Icon(Icons.close),
                                                onPressed: () {
                                                  controller.isCustomerSearch
                                                      .value = false;
                                                  controller
                                                      .searchCustomerController
                                                      .clear();
                                                }),
                                          ),
                                        ),
                                      )
                                    : Text(
                                        'Search customer',
                                        style: context.bodyLarge,
                                      ),
                                Row(
                                  children: [
                                    controller.isCustomerSearch.value
                                        ? const SizedBox.shrink()
                                        : GestureDetector(
                                            onTap: () {
                                              controller.isCustomerSearch
                                                  .value = true;
                                            },
                                            child: const Icon(Icons.search),
                                          ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.isCustomerExpanded.value =
                                            false;
                                      },
                                      child: const Icon(
                                        Icons.arrow_drop_up,
                                        size: Sizes.WIDTH_40,
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                              child: Scrollbar(
                                interactive: true,
                                thickness: 12,
                                thumbVisibility: true,
                                controller: controller.customerScrollController,
                                child: controller.tliCustomers?.value != null &&
                                        controller
                                            .tliCustomers!.value.isNotEmpty
                                    ? ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        controller:
                                            controller.customerScrollController,
                                        itemCount: controller
                                            .tliCustomers?.value.length,
                                        itemBuilder: (context, index) {
                                          final filteredData = controller
                                              .tliCustomers?.value[index].name;
                                          return ListTile(
                                            title: Text(filteredData!),
                                            onTap: () {
                                              controller.setCustomerData(index);
                                              controller
                                                  .customerTextFieldController
                                                  .text = filteredData;
                                              controller.isCustomerExpanded
                                                  .value = false;
                                              controller
                                                  .searchCustomerController
                                                  .clear();
                                            },
                                          );
                                        },
                                      )
                                    : const Center(
                                        child: Text('No customers available'),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            ContactPageTextField(
              hintText: 'Email',
              controller: TextEditingController(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.PADDING_10),
              child: ContactPageTextField(
                hintText: 'Phone Number',
                controller: TextEditingController(),
              ),
            ),
            ContactPageTextField(
              hintText: 'Address',
              controller: TextEditingController(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: Sizes.PADDING_260),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomElevatedButton(
                  onPressed: () {},
                  title: 'Cancel',
                  minWidht: Sizes.WIDTH_100,
                  minHeight: Sizes.HEIGHT_30,
                  backgroundColor: LightTheme.buttonBackgroundColor2,
                  borderRadiusCircular: BorderRadius.circular(Sizes.RADIUS_6),
                ),
                const SizedBox(
                  width: Sizes.WIDTH_20,
                ),
                CustomElevatedButton(
                  onPressed: () {},
                  title: 'Save',
                  minWidht: Sizes.WIDTH_100,
                  minHeight: Sizes.HEIGHT_30,
                  backgroundColor: LightTheme.buttonBackgroundColor2,
                  borderRadiusCircular: BorderRadius.circular(Sizes.RADIUS_6),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
