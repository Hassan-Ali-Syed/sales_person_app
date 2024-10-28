import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/views/add_ship_to_address/controller/add_ship_to_address_controller.dart';
import 'package:sales_person_app/widgets/custom_appbar.dart';
import 'package:sales_person_app/widgets/custom_elevated_button.dart';
import 'package:sales_person_app/widgets/custom_textfield.dart';

class AddShipToAddressScreen extends GetView<AddShipToAddressController> {
  static const String routeName = '/add_ship_to_address_screen';
  const AddShipToAddressScreen({super.key});

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
              CustomTextField(
                readOnly: true,
                hintText: 'Company Name',
                controller: controller.companyNameController,
              ),
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
              CustomTextField(
                hintText: 'Country/Region Code',
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    size: Sizes.WIDTH_30,
                    color: Color(0xff7C7A7A),
                  ),
                ),
              ),
              CustomTextField(
                hintText: 'Contact',
                controller: controller.contactController,
              ),
              CustomTextField(
                hintText: 'Phone Number',
                controller: controller.phoneNumberController,
              ),
              CustomTextField(
                hintText: 'Email',
                controller: controller.emailController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: Sizes.PADDING_40),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CustomElevatedButton(
                    onPressed: () {},
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
                      log("on pressed");
                      // controller.createTliShipToAdd(countryRegionCode: countryRegionCode)
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
