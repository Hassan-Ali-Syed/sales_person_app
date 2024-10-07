import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/views/main_page/components/contact_page_textfield.dart';

import 'package:sales_person_app/views/main_page/controllers/main_page_controller.dart';
import 'package:sales_person_app/widgets/custom_elevated_button.dart';

class ContactPageScreen extends GetView<MainPageController> {
  const ContactPageScreen({super.key});
  static const String routeName = '/contact_page_screen';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Sizes.PADDING_22, vertical: Sizes.PADDING_28),
        child: Column(
          children: [
            ContactPageTextField(
              hintText: 'Attendee Full Name',
              controller: TextEditingController(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.PADDING_10),
              child: ContactPageTextField(
                isSuffixIcon: true,
                hintText: 'Customer',
                controller: TextEditingController(),
              ),
            ),
            ContactPageTextField(
              hintText: 'Email',
              controller: TextEditingController(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.PADDING_10),
              child: ContactPageTextField(
                hintText: 'Phone Number',
                controller: TextEditingController(),
              ),
            ),
            ContactPageTextField(
              hintText: 'Address',
              controller: TextEditingController(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: Sizes.PADDING_260),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomElevatedButton(
                  onPressed: () {},
                  title: 'Cancel',
                  minWidht: Sizes.WIDTH_100,
                  minHeight: Sizes.HEIGHT_30,
                  backgroundColor: LightTheme.buttonBackgroundColor2,
                  borderRadiusCircular: BorderRadius.circular(Sizes.RADIUS_6),
                ),
                const SizedBox(
                  width: Sizes.WIDTH_20,
                ),
                CustomElevatedButton(
                  onPressed: () {},
                  title: 'Save',
                  minWidht: Sizes.WIDTH_100,
                  minHeight: Sizes.HEIGHT_30,
                  backgroundColor: LightTheme.buttonBackgroundColor2,
                  borderRadiusCircular: BorderRadius.circular(Sizes.RADIUS_6),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
