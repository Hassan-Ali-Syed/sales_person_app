import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/views/main_page/controllers/main_page_controller.dart';
import 'package:sales_person_app/views/main_page/views/customer_page_screen.dart';

class HomePageScreen extends GetView<MainPageController> {
  const HomePageScreen({super.key});
  static const String routeName = '/home_page_screen';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: Sizes.PADDING_260, bottom: Sizes.HEIGHT_20),
            child: ListTile(
              minTileHeight: Sizes.HEIGHT_60,
              tileColor: LightTheme.appBarBackgroundColor,
              title: Text(
                'Meetings',
                style: context.bodyLarge.copyWith(
                  color: const Color(0xff58595B),
                ),
              ),
              trailing: const Icon(Icons.add_circle),
            ),
          ),
          Center(
            child: Text(
              'No Meetings For this day',
              style: context.bodyMedium.copyWith(
                color: const Color(0xff58595B),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: Sizes.PADDING_20, bottom: Sizes.HEIGHT_20),
            child: ListTile(
              minTileHeight: Sizes.HEIGHT_60,
              tileColor: LightTheme.appBarBackgroundColor,
              title: Text(
                'Customer Visit',
                style: context.bodyLarge.copyWith(
                  color: const Color(0xff58595B),
                ),
              ),
              trailing: GestureDetector(
                onTap: () {
                  controller.selectedIndex.value = 1;
                },
                child: const Icon(Icons.add_circle),
              ),
            ),
          ),
          Center(
            child: Text(
              'No Visit for this day',
              style: context.bodyMedium.copyWith(
                color: const Color(0xff58595B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
