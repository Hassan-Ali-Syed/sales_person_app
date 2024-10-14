import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/views/add_attendee/components/contact_page_textfield.dart';
import 'package:sales_person_app/views/add_attendee/controllers/add_attendee_controller.dart';
import 'package:sales_person_app/widgets/custom_appbar.dart';
import 'package:sales_person_app/widgets/custom_elevated_button.dart';

class AddAttendeeScreen extends GetView<AddAttendeeController> {
  static const String routeName = '/add_attendee_screen';
  const AddAttendeeScreen({super.key});

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
                        hintText: AppStrings.ATTANDEE_F_NAME,
                        controller:
                            controller.contactFullNameTextFieldController,
                      ),

                      // RELATED CUSTOMER TEXTFIELD
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: Sizes.PADDING_10),
                        child: Obx(
                          () => !controller.isContactCustomerExpanded.value
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    top: Sizes.PADDING_8,
                                  ),
                                  child: TextField(
                                    controller: controller
                                        .contactCustomerTextFieldController,
                                    textAlign: TextAlign.left,
                                    // onChanged: (value) {
                                    //   controller.filterCustomerList(value);
                                    // },
                                    onSubmitted: (value) {},
                                    decoration: InputDecoration(
                                      labelText: AppStrings.CUSTOMER,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          controller.isContactCustomerExpanded
                                              .value = true;
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
                                          // controller
                                          //         .isContactCustomerSearch.value
                                          // ?
                                          Expanded(
                                            child: TextField(
                                              onChanged: (value) {
                                                controller
                                                    .filterCustomerList(value);
                                              },
                                              controller: controller
                                                  .contactSearchTextFieldController,
                                              decoration: InputDecoration(
                                                labelText:
                                                    AppStrings.SEARCH_CUSTOMER,
                                                border:
                                                    const UnderlineInputBorder(),
                                                suffixIcon: IconButton(
                                                    icon: const Icon(
                                                        Icons.search),
                                                    onPressed: () {
                                                      controller
                                                          .isContactCustomerSearch
                                                          .value = false;
                                                      controller
                                                          .contactSearchTextFieldController
                                                          .clear();
                                                    }),
                                              ),
                                            ),
                                          ),
                                          // : Text(
                                          //     AppStrings.SEARCH_CUSTOMER,
                                          //     style: context.bodyLarge,
                                          //   ),
                                          Row(
                                            children: [
                                              // controller.isContactCustomerSearch
                                              //         .value
                                              //     ? const SizedBox.shrink()
                                              //     : GestureDetector(
                                              //         onTap: () {
                                              //           controller
                                              //               .isContactCustomerSearch
                                              //               .value = true;
                                              //         },
                                              //         child: const Icon(
                                              //             Icons.search),
                                              //       ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .isContactCustomerExpanded
                                                      .value = false;
                                                },
                                                child: const Icon(
                                                  Icons.arrow_drop_up,
                                                  size: Sizes.WIDTH_40,
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1),
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
                                          controller: controller
                                              .contactCustomerScrollController,
                                          child: controller.tliCustomers
                                                          ?.value !=
                                                      null &&
                                                  controller.tliCustomers!.value
                                                      .isNotEmpty
                                              ? ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  controller: controller
                                                      .contactCustomerScrollController,
                                                  itemCount: controller
                                                      .tliCustomers
                                                      ?.value
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final sortedCustomers =
                                                        controller
                                                            .tliCustomers!.value
                                                          ..sort((a, b) => a
                                                              .name!
                                                              .toLowerCase()
                                                              .compareTo(b.name!
                                                                  .toLowerCase()));
                                                    final filteredData =
                                                        sortedCustomers[index]
                                                            .name;
                                                    return ListTile(
                                                      title:
                                                          Text(filteredData!),
                                                      onTap: () {
                                                        controller
                                                                .contactCustomerNo
                                                                .value =
                                                            controller
                                                                .tliCustomers!
                                                                .value[index]
                                                                .no!;
                                                        controller
                                                            .contactCustomerTextFieldController
                                                            .text = filteredData;
                                                        controller
                                                            .isContactCustomerExpanded
                                                            .value = false;
                                                        controller
                                                            .contactSearchTextFieldController
                                                            .clear();
                                                      },
                                                    );
                                                  },
                                                )
                                              : const Center(
                                                  child: Text(
                                                      AppStrings.NO_CUST_AVAIL),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),

                      //EMAIL OF ATTANDEE
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
                                minWidht: Sizes.WIDTH_100,
                                minHeight: Sizes.HEIGHT_30,
                                backgroundColor:
                                    LightTheme.buttonBackgroundColor2,
                                borderRadiusCircular:
                                    BorderRadius.circular(Sizes.RADIUS_6),
                              ),
                              const SizedBox(
                                width: Sizes.WIDTH_20,
                              ),
                              CustomElevatedButton(
                                onPressed: () {
                                  controller.createTliContacts(
                                    name: controller
                                        .contactFullNameTextFieldController
                                        .text,
                                    customerNo:
                                        controller.contactCustomerNo.value,
                                    email: controller
                                        .contactEmailTextFieldController.text,
                                    phoneNo: controller
                                        .contactPhoneNoTextFieldController.text,
                                  );
                                },
                                title: AppStrings.SAVE,
                                minWidht: Sizes.WIDTH_100,
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
