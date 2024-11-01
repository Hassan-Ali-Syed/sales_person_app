import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/views/add_ship_to_address/controller/add_ship_to_address_controller.dart';
import 'package:sales_person_app/widgets/custom_appbar.dart';
import 'package:sales_person_app/widgets/custom_elevated_button.dart';
import 'package:sales_person_app/widgets/custom_textfield.dart';
import 'package:dotted_line/dotted_line.dart';

class AddShipToAddressScreen extends GetView<AddShipToAddressController> {
  static const String routeName = '/add_ship_to_address_screen';
  AddShipToAddressScreen({super.key});
  final String argument = Get.arguments ?? 'Unknown';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: const Text(AppStrings.SHIP_TO_ADD),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.PADDING_22, vertical: Sizes.PADDING_20),
          child: Column(
            children: [
              argument == 'customerVisit'
                  ? CustomTextField(
                      readOnly: true,
                      hintText: 'Company Name',
                      controller: controller.companyNameController,
                    )
                  : const SizedBox(),
              CustomTextField(
                hintText: 'Address',
                controller: controller.addressController,
              ),
              CustomTextField(
                hintText: 'Address 2',
                controller: controller.address2Controller,
              ),
              CustomTextField(
                hintText: 'Zip Code',
                controller: controller.zipCodeController,
              ),
              CustomTextField(
                hintText: 'City',
                controller: controller.cityController,
              ),
              CustomTextField(
                hintText: 'State',
                controller: controller.countyController,
              ),
              Obx(
                () => !controller.isCountryRegionExpanded.value
                    ? Padding(
                        padding: const EdgeInsets.only(
                          top: Sizes.PADDING_6,
                        ),
                        child: TextField(
                          scrollPadding: EdgeInsets.zero,
                          style: context.bodySmall.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: Sizes.TEXT_SIZE_16,
                            color: const Color(0xff58595B),
                          ),
                          onTap: () =>
                              controller.isCountryRegionExpanded.value = true,
                          controller: controller.countryRegionController,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            floatingLabelStyle: context.titleLarge.copyWith(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff939598),
                            ),
                            hintStyle: context.titleSmall.copyWith(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff939598),
                            ),
                            label: Text(
                              AppStrings.COUNTRY_REGION_CODE,
                              style: context.titleSmall.copyWith(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff939598),
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
                            suffixIcon: GestureDetector(
                              onTap: () {
                                controller.isCountryRegionExpanded.value = true;
                              },
                              child: const Icon(
                                Icons.arrow_drop_down,
                                size: Sizes.WIDTH_26,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Sizes.WIDTH_206,
                                  child: TextField(
                                    style: context.bodySmall.copyWith(
                                      fontSize: Sizes.TEXT_SIZE_16,
                                      color: const Color(0xff58595B),
                                    ),
                                    autofocus: true,
                                    onChanged: (value) {
                                      controller.filterCountryRegionCode();
                                    },
                                    controller:
                                        controller.countryRegionController,
                                    onTapOutside: (event) {},
                                    decoration: InputDecoration(
                                      labelText: AppStrings.COUNTRY_REGION_CODE,
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
                                    controller.isCountryRegionExpanded.value =
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
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Code',
                                      style: context.bodySmall.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: Sizes.TEXT_SIZE_12,
                                        color: const Color(0xff58595B),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: Sizes.PADDING_74),
                                      child: Text(
                                        'Name',
                                        style: context.bodySmall.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: Sizes.TEXT_SIZE_12,
                                          color: const Color(0xff58595B),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.only(right: Sizes.PADDING_20),
                                  child: DottedLine(
                                    direction: Axis.horizontal,
                                    dashLength: 3,
                                    lineLength: double.infinity,
                                    dashGapLength: 2,
                                    lineThickness: 1,
                                    dashColor: Color(0xff939598),
                                    dashGapColor: Colors.transparent,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Scrollbar(
                                trackVisibility: true,
                                radius: const Radius.circular(Sizes.RADIUS_6),
                                interactive: true,
                                thickness: 12,
                                thumbVisibility: true,
                                controller:
                                    controller.countryRegionScrollController,
                                child: Obx(() => controller
                                        .countryRegionFieldRefresh.value
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ListView.builder(
                                        controller: controller
                                            .countryRegionScrollController,
                                        itemCount:
                                            controller.filteredCountry.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  controller
                                                          .countryRegionController
                                                          .text =
                                                      controller
                                                          .filteredCountry[
                                                              index]
                                                          .code!;
                                                  controller
                                                      .isCountryRegionExpanded
                                                      .value = false;
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: Sizes.PADDING_2),
                                                  child: SizedBox(
                                                    height: Sizes.HEIGHT_17,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          controller
                                                              .filteredCountry[
                                                                  index]
                                                              .code!,
                                                          style: context
                                                              .bodySmall
                                                              .copyWith(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: Sizes
                                                                .TEXT_SIZE_12,
                                                            color: const Color(
                                                                0xff58595B),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(
                                                              left: Sizes
                                                                  .PADDING_86),
                                                          child: Text(
                                                            controller
                                                                .filteredCountry[
                                                                    index]
                                                                .description!,
                                                            style: context
                                                                .bodySmall
                                                                .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: Sizes
                                                                  .TEXT_SIZE_12,
                                                              color: const Color(
                                                                  0xff58595B),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    right: Sizes.PADDING_20),
                                                child: DottedLine(
                                                  direction: Axis.horizontal,
                                                  dashLength: 3,
                                                  lineLength: double.infinity,
                                                  dashGapLength: 2,
                                                  lineThickness: 1,
                                                  dashColor: Color(0xff939598),
                                                  dashGapColor:
                                                      Colors.transparent,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      )),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              CustomTextField(
                hintText: AppStrings.CONTACT,
                controller: controller.contactController,
              ),
              CustomTextField(
                hintText: AppStrings.PH_NUMBER,
                controller: controller.phoneNumberController,
              ),
              CustomTextField(
                hintText: AppStrings.EMAIL,
                controller: controller.emailController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: Sizes.PADDING_40),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CustomElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    title: AppStrings.CANCEL,
                    minWidht: Sizes.WIDTH_90,
                    minHeight: Sizes.HEIGHT_30,
                    backgroundColor: LightTheme.buttonBackgroundColor2,
                    borderRadiusCircular: BorderRadius.circular(Sizes.RADIUS_6),
                  ),
                  const SizedBox(
                    width: Sizes.WIDTH_26,
                  ),
                  CustomElevatedButton(
                    onPressed: () {
                      controller.shipToAddressFormValidation();
                    },
                    title: AppStrings.SAVE,
                    minWidht: Sizes.WIDTH_90,
                    minHeight: Sizes.HEIGHT_30,
                    backgroundColor: LightTheme.buttonBackgroundColor2,
                    borderRadiusCircular: BorderRadius.circular(Sizes.RADIUS_6),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
