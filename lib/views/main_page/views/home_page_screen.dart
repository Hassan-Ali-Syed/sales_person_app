import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/preferences/preferences.dart';
import 'package:sales_person_app/routes/app_routes.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/views/main_page/components/calender_date_widget.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.PADDING_22),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.black45,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
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
                                const Text(
                                  'Home',
                                  style: TextStyle(
                                    fontSize: Sizes.TEXT_SIZE_20,
                                    fontWeight: FontWeight.normal,
                                    color: LightTheme.appBarTextColor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.mainPageScaffoldKey.currentState!
                                        .openEndDrawer();
                                  },
                                  child: const Icon(
                                    Icons.menu,
                                    color: Color(0xff7C7A7A),
                                    size: Sizes.ICON_SIZE_26,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: Sizes.PADDING_10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Sizes.HEIGHT_42,
                                    width: Sizes.WIDTH_250,
                                    child: TextField(
                                      style: context.titleMedium.copyWith(
                                        color: const Color(0xff58595B),
                                      ),
                                      textAlign: TextAlign.start,
                                      textAlignVertical: TextAlignVertical.top,
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
                                      'Filtered by\nSearch',
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
                            top: Sizes.PADDING_26,
                            left: Sizes.PADDING_24,
                            bottom: Sizes.PADDING_18),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: Sizes.HEIGHT_80,
                              width: Sizes.WIDTH_84,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Sizes.RADIUS_6),
                                color: const Color(0xffE9E8E7),
                              ),
                              child: Image.asset(
                                AppAssets.getPNGIcon(AppAssets.ACCOUNT_CIRCLE),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: Sizes.PADDING_10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: Sizes.PADDING_16,
                                        bottom: Sizes.PADDING_2),
                                    child: Text(
                                      controller.capitalizeFirstLetter(
                                          Preferences().getUser().name),
                                      style: context.bodyMedium.copyWith(
                                        fontSize: Sizes.TEXT_SIZE_18,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xff58595B),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    controller.currentDate(),
                                    style: context.bodyMedium.copyWith(
                                      fontSize: Sizes.TEXT_SIZE_16,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff58595B),
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
                            top: Sizes.PADDING_2,
                            right: Sizes.PADDING_26,
                            bottom: Sizes.PADDING_12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  left: Sizes.PADDING_12,
                                  right: Sizes.PADDING_23),
                              height: Sizes.HEIGHT_36,
                              width: Sizes.WIDTH_96,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.3), // Shadow color
                                    spreadRadius:
                                        0.6, // How wide the shadow spreads
                                    blurRadius:
                                        2, // How blurry the shadow looks
                                    offset: const Offset(0,
                                        3), // Offset (x,y) to position the shadow
                                  ),
                                ],
                                color: const Color(0xffE9E8E7),
                                borderRadius:
                                    BorderRadius.circular(Sizes.RADIUS_6),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    image: AssetImage(
                                      AppAssets.getPNGIcon(
                                          AppAssets.CALENDER_ICON),
                                    ),
                                  ),
                                  Text(
                                    'Day',
                                    style: GoogleFonts.inter(
                                      fontSize: Sizes.TEXT_SIZE_16,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff58595B),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          bottom: Sizes.PADDING_20,
                          left: Sizes.PADDING_20,
                        ),
                        child: Row(
                          children: [
                            CalenderDateWidget(
                              day: 'Sun',
                              date: '15',
                            ),
                            CalenderDateWidget(
                              day: 'Mon',
                              date: '16',
                            ),
                            CalenderDateWidget(
                              day: 'Tue',
                              date: '17',
                            ),
                            CalenderDateWidget(
                              day: 'Wed',
                              date: '18',
                            ),
                            CalenderDateWidget(
                              day: 'Thu',
                              date: '19',
                            ),
                            CalenderDateWidget(
                              day: 'Fri',
                              date: '20',
                            ),
                            CalenderDateWidget(
                              rightMargin: Sizes.MARGIN_0,
                              day: 'Sat',
                              date: '21',
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        minTileHeight: Sizes.HEIGHT_60,
                        tileColor: LightTheme.appBarBackgroundColor,
                        title: Text(
                          'Meetings',
                          style: context.bodySmall.copyWith(
                            fontSize: Sizes.TEXT_SIZE_18,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff58595B),
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.add_circle),
                        ),
                      ),
                      SizedBox(
                        height: Sizes.HEIGHT_100,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: Sizes.PADDING_22,
                                  top: Sizes.PADDING_12),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Company Name',
                                        style: context.bodySmall.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: Sizes.TEXT_SIZE_16,
                                          color: const Color(0xff58595B),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: Sizes.PADDING_20,
                                            left: Sizes.PADDING_28),
                                        child: Text(
                                          '8:00 PM',
                                          style: context.bodySmall.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: Sizes.TEXT_SIZE_16,
                                            color: const Color(0xff58595B),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Title',
                                        style: context.bodySmall.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: Sizes.TEXT_SIZE_16,
                                          color: const Color(0xff58595B),
                                        ),
                                      )
                                    ],
                                  ),
                                  const Divider(
                                    endIndent: 30,
                                    thickness: 1,
                                    color: Color(0xff939598),
                                    height: Sizes.HEIGHT_16,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // Center(
                      //   child: Text(
                      //     'No Meetings For this day',
                      //     style: context.bodyLarge.copyWith(
                      //       fontSize: Sizes.TEXT_SIZE_16,
                      //       fontWeight: FontWeight.w500,
                      //       color: const Color(0xff58595B),
                      //     ),
                      //   ),
                      // ),
                      ListTile(
                        minTileHeight: Sizes.HEIGHT_60,
                        tileColor: LightTheme.appBarBackgroundColor,
                        title: Text(
                          'Customer Visit',
                          style: context.bodySmall.copyWith(
                            fontSize: Sizes.TEXT_SIZE_18,
                            fontWeight: FontWeight.w600,
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
                      SizedBox(
                        height: Sizes.HEIGHT_100,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: Sizes.PADDING_22,
                                  top: Sizes.PADDING_12,
                                  right: Sizes.PADDING_26),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Company Name',
                                        style: context.bodySmall.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: Sizes.TEXT_SIZE_16,
                                          color: const Color(0xff58595B),
                                        ),
                                      ),
                                      Text(
                                        'Number of Order',
                                        style: context.bodySmall.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: Sizes.TEXT_SIZE_16,
                                          color: const Color(0xff58595B),
                                        ),
                                      )
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Color(0xff939598),
                                    height: Sizes.HEIGHT_16,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // Center(
                      //   child: Text(
                      //     'No Visit for this day',
                      //     style: context.bodySmall.copyWith(
                      //       fontSize: Sizes.TEXT_SIZE_16,
                      //       fontWeight: FontWeight.w500,
                      //       color: const Color(0xff58595B),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
