import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sales_person_app/views/main_page/controllers/main_page_controller.dart';

class HomePageScreen extends GetView<MainPageController> {
  const HomePageScreen({super.key});
  static const String routeName = '/home_page_screen';

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Text("data"),
        ],
      ),
    );
  }
}
