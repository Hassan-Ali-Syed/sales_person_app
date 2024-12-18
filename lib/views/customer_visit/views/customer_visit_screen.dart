import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/routes/app_routes.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/views/customer_visit/components/custom_header_row.dart';
import 'package:sales_person_app/views/customer_visit/components/custom_row_data_cells.dart';
import 'package:sales_person_app/views/customer_visit/controllers/customer_visit_controller.dart';
import 'package:sales_person_app/views/main_page/controllers/main_page_controller.dart';
import 'package:sales_person_app/views/main_page/models/tli_sales_line.dart';
import 'package:sales_person_app/widgets/custom_appbar.dart';
import 'package:sales_person_app/widgets/custom_drawer.dart';
import 'package:sales_person_app/widgets/custom_elevated_button.dart';

class CustomerVisitScreen extends GetView<CustomerVisitController> {
  static const String routeName = '/customer_visit_screen';
  CustomerVisitScreen({super.key});
  final mainPageController = Get.find<MainPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.customerVisitScaffoldKey,
      appBar: customAppBar(
        title: Text(
          AppStrings.CUSTOMER_VISIT,
          style: GoogleFonts.nunitoSans(
              textStyle: const TextStyle(
            fontSize: Sizes.TEXT_SIZE_20,
            fontWeight: FontWeight.bold,
            color: LightTheme.appBarTextColor,
          )),
        ),
        customLeading: false,
        context: context,
        automaticallyImplyLeading: true,
        isDrawerIcon: true,
        onTap: () =>
            controller.customerVisitScaffoldKey.currentState!.openEndDrawer(),
      ),
      endDrawer: CustomDrawer(
        logOutOnTap: () {
          mainPageController.userLogOut();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.PADDING_22,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First TextField Customer's Name- Always Visible
                Obx(
                  () => !controller.isCustomerExpanded.value
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
                                controller.isCustomerExpanded.value = true,
                            controller: controller.customerTextFieldController,
                            textAlign: TextAlign.left,
                            onSubmitted: (value) {
                              controller.isAddressFieldVisible.value = true;
                            },
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
                                AppStrings.CUSTOMER,
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
                                  controller.isCustomerExpanded.value = true;
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: TextField(
                                      style: context.bodySmall.copyWith(
                                          fontSize: Sizes.TEXT_SIZE_16,
                                          color: const Color(0xff58595B)),
                                      autofocus: true,
                                      onChanged: (value) {
                                        controller.filterCustomerList();
                                      },
                                      controller: controller
                                          .customerTextFieldController,
                                      onTapOutside: (event) {},
                                      decoration: InputDecoration(
                                        labelText: AppStrings.SEARCH_CUSTOMER,
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xff7C7A7A),
                                          ),
                                        ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
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
                                      controller.isCustomerExpanded.value =
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
                              Expanded(
                                child: Scrollbar(
                                  trackVisibility: true,
                                  radius: const Radius.circular(Sizes.RADIUS_6),
                                  interactive: true,
                                  thickness: 12,
                                  thumbVisibility: true,
                                  controller:
                                      controller.customerScrollController,
                                  child: Obx(
                                    () => controller.customerFieldRefresh.value
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : controller.tliCustomers?.value !=
                                                    null &&
                                                controller.tliCustomers!.value
                                                    .isNotEmpty
                                            ? ListView.builder(
                                                controller: controller
                                                    .customerScrollController,
                                                itemCount: controller
                                                    .filteredCustomers.length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    dense: true,
                                                    horizontalTitleGap: 0,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    title: Text(
                                                      controller
                                                          .filteredCustomers[
                                                              index]
                                                          .name!,
                                                      style: context.bodySmall
                                                          .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize:
                                                            Sizes.TEXT_SIZE_16,
                                                        color: const Color(
                                                            0xff58595B),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      controller
                                                              .selectedCustomer =
                                                          controller
                                                                  .filteredCustomers[
                                                              index];
                                                      controller
                                                              .customerTextFieldController
                                                              .text =
                                                          controller
                                                              .filteredCustomers[
                                                                  index]
                                                              .name!;
                                                      controller
                                                          .setCustomerData(
                                                              index);
                                                    },
                                                  );
                                                },
                                              )
                                            : controller.isLoading.value
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Center(
                                                    child: Text(
                                                      AppStrings.NO_CUST_AVAIL,
                                                      style: context.bodySmall
                                                          .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize:
                                                            Sizes.TEXT_SIZE_14,
                                                        color: const Color(
                                                            0xff58595B),
                                                      ),
                                                    ),
                                                  ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: Sizes.PADDING_8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.ADD_NEW_CUSTOMER);
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            AppStrings.ADD_CUSTOMER,
                                            style: context.bodySmall.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: Sizes.TEXT_SIZE_14,
                                              color: const Color(0xff58595B),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.add,
                                            color: Color(0xff58595B),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                ), // Second TextField Bill to Add automatically filled when select customer
                Obx(
                  () => controller.isAddressFieldVisible.value
                      ? SizedBox(
                          child: TextField(
                            style: context.bodySmall.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: Sizes.TEXT_SIZE_16,
                              color: const Color(0xff58595B),
                            ),
                            controller: controller.addressController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: AppStrings.ADDRESS,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff7C7A7A),
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff7C7A7A),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                // third TextField of Ship to Address we have to fill
                Obx(
                  () => controller.isShipToAddFieldVisible.value
                      ? !controller.isShipToAddExpanded.value
                          ? Padding(
                              padding: const EdgeInsets.only(
                                top: Sizes.PADDING_8,
                              ),
                              child: TextField(
                                style: context.bodySmall.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Sizes.TEXT_SIZE_16,
                                  color: const Color(0xff58595B),
                                ),
                                controller: controller.shipToAddController,
                                readOnly: true,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
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
                                  labelText: AppStrings.SHIP_TO,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.isShipToAddExpanded.value =
                                          true;
                                    },
                                    icon: const Icon(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          style: context.bodySmall.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: Sizes.TEXT_SIZE_16,
                                            color: const Color(0xff58595B),
                                          ),
                                          onChanged: (value) {
                                            controller
                                                .filterShipToAddressList();
                                          },
                                          controller: controller
                                              .searchShipToAddController,
                                          decoration: InputDecoration(
                                            labelText:
                                                AppStrings.SEARCH_SHIP_TO_ADD,
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xff7C7A7A),
                                              ),
                                            ),
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xff7C7A7A),
                                              ),
                                            ),
                                            suffixIcon: IconButton(
                                              icon: const Icon(
                                                Icons.search,
                                                color: Color(0xff58595B),
                                              ),
                                              onPressed: () {
                                                controller.isShipToAddSearch
                                                    .value = false;
                                                controller.shipToAddController
                                                    .clear();
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.isShipToAddExpanded.value =
                                              false;
                                        },
                                        child: const Icon(
                                          Icons.arrow_drop_up,
                                          size: Sizes.ICON_SIZE_26,
                                          color: Color(0xff7C7A7A),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: Sizes.HEIGHT_10,
                                  ),
                                  controller.filteredShipToAddress.isNotEmpty
                                      ? Expanded(
                                          child: Scrollbar(
                                            trackVisibility: true,
                                            interactive: true,
                                            thickness: 12,
                                            radius: const Radius.circular(
                                                Sizes.RADIUS_6),
                                            thumbVisibility: true,
                                            controller: controller
                                                .shipToAddScrollController,
                                            child: Obx(
                                              () => controller
                                                      .shipToAddressFieldRefresh
                                                      .value
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    )
                                                  : ListView.builder(
                                                      controller: controller
                                                          .shipToAddScrollController,
                                                      itemCount: controller
                                                          .filteredShipToAddress
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        String filteredData =
                                                            '${controller.filteredShipToAddress[index].address} ${controller.filteredShipToAddress[index].address2}';
                                                        return ListTile(
                                                          visualDensity:
                                                              VisualDensity
                                                                  .compact,
                                                          dense: true,
                                                          horizontalTitleGap: 0,
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          title: Text(
                                                            filteredData,
                                                            style: context
                                                                .bodySmall
                                                                .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: Sizes
                                                                  .TEXT_SIZE_16,
                                                              color: const Color(
                                                                  0xff58595B),
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            controller
                                                                .setSelectedShipToAdd(
                                                                    index);
                                                            controller
                                                                    .shipToAddController
                                                                    .text =
                                                                filteredData;
                                                            controller
                                                                    .searchShipToAddController
                                                                    .text =
                                                                filteredData;
                                                            controller
                                                                .isShipToAddExpanded
                                                                .value = false;
                                                          },
                                                        );
                                                      },
                                                    ),
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          child: Center(
                                            child: Text(
                                              AppStrings
                                                  .SHIP_TO_ADD_NOT_AVAILABLE,
                                              style: context.bodySmall.copyWith(
                                                fontWeight: FontWeight.w400,
                                                fontSize: Sizes.TEXT_SIZE_14,
                                                color: const Color(0xff58595B),
                                              ),
                                            ),
                                          ),
                                        ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.ADD_SHIP_TO_ADDRESS,
                                          arguments: 'customerVisit');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: Sizes.PADDING_8,
                                          bottom: Sizes.PADDING_8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            AppStrings.ADD_NEW_SHIP_TO_ADD,
                                            style: context.bodySmall.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: Sizes.TEXT_SIZE_14,
                                              color: const Color(0xff58595B),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.add,
                                            color: Color(0xff58595B),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                      : const SizedBox.shrink(),
                ),

                // Fourth  TextField of contacts
                Obx(
                  () => controller.isAttendeeFieldVisible.value
                      ? !controller.isAttendeeExpanded.value
                          ? Padding(
                              padding: const EdgeInsets.only(
                                top: Sizes.PADDING_8,
                              ),
                              child: TextField(
                                style: context.bodySmall.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Sizes.TEXT_SIZE_16,
                                  color: const Color(0xff58595B),
                                ),
                                controller: controller.attendeeController,
                                readOnly: true,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  labelText: AppStrings.ATTENDEES,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.isAttendeeExpanded.value =
                                          true;
                                    },
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      size: Sizes.WIDTH_30,
                                      color: Color(0xff7C7A7A),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Sizes.WIDTH_200,
                                        child: TextField(
                                          style: context.bodySmall.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: Sizes.TEXT_SIZE_16,
                                            color: const Color(0xff58595B),
                                          ),
                                          onChanged: (value) {
                                            controller.filterAttendeeList();
                                          },
                                          controller: controller
                                              .searchAttendeeController,
                                          decoration: InputDecoration(
                                            labelText:
                                                AppStrings.SEARCH_ATTENDEE,
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xff7C7A7A),
                                              ),
                                            ),
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xff7C7A7A),
                                              ),
                                            ),
                                            suffixIcon: IconButton(
                                                icon: const Icon(Icons.search),
                                                onPressed: () {}),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.isAttendeeExpanded.value =
                                              false;
                                        },
                                        child: const Icon(
                                          Icons.arrow_drop_up,
                                          size: Sizes.ICON_SIZE_26,
                                          color: Color(0xff7C7A7A),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: Sizes.HEIGHT_10,
                                  ),
                                  controller.filteredAttendees.isNotEmpty
                                      ? Expanded(
                                          child: Scrollbar(
                                            trackVisibility: true,
                                            radius: const Radius.circular(
                                                Sizes.RADIUS_6),
                                            interactive: true,
                                            thickness: 12,
                                            thumbVisibility: true,
                                            controller: controller
                                                .attendeeScrollController,
                                            child: Obx(
                                              () => controller
                                                      .attendeeFieldRefresh
                                                      .value
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    )
                                                  : ListView.builder(
                                                      controller: controller
                                                          .attendeeScrollController,
                                                      itemCount: controller
                                                          .filteredAttendees
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final contactNo =
                                                            controller
                                                                .filteredAttendees[
                                                                    index]
                                                                .no;

                                                        final filteredData =
                                                            controller
                                                                .filteredAttendees[
                                                                    index]
                                                                .name;
                                                        return ListTile(
                                                          visualDensity:
                                                              VisualDensity
                                                                  .compact,
                                                          dense: true,
                                                          horizontalTitleGap: 6,
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          leading: Obx(
                                                            () => Checkbox(
                                                              visualDensity:
                                                                  VisualDensity
                                                                      .compact,
                                                              value: controller
                                                                      .checkBoxStatesMap[
                                                                  contactNo],
                                                              onChanged:
                                                                  (value) {
                                                                controller
                                                                    .onCheckboxChanged(
                                                                        value,
                                                                        contactNo!);
                                                              },
                                                            ),
                                                          ),
                                                          title: Text(
                                                            filteredData!,
                                                            style: context
                                                                .bodySmall
                                                                .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: Sizes
                                                                  .TEXT_SIZE_16,
                                                              color: const Color(
                                                                  0xff58595B),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          child: Center(
                                            child: Text(
                                              AppStrings.NO_CONTACTS_AVAILABLE,
                                              style: context.bodySmall.copyWith(
                                                fontWeight: FontWeight.w400,
                                                fontSize: Sizes.TEXT_SIZE_14,
                                                color: const Color(0xff58595B),
                                              ),
                                            ),
                                          ),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                                AppRoutes.ADD_ATTENDEE_PAGE);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: Sizes.PADDING_8),
                                            child: Row(
                                              children: [
                                                Text(
                                                  AppStrings.ADD_ATTENDEE,
                                                  style: context.bodySmall
                                                      .copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        Sizes.TEXT_SIZE_14,
                                                    color:
                                                        const Color(0xff58595B),
                                                  ),
                                                ),
                                                const Icon(Icons.add),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                      : const SizedBox.shrink(),
                ),

                const SizedBox(
                  height: Sizes.HEIGHT_20,
                ),

                Obx(
                  () => controller.selectedAttendees.isNotEmpty
                      ? Wrap(
                          spacing: 2,
                          runSpacing: 5,
                          children: List.generate(
                              (controller.selectedAttendees.length), (index) {
                            log("******contactNo *********${controller.contactNo.value}************88");
                            return GestureDetector(
                              onTap: () {
                                controller.contactNo.value = controller
                                    .selectedAttendees[index]['contactNo'];

                                controller.userItemListReferesh.value = true;
                                controller.itemQntyController.clear();
                                controller.selectedAttendee.value =
                                    controller.selectedAttendees[index]['name'];
                                controller.attendeeSelectedIndex.value = index;

                                controller.itemIndex.value = -1;
                                // log(' Map: ${controller.selectedAttendees[controller.attendeeSelectedIndex.value]['tliSalesLine'][0].toJson()}');
                                controller.userItemListReferesh.value = false;
                              },
                              child: Obx(
                                () => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Sizes.PADDING_8,
                                      vertical: Sizes.PADDING_10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: LightTheme.borderColor),
                                    color: controller
                                                .attendeeSelectedIndex.value ==
                                            index
                                        ? const Color(0xffE9E8E7)
                                        : Colors.white,
                                  ),
                                  child: Text(
                                    controller.selectedAttendees[index]['name'],
                                    style: context.bodySmall.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: Sizes.TEXT_SIZE_14,
                                      color: const Color(0xff58595B),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        )
                      : const SizedBox(),
                ),

                const SizedBox(
                  height: Sizes.HEIGHT_14,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => controller.selectedAttendees.isNotEmpty
                          ? const CustomHeaderRow()
                          : const SizedBox(),
                    ),
                    Obx(() {
                      return (controller.selectedAttendees.isEmpty ||
                                  controller.selectedAttendees[controller
                                          .attendeeSelectedIndex
                                          .value]['tliSalesLine'] ==
                                      null) &&
                              (controller.userItemListReferesh.value ||
                                  controller.isLoading.value)
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ],
                            )
                          : controller.selectedAttendees.isEmpty ||
                                  controller.selectedAttendees[controller
                                          .attendeeSelectedIndex
                                          .value]['tliSalesLine'] ==
                                      null ||
                                  controller
                                      .selectedAttendees[controller
                                          .attendeeSelectedIndex
                                          .value]['tliSalesLine']
                                      .isEmpty
                              ? const SizedBox()
                              : SizedBox(
                                  height: Sizes.HEIGHT_200,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: controller
                                        .selectedAttendees[controller
                                            .attendeeSelectedIndex
                                            .value]['tliSalesLine']
                                        .length,
                                    itemBuilder: (context, index) {
                                      TliSalesLineElement salesLineItem =
                                          controller.selectedAttendees[
                                                  controller
                                                      .attendeeSelectedIndex
                                                      .value]['tliSalesLine']
                                              [index];

                                      log("***** Description *********${salesLineItem.itemDescription}");
                                      return Obx(
                                        () => CustomRowCells(
                                          onSubmitted: (p0) {
                                            controller.userItemListReferesh
                                                .value = true;
                                            controller.userItemListReferesh
                                                .value = false;
                                          },
                                          rowIndex: index,
                                          selectedIndex:
                                              controller.itemIndex.value,
                                          qtyOnChanged: (p0) {
                                            controller.userItemListReferesh
                                                .value = true;
                                            if (p0.isNotEmpty) {
                                              salesLineItem.quantity =
                                                  num.parse(p0);
                                              // controller
                                              //     .selectedAttendees[controller
                                              //             .attendeeSelectedIndex
                                              //             .value]
                                              //         ['tliSalesLine'][index]
                                              //     .quantity = num.parse(p0);
                                              log(
                                                salesLineItem.quantity
                                                    .toString(),
                                              );
                                            } else {
                                              salesLineItem.quantity = 1;
                                              // controller
                                              //     .selectedAttendees[controller
                                              //             .attendeeSelectedIndex
                                              //             .value]
                                              //         ['tliSalesLine'][index]
                                              //     .quantity = 1;
                                            }

                                            controller.userItemListReferesh
                                                .value = false;
                                            log('===Attendee Index ON CHANGED  ${controller.attendeeSelectedIndex.value}============');
                                          },
                                          qtyOnTap: () {
                                            controller.userItemListReferesh
                                                .value = true;
                                            controller.itemQntyController
                                                .clear();
                                            controller.itemQntyController.text =
                                                salesLineItem.quantity
                                                    .toString();
                                            controller.isQtyPressed.value =
                                                true;
                                            controller.itemIndex.value = index;
                                            controller.userItemListReferesh
                                                .value = false;
                                            log('===Attendee Index ON TAP  ${controller.attendeeSelectedIndex.value}============');
                                          },
                                          isQtyPressed:
                                              controller.isQtyPressed.value,
                                          qntyController:
                                              controller.itemQntyController,
                                          qty:
                                              salesLineItem.quantity.toString(),
                                          itemName:
                                              salesLineItem.itemDescription,
                                          price: salesLineItem.unitPrice
                                              .toString(),
                                          notes:
                                              controller.itemsListRefresh.value
                                                  ? ''
                                                  : salesLineItem.comment
                                                      .toString(),
                                          commentDialogBoxOnPressed: () {
                                            controller.commentController.text =
                                                salesLineItem.comment
                                                            .toString() ==
                                                        'null'
                                                    ? ''
                                                    : salesLineItem.comment
                                                        .toString();

                                            controller.itemIndex.value = index;
                                            controller.showCommentDialog(
                                                context, onPressed: () {
                                              controller.splitComment(
                                                  controller
                                                      .commentController.text,
                                                  80);
                                              controller.itemsListRefresh
                                                  .value = true;
                                              salesLineItem.comment = controller
                                                  .commentController.text
                                                  .toString();

                                              controller
                                                      .selectedAttendees[
                                                          controller
                                                              .attendeeSelectedIndex
                                                              .value][
                                                          'tliSalesLine'][index]
                                                      .comment =
                                                  controller
                                                      .commentController.text
                                                      .toString();

                                              log(
                                                controller.selectedAttendees[
                                                        controller
                                                            .attendeeSelectedIndex
                                                            .value]
                                                        ['tliSalesLine'][index]
                                                    .toJson()
                                                    .toString(),
                                              );
                                              controller.itemsListRefresh
                                                  .value = false;

                                              Get.back();
                                            },
                                                controller: controller
                                                    .commentController);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                );
                    }),
                  ],
                ),

                const SizedBox(
                  height: Sizes.HEIGHT_20,
                ),
                Obx(
                  () => controller.selectedAttendees.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              CustomElevatedButton(
                                onPressed:
                                    !controller.isSalesOrderCreating.value
                                        ? () async {
                                            await controller
                                                .createSalesOrdersOfSelectedAttendees();
                                          }
                                        : null,
                                title: AppStrings.FINISH,
                                minWidht: Sizes.WIDTH_90,
                                minHeight: Sizes.HEIGHT_36,
                                backgroundColor:
                                    LightTheme.buttonBackgroundColor2,
                                borderRadiusCircular: BorderRadius.circular(
                                  Sizes.RADIUS_6,
                                ),
                                style: context.bodyMedium.copyWith(
                                    color: LightTheme.buttonTextColor,
                                    fontSize: Sizes.TEXT_SIZE_16,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                width: Sizes.WIDTH_26,
                              ),
                              CustomElevatedButton(
                                onPressed: () {
                                  controller.itemsListRefresh.value = true;
                                  controller.scanBarcodeNormal();
                                  // controller
                                  //     .getSingleItemFromGraphQL('P10012-020');
                                },
                                title: AppStrings.SCAN,
                                minWidht: Sizes.WIDTH_90,
                                minHeight: Sizes.HEIGHT_36,
                                backgroundColor:
                                    LightTheme.buttonBackgroundColor2,
                                borderRadiusCircular: BorderRadius.circular(
                                  Sizes.RADIUS_6,
                                ),
                                style: context.bodyMedium.copyWith(
                                    color: LightTheme.buttonTextColor,
                                    fontSize: Sizes.TEXT_SIZE_16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ])
                      : const SizedBox(),
                )
              ],
            )),
      ),
    );
  }
}
