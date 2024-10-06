import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/views/main_page/controllers/main_page_controller.dart';

class CustomerPageScreen extends GetView<MainPageController> {
  static const String routeName = '/custome_page_screen';
  const CustomerPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          top: Sizes.PADDING_10,
          left: Sizes.PADDING_10,
          right: Sizes.PADDING_10,
        ),
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
                        // onChanged: (value) =>,
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
                                        controller:
                                            controller.searchCustomerController,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                          labelText: 'Search customer',
                                          // hintText: widget.seachHintText,
                                          border: const UnderlineInputBorder(),
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
                                            controller.isCustomerSearch.value =
                                                true;
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
                              thumbVisibility: true,
                              controller: controller.customerScrollController,
                              child: controller.tliCustomers?.value != null &&
                                      controller.tliCustomers!.value.isNotEmpty
                                  ? ListView.builder(
                                      controller:
                                          controller.customerScrollController,
                                      itemCount:
                                          controller.tliCustomers?.value.length,
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
                                            controller.searchCustomerController
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
                                        'Add new Customer',
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
                      child: Expanded(
                        child: TextField(
                          controller: controller.addressController,
                          decoration: const InputDecoration(
                            labelText: 'Address',
                            border: UnderlineInputBorder(),
                          ),
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
                                              labelText:
                                                  'Search ship to address',
                                              border:
                                                  const UnderlineInputBorder(),
                                              suffixIcon: IconButton(
                                                  icon: const Icon(Icons.close),
                                                  onPressed: () {
                                                    controller.isShipToAddSearch
                                                        .value = false;
                                                    controller
                                                        .shipToAddController
                                                        .clear();
                                                  }),
                                            ),
                                          ),
                                        )
                                      : Text(
                                          'Search ship to Add',
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
                                ],
                              ),
                              Expanded(
                                child: Scrollbar(
                                  thumbVisibility: true,
                                  controller:
                                      controller.shipToAddScrollController,
                                  child: ListView.builder(
                                    controller:
                                        controller.shipToAddScrollController,
                                    itemCount:
                                        controller.customersShipToAdd.length,
                                    itemBuilder: (context, index) {
                                      final filteredData =
                                          controller.customersShipToAdd[index];
                                      return ListTile(
                                        title: Text(filteredData),
                                        onTap: () {
                                          controller.shipToAddController.text =
                                              filteredData;
                                          controller.isShipToAddExpanded.value =
                                              false;
                                          controller.searchShipToAddController
                                              .clear();
                                        },
                                      );
                                    },
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
            // Obx(
            //   () => controller.isAttandeeFieldVisible.value
            //       ? !controller.isAttandeeExpanded.value
            //           ? Padding(
            //               padding: const EdgeInsets.only(
            //                 top: Sizes.PADDING_8,
            //               ),
            //               child: TextField(
            //                 controller: controller.attandeeController,
            //                 textAlign: TextAlign.left,
            //                 decoration: InputDecoration(
            //                   labelText: 'Attandee',
            //                   suffixIcon: IconButton(
            //                     onPressed: () {
            //                       controller.isAttandeeExpanded.value = true;
            //                     },
            //                     icon: const Icon(
            //                       Icons.arrow_drop_down,
            //                       size: Sizes.WIDTH_30,
            //                       color: Colors.black,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             )
            //           : Container(
            //               height: Sizes.HEIGHT_250,
            //               width: double.infinity,
            //               decoration: const BoxDecoration(
            //                 border: Border(
            //                   bottom: BorderSide(
            //                     color: Colors.grey,
            //                   ),
            //                 ),
            //               ),
            //               child: Column(
            //                 children: [
            //                   Row(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       controller.isAttandeeSearch.value
            //                           ? Expanded(
            //                               child: TextField(
            //                                 controller: controller
            //                                     .searchAttandeeController,
            //                                 autofocus: true,
            //                                 decoration: InputDecoration(
            //                                   labelText: 'Search Attandee',
            //                                   border:
            //                                       const UnderlineInputBorder(),
            //                                   suffixIcon: IconButton(
            //                                       icon: const Icon(Icons.close),
            //                                       onPressed: () {
            //                                         controller.isAttandeeSearch
            //                                             .value = false;
            //                                         controller
            //                                             .attandeeController
            //                                             .clear();
            //                                       }),
            //                                 ),
            //                               ),
            //                             )
            //                           : Text(
            //                               'Add new attandee',
            //                               style: context.bodyLarge,
            //                             ),
            //                       Row(
            //                         children: [
            //                           controller.isAttandeeSearch.value
            //                               ? const SizedBox.shrink()
            //                               : GestureDetector(
            //                                   onTap: () {
            //                                     controller.isAttandeeSearch
            //                                         .value = true;
            //                                   },
            //                                   child: const Icon(Icons.search),
            //                                 ),
            //                           GestureDetector(
            //                             onTap: () {
            //                               controller.isAttandeeExpanded.value =
            //                                   false;
            //                             },
            //                             child: const Icon(
            //                               Icons.arrow_drop_up,
            //                               size: Sizes.WIDTH_40,
            //                               color: Color.fromRGBO(0, 0, 0, 1),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                   Expanded(
            //                     child: Scrollbar(
            //                       thumbVisibility: true,
            //                       controller:
            //                           controller.attandeeScrollController,
            //                       child: ListView.builder(
            //                         controller:
            //                             controller.attandeeScrollController,
            //                         itemCount:
            //                             controller.customersShipToAdd.length,
            //                         itemBuilder: (context, index) {
            //                           final filteredData =
            //                               controller.customersShipToAdd[index];
            //                           return ListTile(
            //                             title: Text(filteredData),
            //                             onTap: () {
            //                               controller.shipToAddController.text =
            //                                   filteredData;
            //                               controller.isShipToAddExpanded.value =
            //                                   false;
            //                               controller.searchShipToAddController
            //                                   .clear();
            //                             },
            //                           );
            //                         },
            //                       ),
            //                     ),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.only(top: 8.0),
            //                     child: Row(
            //                       mainAxisAlignment: MainAxisAlignment.end,
            //                       children: [
            //                         GestureDetector(
            //                           onTap: () {},
            //                           child: Row(
            //                             children: [
            //                               Text(
            //                                 'Add new ship to add',
            //                                 style: context.bodyLarge,
            //                               ),
            //                               const Icon(Icons.add),
            //                             ],
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             )
            //       : const SizedBox.shrink(),
            // ),

            // const SizedBox(
            //   height: Sizes.HEIGHT_10,
            // ),
            // Wrap(
            //   spacing: 2,
            //   runSpacing: 5,
            //   children: List.generate(
            //     controller.dropdownItems[0].length + 1,
            //     (index) => GestureDetector(
            //       onTap: () {
            //         controller.attandeeSelectedIndex.value = index;
            //       },
            //       child: Obx(() => Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 8, vertical: 10),
            //             decoration: BoxDecoration(
            //               border: Border.all(color: LightTheme.borderColor),
            //               color: controller.attandeeSelectedIndex.value == index
            //                   ? LightTheme.buttonBackgroundColor2
            //                   : Colors.white,
            //             ),
            //             child: Text(
            //               index == 0
            //                   ? 'General'
            //                   : controller.dropdownItems[0][index - 1],
            //               style: TextStyle(
            //                 color:
            //                     controller.attandeeSelectedIndex.value == index
            //                         ? Colors.white
            //                         : Colors.black,
            //               ),
            //             ),
            //           )),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: Sizes.HEIGHT_10,
            // ),
            // const CustomHeaderRow(),
            // Obx(
            //   () => CustomRowCells(
            //     itemName: controller.scanBarcode.value,
            //   ),
            // ),
            // const SizedBox(
            //   height: Sizes.HEIGHT_250,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     CustomElevatedButton(
            //       onPressed: () {
            //         controller.getCustomersFromGraphQL();
            //       },
            //       title: 'Finish',
            //       minWidht: Sizes.WIDTH_120,
            //       minHeight: Sizes.HEIGHT_30,
            //       backgroundColor: LightTheme.buttonBackgroundColor2,
            //       borderRadiusCircular: BorderRadius.circular(10),
            //     ),
            //     const SizedBox(
            //       width: Sizes.WIDTH_10,
            //     ),
            //     CustomElevatedButton(
            //       onPressed: () => controller.scanBarcodeNormal(),
            //       title: 'Scan',
            //       minWidht: Sizes.WIDTH_120,
            //       minHeight: Sizes.HEIGHT_30,
            //       backgroundColor: LightTheme.buttonBackgroundColor2,
            //       borderRadiusCircular: BorderRadius.circular(10),
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
