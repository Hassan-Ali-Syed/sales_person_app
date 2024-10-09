import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/preferences/preferences.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/views/main_page/components/custom_row_data_cells.dart';
import 'package:sales_person_app/views/main_page/controllers/main_page_controller.dart';
import 'package:sales_person_app/widgets/custom_elevated_button.dart';
import '../components/custom_header_row.dart';

class CustomerPageScreen extends GetView<MainPageController> {
  static const String routeName = '/custome_page_screen';
  const CustomerPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.only(
              top: Sizes.PADDING_10,
              left: Sizes.PADDING_8,
              right: Sizes.PADDING_8,
              bottom: Sizes.PADDING_10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First TextField Customer's Name- Always Visible
              Obx(
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
                          decoration: InputDecoration(
                            labelText: 'Customer name',
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
                                                icon: const Icon(Icons.search),
                                                onPressed: () {
                                                  // controller.isCustomerSearch
                                                  //     .value = false;
                                                  // controller
                                                  //     .searchCustomerController
                                                  //     .clear();
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
                                        child: Text(AppStrings.NO_CUST_AVAIL),
                                      ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        Text(
                                          AppStrings.ADD_CUSTOMER,
                                          style: context.bodyLarge,
                                        ),
                                        const Icon(Icons.add),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ),

              // Second TextField Bill to Add automatically filled when select customer
              Obx(
                () => controller.isAddressFieldVisible.value
                    ? SizedBox(
                        child: TextField(
                          controller: controller.addressController,
                          decoration: const InputDecoration(
                            labelText: AppStrings.ADDRESS,
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              // third TextField of Ship to Address we have to fill
              Obx(
                () => controller.isShipToAddFieldVisible.value
                    ? !controller.isShipToAddExpanded.value
                        ? Padding(
                            padding: const EdgeInsets.only(
                              top: Sizes.PADDING_8,
                            ),
                            child: TextField(
                              controller: controller.shipToAddController,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                labelText: 'Ship to add',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.isShipToAddExpanded.value = true;
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    controller.isShipToAddSearch.value
                                        ? Expanded(
                                            child: TextField(
                                              controller: controller
                                                  .searchCustomerController,
                                              autofocus: true,
                                              decoration: InputDecoration(
                                                labelText: AppStrings
                                                    .SEARCH_SHIP_TO_ADD,
                                                border:
                                                    const UnderlineInputBorder(),
                                                suffixIcon: IconButton(
                                                    icon:
                                                        const Icon(Icons.close),
                                                    onPressed: () {
                                                      controller
                                                          .isShipToAddSearch
                                                          .value = false;
                                                      controller
                                                          .shipToAddController
                                                          .clear();
                                                    }),
                                              ),
                                            ),
                                          )
                                        : Text(
                                            AppStrings.SEARCH_SHIP_TO_ADD,
                                            style: context.bodyLarge,
                                          ),
                                    Row(
                                      children: [
                                        controller.isShipToAddSearch.value
                                            ? const SizedBox.shrink()
                                            : GestureDetector(
                                                onTap: () {
                                                  controller.isShipToAddSearch
                                                      .value = true;
                                                },
                                                child: const Icon(Icons.search),
                                              ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.isShipToAddExpanded
                                                .value = false;
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
                                controller.customersShipToAdd.isNotEmpty
                                    ? Expanded(
                                        child: Scrollbar(
                                          thumbVisibility: true,
                                          controller: controller
                                              .shipToAddScrollController,
                                          child: ListView.builder(
                                            controller: controller
                                                .shipToAddScrollController,
                                            itemCount: controller
                                                .customersShipToAdd.length,
                                            itemBuilder: (context, index) {
                                              final filteredData = controller
                                                  .setSelectedShipToAdd(index);
                                              return ListTile(
                                                title: Text(filteredData),
                                                onTap: () {
                                                  controller.shipToAddController
                                                      .text = filteredData;
                                                  controller.isShipToAddExpanded
                                                      .value = false;
                                                  controller
                                                      .isAttandeeFieldVisible
                                                      .value = true;
                                                  controller
                                                      .searchShipToAddController
                                                      .clear();
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    : const Text(
                                        'Ship to Address not available'),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          children: [
                                            Text(
                                              'Add new ship to add',
                                              style: context.bodyLarge,
                                            ),
                                            const Icon(Icons.add),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                    : const SizedBox.shrink(),
              ),

              // Fourth  TextField of contacts
              Obx(
                () => controller.isAttandeeFieldVisible.value
                    ? !controller.isAttandeeExpanded.value
                        ? Padding(
                            padding: const EdgeInsets.only(
                              top: Sizes.PADDING_8,
                            ),
                            child: TextField(
                              controller: controller.attandeeController,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                labelText: 'Attandee',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.isAttandeeExpanded.value = true;
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    controller.isAttandeeSearch.value
                                        ? Expanded(
                                            child: TextField(
                                              controller: controller
                                                  .searchAttandeeController,
                                              autofocus: true,
                                              decoration: InputDecoration(
                                                labelText: 'Search Attandee',
                                                border:
                                                    const UnderlineInputBorder(),
                                                suffixIcon: IconButton(
                                                    icon:
                                                        const Icon(Icons.close),
                                                    onPressed: () {
                                                      controller
                                                          .isAttandeeSearch
                                                          .value = false;
                                                      controller
                                                          .searchAttandeeController
                                                          .clear();
                                                    }),
                                              ),
                                            ),
                                          )
                                        : Text(
                                            'Add new attandee',
                                            style: context.bodyLarge,
                                          ),
                                    Row(
                                      children: [
                                        controller.isAttandeeSearch.value
                                            ? const SizedBox.shrink()
                                            : GestureDetector(
                                                onTap: () {
                                                  controller.isAttandeeSearch
                                                      .value = true;
                                                },
                                                child: const Icon(Icons.search),
                                              ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.isAttandeeExpanded
                                                .value = false;
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
                                controller.customersContacts.isNotEmpty
                                    ? Expanded(
                                        child: Scrollbar(
                                          interactive: true,
                                          thickness: 12,
                                          thumbVisibility: true,
                                          controller: controller
                                              .attandeeScrollController,
                                          child: ListView.builder(
                                            controller: controller
                                                .attandeeScrollController,
                                            itemCount: controller
                                                .customersContacts.length,
                                            itemBuilder: (context, index) {
                                              final filteredData = controller
                                                  .customersContacts[index];

                                              return ListTile(
                                                leading: Obx(
                                                  () => Checkbox(
                                                    value: controller
                                                        .checkBoxStates[index],
                                                    onChanged: (value) {
                                                      controller
                                                          .onCheckboxChanged(
                                                              value, index);
                                                    },
                                                  ),
                                                ),
                                                title: Text(filteredData),
                                                onTap: () {
                                                  controller.attandeeController
                                                      .text = filteredData;
                                                  controller.isAttandeeExpanded
                                                      .value = false;
                                                  // controller.attandeeController
                                                  //     .clear();
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    : const Center(
                                        child: Text('No Contacts Available'),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          children: [
                                            Text(
                                              'Add new attandee',
                                              style: context.bodyLarge,
                                            ),
                                            const Icon(Icons.add),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                    : const SizedBox.shrink(),
              ),

              const SizedBox(
                height: Sizes.HEIGHT_10,
              ),

              //Wrap widget for generate contact buttons
              Obx(
                () => controller.selectedAttendees.isNotEmpty
                    ? Wrap(
                        spacing: 2,
                        runSpacing: 5,
                        children: List.generate(
                          (controller.selectedAttendees.length),
                          (index) => GestureDetector(
                            onTap: () {
                              controller.selectedAttendee.value =
                                  controller.selectedAttendees[index];
                              controller.attandeeSelectedIndex.value = index;
                            },
                            child: Obx(
                              () => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Sizes.PADDING_8,
                                    vertical: Sizes.PADDING_10),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: LightTheme.borderColor),
                                  color:
                                      controller.attandeeSelectedIndex.value ==
                                              index
                                          ? LightTheme.buttonBackgroundColor2
                                          : Colors.white,
                                ),
                                child: Text(
                                  controller.selectedAttendees[index],
                                  style: TextStyle(
                                    color: controller
                                                .attandeeSelectedIndex.value ==
                                            index
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),

              const SizedBox(
                height: Sizes.HEIGHT_10,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => controller.selectedAttendees.isNotEmpty
                        ? const CustomHeaderRow()
                        : const SizedBox(),
                  ),
                  Obx(() {
                    final selectedAttendee = controller.selectedAttendee.value;

                    // Check if selectedAttendee is not empty or null
                    if (selectedAttendee.isEmpty) {
                      return const SizedBox();
                    }

                    // Get the list of attendee data from Preferences
                    final attendeeData =
                        Preferences().getAttendee(selectedAttendee) ?? [];

                    return !controller.itemsListRefresh.value
                        ? SizedBox(
                            height: Sizes.HEIGHT_200,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: attendeeData.length, // Safe item count
                              itemBuilder: (context, index) {
                                // Fetch the item at the current index
                                final itemData = attendeeData[index];

                                return CustomRowCells(
                                  commentDialogBoxOnPressed: () {
                                    controller.showCommentDialog(context);
                                  },
                                  qntyController: itemData.qntyController,
                                  itemName: itemData.description,
                                  price: itemData.unitPrice.toString(),
                                  notesController: itemData.notesController,
                                );
                              },
                            ),
                          )
                        : const CircularProgressIndicator();
                  }),
                ],
              ),

              const SizedBox(
                height: Sizes.HEIGHT_200,
              ),
              Obx(
                () => controller.selectedAttendees.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            CustomElevatedButton(
                              onPressed: () {
                                // controller
                                //     .getSingleItemFromGraphQL('S10082-002');
                              },
                              title: 'Finish',
                              minWidht: Sizes.WIDTH_120,
                              minHeight: Sizes.HEIGHT_30,
                              backgroundColor:
                                  LightTheme.buttonBackgroundColor2,
                              borderRadiusCircular: BorderRadius.circular(
                                Sizes.RADIUS_6,
                              ),
                            ),
                            const SizedBox(
                              width: Sizes.WIDTH_10,
                            ),
                            CustomElevatedButton(
                              onPressed: () {
                                controller.scanBarcodeNormal();
                              },
                              title: 'Scan',
                              minWidht: Sizes.WIDTH_120,
                              minHeight: Sizes.HEIGHT_30,
                              backgroundColor:
                                  LightTheme.buttonBackgroundColor2,
                              borderRadiusCircular: BorderRadius.circular(
                                Sizes.RADIUS_6,
                              ),
                            ),
                          ])
                    : const SizedBox(),
              )
            ],
          )),
    );
  }
}
