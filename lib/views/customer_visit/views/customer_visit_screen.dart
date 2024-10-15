import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/routes/app_routes.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/views/customer_visit/components/custom_header_row.dart';
import 'package:sales_person_app/views/customer_visit/components/custom_row_data_cells.dart';
import 'package:sales_person_app/views/customer_visit/controllers/customer_visit_controller.dart';
import 'package:sales_person_app/views/main_page/models/tli_sales_line.dart';
import 'package:sales_person_app/widgets/custom_appbar.dart';
import 'package:sales_person_app/widgets/custom_elevated_button.dart';

class CustomerVisitScreen extends GetView<CustomerVisitController> {
  static const String routeName = '/customer_visit_screen';
  const CustomerVisitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        automaticallyImplyLeading: true,
        title: const Text(AppStrings.CUSTOMER_VISIT),
      ),
      body: SingleChildScrollView(
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
                            readOnly: true,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: TextField(
                                      onChanged: (value) {
                                        controller.filterCustomerList(value);
                                      },
                                      controller:
                                          controller.searchCustomerController,
                                      onTapOutside: (event) {},
                                      decoration: InputDecoration(
                                        labelText: AppStrings.SEARCH_CUSTOMER,
                                        border: const UnderlineInputBorder(),
                                        suffixIcon: IconButton(
                                            icon: const Icon(Icons.search),
                                            onPressed: () {
                                              controller.isCustomerSearch
                                                  .value = false;

                                              // controller.searchQuery(items, item, controller)
                                              controller
                                                  .searchCustomerController
                                                  .clear();

                                              controller.searchAttandeeController
                                                          .text !=
                                                      ''
                                                  ? controller
                                                          .customerTextFieldController
                                                          .text =
                                                      controller
                                                          .searchCustomerController
                                                          .text
                                                  : controller
                                                          .customerTextFieldController =
                                                      controller
                                                          .customerTextFieldController;
                                            }),
                                      ),
                                    ),
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
                              Expanded(
                                child: Scrollbar(
                                  interactive: true,
                                  thickness: 12,
                                  thumbVisibility: true,
                                  controller:
                                      controller.customerScrollController,
                                  child: controller.tliCustomers?.value !=
                                              null &&
                                          controller
                                              .tliCustomers!.value.isNotEmpty
                                      ? ListView.builder(
                                          controller: controller
                                              .customerScrollController,
                                          itemCount: controller
                                                  .filteredCustomers.isNotEmpty
                                              ? controller
                                                  .filteredCustomers.length
                                              : controller
                                                  .tliCustomers?.value.length,
                                          itemBuilder: (context, index) {
                                            final filteredData = controller
                                                    .filteredCustomers
                                                    .isNotEmpty
                                                ? controller
                                                    .filteredCustomers[index]
                                                    .name
                                                : controller.tliCustomers
                                                    ?.value[index].name;
                                            return ListTile(
                                              title: Text(filteredData!),
                                              onTap: () {
                                                controller.filteredCustomers
                                                        .value =
                                                    controller
                                                        .tliCustomers!.value;
                                                controller
                                                    .setCustomerData(index);
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
                            readOnly: true,
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
                                readOnly: true,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  labelText: AppStrings.SHIP_TO_ADD,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.isShipToAddExpanded.value =
                                          true;
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
                                      // controller.isShipToAddSearch.value
                                      //     ?
                                      Expanded(
                                        child: TextField(
                                          controller: controller
                                              .searchCustomerController,
                                          decoration: InputDecoration(
                                            labelText:
                                                AppStrings.SEARCH_SHIP_TO_ADD,
                                            border:
                                                const UnderlineInputBorder(),
                                            suffixIcon: IconButton(
                                                icon: const Icon(Icons.search),
                                                onPressed: () {
                                                  controller.isShipToAddSearch
                                                      .value = false;
                                                  controller.shipToAddController
                                                      .clear();
                                                }),
                                          ),
                                        ),
                                      ),
                                      // : Text(
                                      //     AppStrings.SEARCH_SHIP_TO_ADD,
                                      //     style: context.bodyLarge,
                                      //   ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.isShipToAddExpanded.value =
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
                                                    .setSelectedShipToAdd(
                                                        index);
                                                return ListTile(
                                                  title: Text(filteredData),
                                                  onTap: () {
                                                    controller
                                                        .shipToAddController
                                                        .text = filteredData;
                                                    controller
                                                        .isShipToAddExpanded
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
                                      : const Expanded(
                                          child: Center(
                                            child: Text(AppStrings
                                                .SHIP_TO_ADD_NOT_AVAILABLE),
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
                                readOnly: true,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  labelText: AppStrings.ATTANDEE,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.isAttandeeExpanded.value =
                                          true;
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
                                      // controller.isAttandeeSearch.value
                                      //     ?
                                      Expanded(
                                        child: TextField(
                                          controller: controller
                                              .searchAttandeeController,
                                          decoration: InputDecoration(
                                            labelText:
                                                AppStrings.SEARCH_ATTANDEE,
                                            border:
                                                const UnderlineInputBorder(),
                                            suffixIcon: IconButton(
                                                icon: const Icon(Icons.search),
                                                onPressed: () {
                                                  controller.isAttandeeSearch
                                                      .value = false;
                                                  controller
                                                      .searchAttandeeController
                                                      .clear();
                                                }),
                                          ),
                                        ),
                                      ),
                                      // : Text(
                                      //     AppStrings.ADD_ATTANDEE,
                                      //     style: context.bodyLarge,
                                      //   ),
                                      Row(
                                        children: [
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
                                                              .checkBoxStates[
                                                          index],
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
                                      : const Expanded(
                                          child: Center(
                                            child: Text(AppStrings
                                                .NO_CONTACTS_AVAILABLE),
                                          ),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                                AppRoutes.ADD_ATTENDEE_PAGE);
                                          },
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

                Obx(
                  () => controller.selectedAttendees.isNotEmpty
                      ? Wrap(
                          spacing: 2,
                          runSpacing: 5,
                          children: List.generate(
                            (controller.selectedAttendees.length),
                            (index) => GestureDetector(
                              onTap: () {
                                controller.userItemListReferesh.value = true;
                                controller.itemQntyController.clear();
                                controller.selectedAttendee.value =
                                    controller.selectedAttendees[index]['name'];
                                controller.attandeeSelectedIndex.value = index;

                                controller.itemIndex.value = -1;
                                log(' Index: ${controller.attandeeSelectedIndex.value}');
                                controller.userItemListReferesh.value = false;
                              },
                              child: Obx(
                                () => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Sizes.PADDING_8,
                                      vertical: Sizes.PADDING_10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: LightTheme.borderColor),
                                    color: controller
                                                .attandeeSelectedIndex.value ==
                                            index
                                        ? LightTheme.buttonBackgroundColor2
                                        : Colors.white,
                                  ),
                                  child: Text(
                                    controller.selectedAttendees[index]['name'],
                                    style: TextStyle(
                                      color: controller.attandeeSelectedIndex
                                                  .value ==
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
                      return controller.userItemListReferesh.value
                          ? const Center(child: CircularProgressIndicator())
                          : controller.selectedAttendees.isEmpty
                              ? const SizedBox()
                              : SizedBox(
                                  height: Sizes.HEIGHT_200,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: controller
                                        .selectedAttendees[controller
                                            .attandeeSelectedIndex
                                            .value]['tliSalesLine']
                                        .length,
                                    itemBuilder: (context, index) {
                                      TliSalesLineElement salesLineItem =
                                          controller.selectedAttendees[
                                                  controller
                                                      .attandeeSelectedIndex
                                                      .value]['tliSalesLine']
                                              [index];

                                      log("***** Description *********${salesLineItem.itemDescription}");
                                      return CustomRowCells(
                                        rowIndex: index,
                                        selectedIndex:
                                            controller.itemIndex.value,
                                        commentDialogBoxOnPressed: () {
                                          controller.showCommentDialog(context,
                                              controller:
                                                  controller.commentController);
                                        },
                                        qtyOnChanged: (p0) {
                                          controller.userItemListReferesh
                                              .value = true;
                                          if (p0.isNotEmpty) {
                                            salesLineItem.quantity =
                                                num.parse(p0);
                                            controller
                                                .selectedAttendees[controller
                                                        .attandeeSelectedIndex
                                                        .value]['tliSalesLine']
                                                    [index]
                                                .quantity = num.parse(p0);
                                          } else {
                                            salesLineItem.quantity = 1;
                                            controller
                                                .selectedAttendees[controller
                                                        .attandeeSelectedIndex
                                                        .value]['tliSalesLine']
                                                    [index]
                                                .quantity = 1;
                                          }

                                          controller.userItemListReferesh
                                              .value = false;
                                          log('===Attendee Indeex ON CHANGED  ${controller.attandeeSelectedIndex.value}============');
                                        },
                                        qtyOnTap: () {
                                          controller.userItemListReferesh
                                              .value = true;
                                          controller.itemQntyController.clear();
                                          controller.itemQntyController.text =
                                              salesLineItem.quantity.toString();
                                          controller.isQtyPressed.value = true;
                                          controller.itemIndex.value = index;
                                          controller.userItemListReferesh
                                              .value = false;
                                          log('===Attendee Indeex ON TAP  ${controller.attandeeSelectedIndex.value}============');
                                        },
                                        isQtyPressed:
                                            controller.isQtyPressed.value,
                                        qntyController:
                                            controller.itemQntyController,
                                        qty: salesLineItem.quantity.toString(),
                                        itemName: salesLineItem.itemDescription,
                                        price:
                                            salesLineItem.unitPrice.toString(),
                                        notesController: TextEditingController(
                                            text: controller
                                                .commentController.text),
                                      );
                                    },
                                  ),
                                );
                    }),
                  ],
                ),

                const SizedBox(
                  height: Sizes.HEIGHT_20,
                ),
                Obx(
                  () => controller.selectedAttendees.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              CustomElevatedButton(
                                onPressed: () async {
                                  await controller
                                      .createSalesOrdersOfSelectedAttandees();
                                },
                                title: AppStrings.FINISH,
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
                                  // controller.scanBarcodeNormal();
                                  controller
                                      .getSingleItemFromGraphQL('S10082-002');
                                },
                                title: AppStrings.SCAN,
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
      ),
    );
  }
}
