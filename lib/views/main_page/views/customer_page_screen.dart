import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/views/main_page/components/custom_row_data_cells.dart';
import 'package:sales_person_app/views/main_page/controllers/main_page_controller.dart';
import 'package:sales_person_app/widgets/custom_elevated_button.dart';
import '../components/custom_header_row.dart';
import '../models/tli_sales_line.dart';

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
                            labelText: AppStrings.CUSTOMER_NAME,
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
                                          decoration: InputDecoration(
                                            labelText:
                                                AppStrings.SEARCH_CUSTOMER,
                                            border:
                                                const UnderlineInputBorder(),
                                            suffixIcon: IconButton(
                                                icon: const Icon(Icons.search),
                                                onPressed: () {
                                                  controller.isCustomerSearch
                                                      .value = false;

                                                  // controller.searchQuery(items, item, controller)
                                                  controller
                                                      .searchCustomerController
                                                      .clear();
                                                }),
                                          ),
                                        ),
                                      )
                                    : Text(
                                        AppStrings.SEARCH_CUSTOMER,
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
                                labelText: AppStrings.SHIP_TO_ADD,
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
                                              decoration: InputDecoration(
                                                labelText: AppStrings
                                                    .SEARCH_SHIP_TO_ADD,
                                                border:
                                                    const UnderlineInputBorder(),
                                                suffixIcon: IconButton(
                                                    icon: const Icon(
                                                        Icons.search),
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
                                        AppStrings.SHIP_TO_ADD_NOT_AVAILABLE),
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
                                              AppStrings.ADD_NEW_SHIP_TO_ADD,
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
                                labelText: AppStrings.ATTANDEE,
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
                                              decoration: InputDecoration(
                                                labelText:
                                                    AppStrings.SEARCH_ATTANDEE,
                                                border:
                                                    const UnderlineInputBorder(),
                                                suffixIcon: IconButton(
                                                    icon: const Icon(
                                                        Icons.search),
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
                                            AppStrings.ADD_ATTANDEE,
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
                                controller.customerContacts.isNotEmpty
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
                                                .customerContacts.length,
                                            itemBuilder: (context, index) {
                                              final filteredData = controller
                                                      .customerContacts[index]
                                                  ['name'];
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
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    : const Center(
                                        child: Text(
                                            AppStrings.NO_CONTACTS_AVAILABLE),
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
                                              AppStrings.ADD_ATTANDEE,
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
                                  controller.selectedAttendees[index]['name'];
                              controller.attandeeSelectedIndex.value = index;
                              print(
                                  ' Index: ${controller.attandeeSelectedIndex.value}');
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
                                  controller.selectedAttendees[index]['name'],
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
                    // Safeguard and Debug: Log the refresh state
                    log("Items List Refresh State: ${controller.itemsListRefresh.value}");

                    // Show CircularProgressIndicator when refreshing
                    if (controller.itemsListRefresh.value) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    // Safeguard: Ensure selectedAttendee is not null or empty
                    final selectedAttendee = controller.selectedAttendee.value;
                    log("Selected Attendee: $selectedAttendee");

                    if (selectedAttendee == null || selectedAttendee.isEmpty) {
                      return const SizedBox(); // If it's null or empty, show nothing.
                    }

                    // Safely retrieve the attendee data
                    final attendeeData = controller.selectedAttendees[
                            controller.attandeeSelectedIndex.value] ??
                        {};

                    // Safeguard: Log and safely retrieve the sales line list
                    final List<dynamic> tliSalesLineList =
                        attendeeData['tliSalesLine'] ?? [];

                    log("Sales Line List Length: ${tliSalesLineList.length}");

                    if (tliSalesLineList.isEmpty) {
                      return const Center(
                        child: Text("No sales data available"),
                      );
                    }

                    return SizedBox(
                      height: Sizes.HEIGHT_200,
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: tliSalesLineList.length,
                        itemBuilder: (context, index) {
                          // Safeguard: Ensure salesLineItem is valid
                          final salesLineItem = tliSalesLineList[index];

                          // Check if salesLineItem is null
                          if (salesLineItem == null) {
                            log("Sales Line Item at Index $index is null!");
                            return const SizedBox();
                          }

                          // Cast it as TliSalesLineElement and safeguard its fields
                          final TliSalesLineElement? validSalesLineItem =
                              salesLineItem as TliSalesLineElement?;

                          if (validSalesLineItem == null) {
                            log("Failed to cast item at index $index to TliSalesLineElement");
                            return const SizedBox();
                          }

                          // Safeguard: Ensure all necessary fields are available
                          final description =
                              validSalesLineItem.itemDescription ??
                                  'Unknown Item';
                          final quantity =
                              validSalesLineItem.quantity?.toString() ?? '0';
                          final price =
                              validSalesLineItem.unitPrice?.toString() ?? '0';

                          log("Sales Line Item at Index $index: $description");

                          return CustomRowCells(
                            commentDialogBoxOnPressed: () {
                              controller.showCommentDialog(context);
                            },
                            qntyController: TextEditingController(
                              text: quantity,
                            ),
                            qty: quantity,
                            itemName: description,
                            price: price,
                            notesController: TextEditingController(),
                          );
                        },
                      ),
                    );
                  })

                  // Obx(() {
                  //   final selectedAttendee = controller.selectedAttendee.value;

                  //   if (selectedAttendee.isEmpty) {
                  //     return const SizedBox();
                  //   }

                  //   final attendeeData = controller.selectedAttendees[
                  //           controller.attandeeSelectedIndex.value] ??
                  //       {};

                  //   final List<dynamic> tliSalesLineList =
                  //       attendeeData['tliSalesLine'] ?? [];

                  //   // return !controller.itemsListRefresh.value
                  //   //     ?
                  //   return SizedBox(
                  //     height: Sizes.HEIGHT_200,
                  //     width: double.infinity,
                  //     child: ListView.builder(
                  //       scrollDirection: Axis.vertical,
                  //       itemCount: tliSalesLineList.length,
                  //       itemBuilder: (context, index) {
                  //         TliSalesLineElement salesLineItem =
                  //             tliSalesLineList[index];
                  //         // controller
                  //         //     .selectedAttendees[0]['tliSalesLine'][index];
                  //         log("***** Description *********${salesLineItem.itemDescription}");
                  //         return CustomRowCells(
                  //           commentDialogBoxOnPressed: () {
                  //             controller.showCommentDialog(context);
                  //           },
                  //           qntyController: TextEditingController(
                  //               text: salesLineItem.quantity.toString()),
                  //           qty: salesLineItem.quantity.toString(),
                  //           itemName: salesLineItem.itemDescription,
                  //           price: salesLineItem.unitPrice.toString(),
                  //           notesController: TextEditingController(),
                  //         );
                  //       },
                  //     ),
                  //   );
                  //   // : const SizedBox();
                  // }),
                ],
              ),

              const SizedBox(
                height: Sizes.HEIGHT_100,
              ),
              Obx(
                () => controller.selectedAttendees.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            CustomElevatedButton(
                              onPressed: () {
                                controller
                                    .getSingleItemFromGraphQL('S10082-002');
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
