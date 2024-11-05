import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/views/add_new_customer/components/add_customer_tile.dart';
import 'package:sales_person_app/views/add_new_customer/controller/add_new_customer_controller.dart';
import 'package:sales_person_app/widgets/custom_appbar.dart';
import 'package:sales_person_app/widgets/custom_textfield.dart';

class AddNewCustomerScreen extends GetView<AddNewCustomerController> {
  static const String routeName = '/add_new_customer_screen';
  const AddNewCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: const Text(AppStrings.ADD_CUSTOMER),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Sizes.PADDING_22, horizontal: Sizes.PADDING_18),
          child: Column(
            children: [
              AddCustomerTile(
                  onTap: () {
                    controller.toggleGeneral();
                  },
                  title: 'GENERAL',
                  icon: Obx(
                    () => Icon(
                      controller.generalPressed.value
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      color: Colors.white,
                      size: Sizes.ICON_SIZE_36,
                    ),
                  )),
              Obx(
                () => controller.generalPressed.value
                    ? Padding(
                        padding: const EdgeInsets.only(
                            top: Sizes.PADDING_8,
                            left: Sizes.PADDING_14,
                            right: Sizes.PADDING_14,
                            bottom: Sizes.PADDING_10),
                        child: Column(
                          children: [
                            const CustomTextField(hintText: 'Name'),
                            CustomTextField(
                              hintText: 'Sales Person Code',
                              suffixIcon: GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xff7C7A7A),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : const SizedBox(
                        height: Sizes.HEIGHT_10,
                      ),
              ),
              AddCustomerTile(
                onTap: () {
                  controller.toggleadressContact();
                },
                title: 'ADDRESS & CONTACT',
                icon: Obx(
                  () => Icon(
                      controller.adressContactPressed.value
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      color: Colors.white,
                      size: Sizes.ICON_SIZE_36),
                ),
              ),
              Obx(
                () => controller.adressContactPressed.value
                    ? const Padding(
                        padding: EdgeInsets.only(
                            top: Sizes.PADDING_8,
                            left: Sizes.PADDING_14,
                            right: Sizes.PADDING_14,
                            bottom: Sizes.PADDING_10),
                        child: Column(
                          children: [
                            CustomTextField(hintText: 'Address '),
                            CustomTextField(
                              hintText: 'Address 2',
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    hintText: 'Zip Code',
                                  ),
                                ),
                                SizedBox(
                                  width: Sizes.WIDTH_50,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    hintText: 'City',
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    hintText: 'State',
                                  ),
                                ),
                                SizedBox(
                                  width: Sizes.WIDTH_40,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: CustomTextField(
                                    hintText: 'Country/Region Code',
                                    suffixIcon: Icon(Icons.arrow_drop_down),
                                  ),
                                )
                              ],
                            ),
                            CustomTextField(hintText: 'Phone Number '),
                            CustomTextField(
                              hintText: 'Email',
                            ),
                            CustomTextField(
                              hintText: 'Home Page',
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(
                        height: Sizes.HEIGHT_10,
                      ),
              ),
              AddCustomerTile(
                onTap: () {
                  controller.toggleInvoicing();
                },
                title: 'INVOICING',
                icon: Obx(
                  () => Icon(
                      controller.invoicingPressed.value
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      color: Colors.white,
                      size: Sizes.ICON_SIZE_36),
                ),
              ),
              Obx(
                () => controller.invoicingPressed.value
                    ? Padding(
                        padding: const EdgeInsets.only(
                            top: Sizes.PADDING_8,
                            left: Sizes.PADDING_14,
                            right: Sizes.PADDING_14,
                            bottom: Sizes.PADDING_30),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Tax Liable',
                                          style: context.titleSmall.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff939598),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: Sizes.PADDING_26),
                                        child: Expanded(
                                          flex: 1,
                                          child: Transform.scale(
                                            scale: 1.1,
                                            child: Switch(
                                              trackOutlineWidth:
                                                  const WidgetStatePropertyAll(
                                                      200),
                                              inactiveTrackColor:
                                                  const Color(0xff979797),
                                              activeTrackColor:
                                                  const Color(0xff13C39C),
                                              thumbColor:
                                                  const WidgetStatePropertyAll(
                                                      Colors.white),
                                              value: controller
                                                  .taxButtonPressed.value,
                                              onChanged: (value) {
                                                controller.taxButtonPressed
                                                    .value = value;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    hintText: 'Tax Area Code',
                                    suffixIcon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xff7C7A7A),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const CustomTextField(
                              hintText: 'Gen bus posting group',
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                color: Color(0xff7C7A7A),
                              ),
                            ),
                            const CustomTextField(
                              hintText: 'Customer Posting Group',
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                color: Color(0xff7C7A7A),
                              ),
                            ),
                            const CustomTextField(
                              hintText: 'Customer Price Group',
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                color: Color(0xff7C7A7A),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(
                        height: Sizes.HEIGHT_10,
                      ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: Sizes.PADDING_40),
              //   child:
              //       Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              //     CustomElevatedButton(
              //       onPressed: () {
              //         Get.back();
              //       },
              //       title: AppStrings.CANCEL,
              //       minWidht: Sizes.WIDTH_90,
              //       minHeight: Sizes.HEIGHT_30,
              //       backgroundColor: LightTheme.buttonBackgroundColor2,
              //       borderRadiusCircular: BorderRadius.circular(Sizes.RADIUS_6),
              //     ),
              //     const SizedBox(
              //       width: Sizes.WIDTH_26,
              //     ),
              //     CustomElevatedButton(
              //       onPressed: () {},
              //       title: AppStrings.SAVE,
              //       minWidht: Sizes.WIDTH_90,
              //       minHeight: Sizes.HEIGHT_30,
              //       backgroundColor: LightTheme.buttonBackgroundColor2,
              //       borderRadiusCircular: BorderRadius.circular(Sizes.RADIUS_6),
              //     )
              //   ]),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
