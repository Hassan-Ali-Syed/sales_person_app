import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/routes/app_routes.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/views/main_page/controllers/main_page_controller.dart';

class HomePageScreen extends GetView<MainPageController> {
  HomePageScreen({super.key});
  static const String routeName = '/home_page_screen';
  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      width: 1.4,
      color: Color(0xff939598),
    ),
    borderRadius: BorderRadius.circular(Sizes.RADIUS_6),
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: Sizes.PADDING_24,
                  left: Sizes.PADDING_18,
                  right: Sizes.PADDING_14,
                  bottom: Sizes.PADDING_12),
              height: Sizes.HEIGHT_120,
              width: double.infinity,
              color: LightTheme.appBarBackgroundColor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: Sizes.PADDING_24),
                        child: Text(
                          'Home',
                          style: TextStyle(
                            fontSize: Sizes.TEXT_SIZE_20,
                            fontWeight: FontWeight.normal,
                            color: LightTheme.appBarTextColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.menu,
                          color: Color(0xff7C7A7A),
                          size: Sizes.ICON_SIZE_26,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: Sizes.PADDING_10),
                    child: Row(
                      children: [
                        SizedBox(
                          height: Sizes.HEIGHT_44,
                          width: Sizes.WIDTH_250,
                          child: TextField(
                            textAlign: TextAlign.justify,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Color(0xff7C7A7A),
                                  size: Sizes.ICON_SIZE_26,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: outlineInputBorder,
                                focusedBorder: outlineInputBorder),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.PADDING_8),
                          child: Text(
                            'Filtered By\nSearch',
                            style: context.bodySmall.copyWith(
                              fontSize: Sizes.TEXT_SIZE_14,
                              color: const Color(0xff7C7A7A),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.filter_alt_outlined,
                            color: Color(0xff7C7A7A),
                            size: Sizes.ICON_SIZE_26,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: Sizes.PADDING_100, bottom: Sizes.HEIGHT_20),
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
                    Get.toNamed(AppRoutes.CUSTOMER_VISIT);
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
      ),
    );
  }
}
