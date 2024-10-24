import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/views/add_attendee/components/contact_page_textfield.dart';
import 'package:sales_person_app/views/add_attendee/controllers/add_attendee_controller.dart';
import 'package:sales_person_app/views/customer_visit/controllers/customer_visit_controller.dart';
import 'package:sales_person_app/widgets/custom_appbar.dart';
import 'package:sales_person_app/widgets/custom_elevated_button.dart';

class AddAttendeeScreen extends GetView<AddAttendeeController> {
  static const String routeName = '/add_attendee_screen';
  AddAttendeeScreen({super.key});
  final customerVisitController = Get.find<CustomerVisitController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: const Text(AppStrings.ADD_CONTACT),
        automaticallyImplyLeading: true,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.PADDING_22, vertical: Sizes.PADDING_28),
                  child: Column(
                    children: [
                      //ATTANDEE FULL NAME
                      ContactPageTextField(
                        hintText: AppStrings.ATTENDEE_F_NAME,
                        controller:
                            controller.contactFullNameTextFieldController,
                      ),
                      Obx(
                        () => !controller.isContactCustomerExpanded.value
                            ? Padding(
                                padding: const EdgeInsets.only(
                                  top: Sizes.PADDING_6,
                                ),
                                child: TextField(
                                  style: context.bodySmall.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: Sizes.TEXT_SIZE_16,
                                    color: const Color(0xff58595B),
                                  ),
                                  onTap: () => controller
                                      .isContactCustomerExpanded.value = true,
                                  controller: controller
                                      .contactCustomerTextFieldController,
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    labelText: AppStrings.CUSTOMER_NAME,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.isContactCustomerExpanded
                                            .value = true;
                                      },
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        size: Sizes.ICON_SIZE_26,
                                        color: Color(0xff7C7A7A),
                                      ),
                                    ),
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
                                            autofocus: true,
                                            onChanged: (value) {
                                              controller.filterCustomerList(
                                                  value,
                                                  customerVisitController
                                                      .tliCustomers);
                                            },
                                            controller: controller
                                                .contactCustomerTextFieldController,
                                            onTapOutside: (event) {},
                                            decoration: InputDecoration(
                                              labelText:
                                                  AppStrings.SEARCH_CUSTOMER,
                                              border:
                                                  const UnderlineInputBorder(),
                                              suffixIcon: IconButton(
                                                icon: const Icon(Icons.search),
                                                onPressed: () {},
                                              ),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xff7C7A7A),
                                                ),
                                              ),
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xff7C7A7A),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.isContactCustomerExpanded
                                                .value = false;
                                          },
                                          child: const Icon(
                                            Icons.arrow_drop_up,
                                            size: Sizes.ICON_SIZE_26,
                                            color: Color(0xff7C7A7A),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Scrollbar(
                                        radius: const Radius.circular(
                                            Sizes.RADIUS_6),
                                        interactive: true,
                                        thickness: 12,
                                        thumbVisibility: true,
                                        controller: controller
                                            .contactCustomerScrollController,
                                        child: customerVisitController
                                                        .tliCustomers?.value !=
                                                    null &&
                                                customerVisitController
                                                    .tliCustomers!
                                                    .value
                                                    .isNotEmpty
                                            ? ListView.builder(
                                                controller: controller
                                                    .contactCustomerScrollController,
                                                itemCount: controller
                                                        .filteredCustomers
                                                        .isNotEmpty
                                                    ? controller
                                                        .filteredCustomers
                                                        .length
                                                    : customerVisitController
                                                        .tliCustomers
                                                        ?.value
                                                        .length,
                                                itemBuilder: (context, index) {
                                                  final filteredData = controller
                                                          .filteredCustomers
                                                          .isNotEmpty
                                                      ? controller
                                                          .filteredCustomers[
                                                              index]
                                                          .name
                                                      : customerVisitController
                                                          .tliCustomers
                                                          ?.value[index]
                                                          .name;
                                                  return ListTile(
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    dense: true,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    title: Text(
                                                      filteredData!,
                                                      style: context.bodySmall
                                                          .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize:
                                                            Sizes.TEXT_SIZE_16,
                                                        color: const Color(
                                                            0xff58595B),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      controller
                                                              .filteredCustomers
                                                              .value =
                                                          customerVisitController
                                                              .tliCustomers!
                                                              .value;
                                                      // controller
                                                      //     .setCustomerData(
                                                      //         index);
                                                      controller
                                                          .contactCustomerTextFieldController
                                                          .text = filteredData;

                                                      controller
                                                          .isContactCustomerExpanded
                                                          .value = false;
                                                    },
                                                  );
                                                },
                                              )
                                            : controller.isLoading.value
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Center(
                                                    child: Text(
                                                      AppStrings.NO_CUST_AVAIL,
                                                      style: context.bodySmall
                                                          .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize:
                                                            Sizes.TEXT_SIZE_14,
                                                        color: const Color(
                                                            0xff58595B),
                                                      ),
                                                    ),
                                                  ),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 8.0),
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.end,
                                    //     children: [
                                    //       GestureDetector(
                                    //         onTap: () {},
                                    //         child: Row(
                                    //           children: [
                                    //             Text(
                                    //               AppStrings.ADD_CUSTOMER,
                                    //               style: context.bodyLarge,
                                    //             ),
                                    //             const Icon(Icons.add),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                      ), //EMAIL OF ATTANDEE
                      ContactPageTextField(
                        hintText: AppStrings.EMAIL,
                        controller: controller.contactEmailTextFieldController,
                      ),

                      //PHONE NUMBER OF ATTANDEE
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: Sizes.PADDING_10),
                        child: ContactPageTextField(
                          hintText: AppStrings.PH_NUMBER,
                          controller:
                              controller.contactPhoneNoTextFieldController,
                        ),
                      ),

                      //ELEVATED BUTTONS FOR CANCEL & ADD
                      Padding(
                        padding: const EdgeInsets.only(top: Sizes.PADDING_260),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomElevatedButton(
                                onPressed: () {
                                  controller.clearAllTextFieldsOfContactPage();
                                },
                                title: AppStrings.CANCEL,
                                minWidht: Sizes.WIDTH_90,
                                minHeight: Sizes.HEIGHT_30,
                                backgroundColor:
                                    LightTheme.buttonBackgroundColor2,
                                borderRadiusCircular:
                                    BorderRadius.circular(Sizes.RADIUS_6),
                              ),
                              const SizedBox(
                                width: Sizes.WIDTH_26,
                              ),
                              CustomElevatedButton(
                                onPressed: () {
                                  controller.ateendeeFormValidation();
                                },
                                title: AppStrings.SAVE,
                                minWidht: Sizes.WIDTH_90,
                                minHeight: Sizes.HEIGHT_30,
                                backgroundColor:
                                    LightTheme.buttonBackgroundColor2,
                                borderRadiusCircular:
                                    BorderRadius.circular(Sizes.RADIUS_6),
                              )
                            ]),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
