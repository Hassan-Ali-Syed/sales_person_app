import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/views/add_ship_to_address/controller/add_ship_to_address_controller.dart';
import 'package:sales_person_app/views/customer_visit/controllers/customer_visit_controller.dart';
import 'package:sales_person_app/widgets/custom_appbar.dart';
import 'package:sales_person_app/widgets/custom_elevated_button.dart';
import 'package:sales_person_app/widgets/custom_textfield.dart';

class AddShipToAddressScreen extends GetView<AddShipToAddressController> {
  static const String routeName = '/add_ship_to_address_screen';
  AddShipToAddressScreen({super.key});
  final CustomerVisitController customerVisitController =
      Get.find<CustomerVisitController>();
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
                hinttext: 'Company Name',
                controller: customerVisitController.customerTextFieldController,
              ),
              const CustomTextField(hinttext: 'Address'),
              const CustomTextField(hinttext: 'Address 2'),
              const CustomTextField(hinttext: 'Zip Code'),
              const CustomTextField(hinttext: 'City'),
              const CustomTextField(hinttext: 'State'),
              CustomTextField(
                hinttext: 'Country/Region Code',
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    size: Sizes.WIDTH_30,
                    color: Color(0xff7C7A7A),
                  ),
                ),
              ),
              const CustomTextField(hinttext: 'Contact'),
              const CustomTextField(hinttext: 'Phone Number'),
              const CustomTextField(hinttext: 'Email'),
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
                    onPressed: () {},
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
