import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/views/main_page/controllers/main_page_controller.dart';

class CustomerPageScreen extends GetView<MainPageController> {
  static const String routeName = '/customer_page_screen';
  const CustomerPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.maxFinite,
        ),
        Text(AppStrings.COMING_SOON),
      ],
    );
  }
}
