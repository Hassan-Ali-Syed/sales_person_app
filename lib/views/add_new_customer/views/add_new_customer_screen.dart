import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/views/add_new_customer/components/add_customer_tile.dart';
import 'package:sales_person_app/views/add_new_customer/controller/add_new_customer_controller.dart';
import 'package:sales_person_app/widgets/custom_appbar.dart';
import 'package:sales_person_app/widgets/custom_textfield.dart';

class AddNewCustomerScreen extends GetView<AddNewCustomerController> {
  static const String routeName = '/add_new_customer_screen';
  const AddNewCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: const Text(AppStrings.ADD_CUSTOMER),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Sizes.PADDING_22, horizontal: Sizes.PADDING_18),
          child: Column(
            children: [
              AddCustomerTile(
                  onTap: () {
                    controller.toggleGeneral();
                  },
                  title: 'GENERAL',
                  icon: Obx(
                    () => Icon(
                      controller.generalPressed.value
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      color: Colors.white,
                      size: Sizes.ICON_SIZE_36,
                    ),
                  )),
              Obx(
                () => controller.generalPressed.value
                    ? Padding(
                        padding: const EdgeInsets.only(
                            top: Sizes.PADDING_8,
                            left: Sizes.PADDING_14,
                            right: Sizes.PADDING_14,
                            bottom: Sizes.PADDING_10),
                        child: Column(
                          children: [
                            CustomTextField(
                              hintText: 'Name',
                              controller: controller.nameController,
                            ),
                            Obx(
                              () => !controller.isSalesPersonCodeExpanded.value
                                  ? CustomTextField(
                                      controller:
                                          controller.salesPersonCodeController,
                                      hintText: 'Sales Person Code',
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          controller.isSalesPersonCodeExpanded
                                              .value = true;
                                        },
                                        child: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Color(0xff7C7A7A),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: Sizes.HEIGHT_230,
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
                                                width: Sizes.WIDTH_206,
                                                child: TextField(
                                                  style: context.bodySmall
                                                      .copyWith(
                                                    fontSize:
                                                        Sizes.TEXT_SIZE_16,
                                                    color:
                                                        const Color(0xff58595B),
                                                  ),
                                                  autofocus: true,
                                                  onChanged: (value) {},
                                                  controller:
                                                      controller.nameController,
                                                  onTapOutside: (event) {},
                                                  decoration: InputDecoration(
                                                    labelText: AppStrings
                                                        .SALES_PERSON_CODE,
                                                    focusedBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xff7C7A7A),
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xff7C7A7A),
                                                      ),
                                                    ),
                                                    suffixIcon: IconButton(
                                                      icon: const Icon(
                                                        Icons.search,
                                                        color:
                                                            Color(0xff58595B),
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .isSalesPersonCodeExpanded
                                                      .value = false;
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
                                          Obx(
                                            () => controller
                                                    .salesPersonCodeFieldRefresh
                                                    .value
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Code',
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
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: Sizes
                                                                        .PADDING_82),
                                                            child: Text(
                                                              'Name',
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
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: Sizes
                                                                    .PADDING_20,
                                                                top: Sizes
                                                                    .PADDING_8),
                                                        child: DottedLine(
                                                          direction:
                                                              Axis.horizontal,
                                                          dashLength: 3,
                                                          lineLength:
                                                              double.infinity,
                                                          dashGapLength: 2,
                                                          lineThickness: 1,
                                                          dashColor:
                                                              Color(0xff939598),
                                                          dashGapColor: Colors
                                                              .transparent,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                          Expanded(
                                            child: Scrollbar(
                                              trackVisibility: true,
                                              radius: const Radius.circular(
                                                  Sizes.RADIUS_6),
                                              interactive: true,
                                              thickness: 12,
                                              thumbVisibility: true,
                                              controller: controller
                                                  .salesPersonCodeScrollController,
                                              child: ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                controller: controller
                                                    .salesPersonCodeScrollController,
                                                itemCount: 10,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: Sizes
                                                                      .PADDING_8),
                                                          child: SizedBox(
                                                            height:
                                                                Sizes.HEIGHT_17,
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  'code',
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
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left: Sizes
                                                                          .PADDING_86),
                                                                  child: Text(
                                                                    'Name',
                                                                    style: context
                                                                        .bodySmall
                                                                        .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          Sizes
                                                                              .TEXT_SIZE_12,
                                                                      color: const Color(
                                                                          0xff58595B),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets.only(
                                                            right: Sizes
                                                                .PADDING_20),
                                                        child: DottedLine(
                                                          direction:
                                                              Axis.horizontal,
                                                          dashLength: 3,
                                                          lineLength:
                                                              double.infinity,
                                                          dashGapLength: 2,
                                                          lineThickness: 1,
                                                          dashColor:
                                                              Color(0xff939598),
                                                          dashGapColor: Colors
                                                              .transparent,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: Sizes.PADDING_6,
                                                bottom: Sizes.PADDING_2),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Add New',
                                                        style: context.bodySmall
                                                            .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: Sizes
                                                              .TEXT_SIZE_14,
                                                          color: const Color(
                                                              0xff58595B),
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Icons.add,
                                                        color:
                                                            Color(0xff58595B),
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
                            )
                          ],
                        ),
                      )
                    : const SizedBox(
                        height: Sizes.HEIGHT_10,
                      ),
              ),
              AddCustomerTile(
                onTap: () {
                  controller.toggleadressContact();
                },
                title: 'ADDRESS & CONTACT',
                icon: Obx(
                  () => Icon(
                      controller.adressContactPressed.value
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      color: Colors.white,
                      size: Sizes.ICON_SIZE_36),
                ),
              ),
              Obx(
                () => controller.adressContactPressed.value
                    ? Padding(
                        padding: const EdgeInsets.only(
                            top: Sizes.PADDING_8,
                            left: Sizes.PADDING_14,
                            right: Sizes.PADDING_14,
                            bottom: Sizes.PADDING_10),
                        child: Column(
                          children: [
                            CustomTextField(
                              hintText: 'Address ',
                              controller: controller.addressController,
                            ),
                            CustomTextField(
                              hintText: 'Address 2',
                              controller: controller.address2Controller,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    hintText: 'Zip Code',
                                    controller: controller.zipCodeController,
                                  ),
                                ),
                                const SizedBox(
                                  width: Sizes.WIDTH_50,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    hintText: 'City',
                                    controller: controller.cityController,
                                  ),
                                )
                              ],
                            ),
                            Obx(
                              () => !controller.isCountryRegionExpanded.value
                                  ? Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: CustomTextField(
                                            hintText: 'State',
                                            controller:
                                                controller.stateController,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: Sizes.WIDTH_40,
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: CustomTextField(
                                              hintText: 'Country/Region Code',
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .isCountryRegionExpanded
                                                      .value = true;
                                                },
                                                child: const Icon(
                                                    Icons.arrow_drop_down),
                                              ),
                                              controller: controller
                                                  .countryRegionController,
                                            ))
                                      ],
                                    )
                                  : Container(
                                      height: Sizes.HEIGHT_230,
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
                                                width: Sizes.WIDTH_240,
                                                child: TextField(
                                                  style: context.bodySmall
                                                      .copyWith(
                                                    fontSize:
                                                        Sizes.TEXT_SIZE_16,
                                                    color:
                                                        const Color(0xff58595B),
                                                  ),
                                                  autofocus: true,
                                                  onChanged: (value) {},
                                                  controller: controller
                                                      .countryRegionController,
                                                  onTapOutside: (event) {},
                                                  decoration: InputDecoration(
                                                    labelText: AppStrings
                                                        .COUNTRY_REGION_CODE,
                                                    focusedBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xff7C7A7A),
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xff7C7A7A),
                                                      ),
                                                    ),
                                                    suffixIcon: IconButton(
                                                      icon: const Icon(
                                                        Icons.search,
                                                        color:
                                                            Color(0xff58595B),
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .isCountryRegionExpanded
                                                      .value = false;
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
                                          Obx(
                                            () => controller
                                                    .countryRegionFieldRefresh
                                                    .value
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Code',
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
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: Sizes
                                                                        .PADDING_84),
                                                            child: Text(
                                                              'Name',
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
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: Sizes
                                                                    .PADDING_20,
                                                                top: Sizes
                                                                    .PADDING_8),
                                                        child: DottedLine(
                                                          direction:
                                                              Axis.horizontal,
                                                          dashLength: 3,
                                                          lineLength:
                                                              double.infinity,
                                                          dashGapLength: 2,
                                                          lineThickness: 1,
                                                          dashColor:
                                                              Color(0xff939598),
                                                          dashGapColor: Colors
                                                              .transparent,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                          Expanded(
                                            child: Scrollbar(
                                              trackVisibility: true,
                                              radius: const Radius.circular(
                                                  Sizes.RADIUS_6),
                                              interactive: true,
                                              thickness: 12,
                                              thumbVisibility: true,
                                              controller: controller
                                                  .countryRegionScrollController,
                                              child: ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                controller: controller
                                                    .countryRegionScrollController,
                                                itemCount: 5,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          controller
                                                              .isCountryRegionExpanded
                                                              .value = false;
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: Sizes
                                                                      .PADDING_8),
                                                          child: SizedBox(
                                                            height:
                                                                Sizes.HEIGHT_17,
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  'code',
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
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left: Sizes
                                                                          .PADDING_86),
                                                                  child: Text(
                                                                    'Name',
                                                                    style: context.bodySmall.copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        fontSize:
                                                                            Sizes
                                                                                .TEXT_SIZE_12,
                                                                        color: const Color(
                                                                            0xff58595B)),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets.only(
                                                            right: Sizes
                                                                .PADDING_20),
                                                        child: DottedLine(
                                                          direction:
                                                              Axis.horizontal,
                                                          dashLength: 3,
                                                          lineLength:
                                                              double.infinity,
                                                          dashGapLength: 2,
                                                          lineThickness: 1,
                                                          dashColor:
                                                              Color(0xff939598),
                                                          dashGapColor: Colors
                                                              .transparent,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: Sizes.PADDING_6,
                                                bottom: Sizes.PADDING_2),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Add New',
                                                        style: context.bodySmall
                                                            .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: Sizes
                                                              .TEXT_SIZE_14,
                                                          color: const Color(
                                                              0xff58595B),
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Icons.add,
                                                        color:
                                                            Color(0xff58595B),
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
                            ),
                            CustomTextField(
                              hintText: 'Phone Number ',
                              controller: controller.phoneNumberController,
                            ),
                            CustomTextField(
                              hintText: 'Email',
                              controller: controller.emailController,
                            ),
                            CustomTextField(
                              hintText: 'Home Page',
                              controller: controller.homePageController,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(
                        height: Sizes.HEIGHT_10,
                      ),
              ),
              AddCustomerTile(
                onTap: () {
                  controller.toggleInvoicing();
                },
                title: 'INVOICING',
                icon: Obx(
                  () => Icon(
                      controller.invoicingPressed.value
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      color: Colors.white,
                      size: Sizes.ICON_SIZE_36),
                ),
              ),
              Obx(
                () => controller.invoicingPressed.value
                    ? Padding(
                        padding: const EdgeInsets.only(
                            top: Sizes.PADDING_8,
                            left: Sizes.PADDING_14,
                            right: Sizes.PADDING_14,
                            bottom: Sizes.PADDING_30),
                        child: Column(
                          children: [
                            Obx(
                              () => !controller.isTaxAreaCodeExpanded.value
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'Tax Liable',
                                                  style: context.titleSmall
                                                      .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        const Color(0xff939598),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: Sizes.PADDING_26),
                                                child: Expanded(
                                                  flex: 1,
                                                  child: Transform.scale(
                                                    scale: 1.1,
                                                    child: Switch(
                                                      trackOutlineWidth:
                                                          const WidgetStatePropertyAll(
                                                              200),
                                                      inactiveTrackColor:
                                                          const Color(
                                                              0xff979797),
                                                      activeTrackColor:
                                                          const Color(
                                                              0xff13C39C),
                                                      thumbColor:
                                                          const WidgetStatePropertyAll(
                                                              Colors.white),
                                                      value: controller
                                                          .taxButtonPressed
                                                          .value,
                                                      onChanged: (value) {
                                                        controller
                                                            .taxButtonPressed
                                                            .value = value;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: CustomTextField(
                                            hintText: 'Tax Area Code',
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                controller.isTaxAreaCodeExpanded
                                                    .value = true;
                                              },
                                              child: const Icon(
                                                Icons.arrow_drop_down,
                                                color: Color(0xff7C7A7A),
                                              ),
                                            ),
                                            controller: controller
                                                .taxAreaCodeController,
                                          ),
                                        )
                                      ],
                                    )
                                  : Container(
                                      height: Sizes.HEIGHT_230,
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
                                                width: Sizes.WIDTH_240,
                                                child: TextField(
                                                  style: context.bodySmall
                                                      .copyWith(
                                                    fontSize:
                                                        Sizes.TEXT_SIZE_16,
                                                    color:
                                                        const Color(0xff58595B),
                                                  ),
                                                  autofocus: true,
                                                  onChanged: (value) {},
                                                  controller: controller
                                                      .taxAreaCodeController,
                                                  onTapOutside: (event) {},
                                                  decoration: InputDecoration(
                                                    labelText: AppStrings
                                                        .TAX_AREA_CODE,
                                                    focusedBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xff7C7A7A),
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xff7C7A7A),
                                                      ),
                                                    ),
                                                    suffixIcon: IconButton(
                                                      icon: const Icon(
                                                        Icons.search,
                                                        color:
                                                            Color(0xff58595B),
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .isTaxAreaCodeExpanded
                                                      .value = false;
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
                                          Obx(
                                            () => controller
                                                    .isTaxAreaCodeFieldRefresh
                                                    .value
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Code',
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
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: Sizes
                                                                        .PADDING_82),
                                                            child: Text(
                                                              'Description',
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
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: Sizes
                                                                    .PADDING_20,
                                                                top: Sizes
                                                                    .PADDING_8),
                                                        child: DottedLine(
                                                          direction:
                                                              Axis.horizontal,
                                                          dashLength: 3,
                                                          lineLength:
                                                              double.infinity,
                                                          dashGapLength: 2,
                                                          lineThickness: 1,
                                                          dashColor:
                                                              Color(0xff939598),
                                                          dashGapColor: Colors
                                                              .transparent,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                          Expanded(
                                            child: Scrollbar(
                                              trackVisibility: true,
                                              radius: const Radius.circular(
                                                  Sizes.RADIUS_6),
                                              interactive: true,
                                              thickness: 12,
                                              thumbVisibility: true,
                                              controller: controller
                                                  .taxAreaCodeScrollController,
                                              child: ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                controller: controller
                                                    .taxAreaCodeScrollController,
                                                itemCount: 5,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: Sizes
                                                                      .PADDING_8),
                                                          child: SizedBox(
                                                            height:
                                                                Sizes.HEIGHT_17,
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  'code',
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
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left: Sizes
                                                                          .PADDING_86),
                                                                  child: Text(
                                                                    'Description',
                                                                    style: context.bodySmall.copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        fontSize:
                                                                            Sizes
                                                                                .TEXT_SIZE_12,
                                                                        color: const Color(
                                                                            0xff58595B)),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets.only(
                                                            right: Sizes
                                                                .PADDING_20),
                                                        child: DottedLine(
                                                          direction:
                                                              Axis.horizontal,
                                                          dashLength: 3,
                                                          lineLength:
                                                              double.infinity,
                                                          dashGapLength: 2,
                                                          lineThickness: 1,
                                                          dashColor:
                                                              Color(0xff939598),
                                                          dashGapColor: Colors
                                                              .transparent,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: Sizes.PADDING_6,
                                                bottom: Sizes.PADDING_2),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Add New',
                                                        style: context.bodySmall
                                                            .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: Sizes
                                                              .TEXT_SIZE_14,
                                                          color: const Color(
                                                              0xff58595B),
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Icons.add,
                                                        color:
                                                            Color(0xff58595B),
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
                            ),
                            Obx(
                              () => !controller.isGenBusGroupExpanded.value
                                  ? CustomTextField(
                                      hintText:
                                          AppStrings.GEN_BUS_POSTING_GROUP,
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          controller.isGenBusGroupExpanded
                                              .value = true;
                                        },
                                        child: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Color(0xff7C7A7A),
                                        ),
                                      ),
                                      controller:
                                          controller.genBusPostingController,
                                    )
                                  : Container(
                                      height: Sizes.HEIGHT_230,
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
                                                width: Sizes.WIDTH_240,
                                                child: TextField(
                                                  style: context.bodySmall
                                                      .copyWith(
                                                    fontSize:
                                                        Sizes.TEXT_SIZE_16,
                                                    color:
                                                        const Color(0xff58595B),
                                                  ),
                                                  autofocus: true,
                                                  onChanged: (value) {},
                                                  controller: controller
                                                      .genBusPostingController,
                                                  onTapOutside: (event) {},
                                                  decoration: InputDecoration(
                                                    labelText: AppStrings
                                                        .GEN_BUS_POSTING_GROUP,
                                                    focusedBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xff7C7A7A),
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xff7C7A7A),
                                                      ),
                                                    ),
                                                    suffixIcon: IconButton(
                                                      icon: const Icon(
                                                        Icons.search,
                                                        color:
                                                            Color(0xff58595B),
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .isGenBusGroupExpanded
                                                      .value = false;
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
                                          Obx(
                                            () => controller
                                                    .genBusFieldRefresh.value
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Code',
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
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: Sizes
                                                                        .PADDING_82),
                                                            child: Text(
                                                              'Description',
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
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: Sizes
                                                                    .PADDING_20,
                                                                top: Sizes
                                                                    .PADDING_8),
                                                        child: DottedLine(
                                                          direction:
                                                              Axis.horizontal,
                                                          dashLength: 3,
                                                          lineLength:
                                                              double.infinity,
                                                          dashGapLength: 2,
                                                          lineThickness: 1,
                                                          dashColor:
                                                              Color(0xff939598),
                                                          dashGapColor: Colors
                                                              .transparent,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                          Expanded(
                                            child: Scrollbar(
                                              trackVisibility: true,
                                              radius: const Radius.circular(
                                                  Sizes.RADIUS_6),
                                              interactive: true,
                                              thickness: 12,
                                              thumbVisibility: true,
                                              controller: controller
                                                  .genBusPostingScrollController,
                                              child: ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                controller: controller
                                                    .genBusPostingScrollController,
                                                itemCount: 5,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          controller
                                                              .isCountryRegionExpanded
                                                              .value = false;
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: Sizes
                                                                      .PADDING_8),
                                                          child: SizedBox(
                                                            height:
                                                                Sizes.HEIGHT_17,
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  'code',
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
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left: Sizes
                                                                          .PADDING_86),
                                                                  child: Text(
                                                                    'Name',
                                                                    style: context
                                                                        .bodySmall
                                                                        .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          Sizes
                                                                              .TEXT_SIZE_12,
                                                                      color: const Color(
                                                                          0xff58595B),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets.only(
                                                            right: Sizes
                                                                .PADDING_20),
                                                        child: DottedLine(
                                                          direction:
                                                              Axis.horizontal,
                                                          dashLength: 3,
                                                          lineLength:
                                                              double.infinity,
                                                          dashGapLength: 2,
                                                          lineThickness: 1,
                                                          dashColor:
                                                              Color(0xff939598),
                                                          dashGapColor: Colors
                                                              .transparent,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: Sizes.PADDING_6,
                                                bottom: Sizes.PADDING_2),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Add New',
                                                        style: context.bodySmall
                                                            .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: Sizes
                                                              .TEXT_SIZE_14,
                                                          color: const Color(
                                                              0xff58595B),
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Icons.add,
                                                        color:
                                                            Color(0xff58595B),
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
                            ),
                            Obx(
                              () => !controller
                                      .isCustomerPostingGroupExpanded.value
                                  ? CustomTextField(
                                      hintText:
                                          AppStrings.CUSTOMER_POSTING_GROUP,
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          controller
                                              .isCustomerPostingGroupExpanded
                                              .value = true;
                                        },
                                        child: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Color(0xff7C7A7A),
                                        ),
                                      ),
                                      controller:
                                          controller.customerPostingController,
                                    )
                                  : Container(
                                      height: Sizes.HEIGHT_230,
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
                                                width: Sizes.WIDTH_240,
                                                child: TextField(
                                                  style: context.bodySmall
                                                      .copyWith(
                                                    fontSize:
                                                        Sizes.TEXT_SIZE_16,
                                                    color:
                                                        const Color(0xff58595B),
                                                  ),
                                                  autofocus: true,
                                                  onChanged: (value) {},
                                                  controller: controller
                                                      .customerPostingController,
                                                  onTapOutside: (event) {},
                                                  decoration: InputDecoration(
                                                    labelText: AppStrings
                                                        .CUSTOMER_POSTING_GROUP,
                                                    focusedBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xff7C7A7A),
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xff7C7A7A),
                                                      ),
                                                    ),
                                                    suffixIcon: IconButton(
                                                      icon: const Icon(
                                                        Icons.search,
                                                        color:
                                                            Color(0xff58595B),
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .isCustomerPostingGroupExpanded
                                                      .value = false;
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
                                          Obx(
                                            () => controller
                                                    .customerPostingFieldRefresh
                                                    .value
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Code',
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
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: Sizes
                                                                        .PADDING_82),
                                                            child: Text(
                                                              'Description',
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
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: Sizes
                                                                    .PADDING_20,
                                                                top: Sizes
                                                                    .PADDING_8),
                                                        child: DottedLine(
                                                          direction:
                                                              Axis.horizontal,
                                                          dashLength: 3,
                                                          lineLength:
                                                              double.infinity,
                                                          dashGapLength: 2,
                                                          lineThickness: 1,
                                                          dashColor:
                                                              Color(0xff939598),
                                                          dashGapColor: Colors
                                                              .transparent,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                          Expanded(
                                            child: Scrollbar(
                                              trackVisibility: true,
                                              radius: const Radius.circular(
                                                  Sizes.RADIUS_6),
                                              interactive: true,
                                              thickness: 12,
                                              thumbVisibility: true,
                                              controller: controller
                                                  .customerPostingScrollController,
                                              child: ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                controller: controller
                                                    .customerPostingScrollController,
                                                itemCount: 5,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          controller
                                                              .isCustomerPostingGroupExpanded
                                                              .value = false;
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: Sizes
                                                                      .PADDING_8),
                                                          child: SizedBox(
                                                            height:
                                                                Sizes.HEIGHT_17,
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  'code',
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
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left: Sizes
                                                                          .PADDING_86),
                                                                  child: Text(
                                                                    'Name',
                                                                    style: context.bodySmall.copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        fontSize:
                                                                            Sizes
                                                                                .TEXT_SIZE_12,
                                                                        color: const Color(
                                                                            0xff58595B)),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets.only(
                                                            right: Sizes
                                                                .PADDING_20),
                                                        child: DottedLine(
                                                          direction:
                                                              Axis.horizontal,
                                                          dashLength: 3,
                                                          lineLength:
                                                              double.infinity,
                                                          dashGapLength: 2,
                                                          lineThickness: 1,
                                                          dashColor:
                                                              Color(0xff939598),
                                                          dashGapColor: Colors
                                                              .transparent,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: Sizes.PADDING_6,
                                                bottom: Sizes.PADDING_2),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Add New',
                                                        style: context.bodySmall
                                                            .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: Sizes
                                                              .TEXT_SIZE_14,
                                                          color: const Color(
                                                              0xff58595B),
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Icons.add,
                                                        color:
                                                            Color(0xff58595B),
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
                            ),
                            Obx(
                              () => !controller
                                      .isCustomerPriceGroupExpanded.value
                                  ? CustomTextField(
                                      hintText:
                                          AppStrings.CUSTOMER_PRICING_GROUP,
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          controller
                                              .isCustomerPriceGroupExpanded
                                              .value = true;
                                        },
                                        child: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Color(0xff7C7A7A),
                                        ),
                                      ),
                                      controller:
                                          controller.customerPricingController,
                                    )
                                  : Container(
                                      height: Sizes.HEIGHT_230,
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
                                                width: Sizes.WIDTH_240,
                                                child: TextField(
                                                  style: context.bodySmall
                                                      .copyWith(
                                                    fontSize:
                                                        Sizes.TEXT_SIZE_16,
                                                    color:
                                                        const Color(0xff58595B),
                                                  ),
                                                  autofocus: true,
                                                  onChanged: (value) {},
                                                  controller: controller
                                                      .customerPricingController,
                                                  onTapOutside: (event) {},
                                                  decoration: InputDecoration(
                                                    labelText: AppStrings
                                                        .CUSTOMER_PRICING_GROUP,
                                                    focusedBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xff7C7A7A),
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xff7C7A7A),
                                                      ),
                                                    ),
                                                    suffixIcon: IconButton(
                                                      icon: const Icon(
                                                        Icons.search,
                                                        color:
                                                            Color(0xff58595B),
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .isCustomerPriceGroupExpanded
                                                      .value = false;
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
                                          Obx(
                                            () => controller
                                                    .customerPriceFieldRefresh
                                                    .value
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Code',
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
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: Sizes
                                                                        .PADDING_82),
                                                            child: Text(
                                                              'Description',
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
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: Sizes
                                                                    .PADDING_20,
                                                                top: Sizes
                                                                    .PADDING_8),
                                                        child: DottedLine(
                                                          direction:
                                                              Axis.horizontal,
                                                          dashLength: 3,
                                                          lineLength:
                                                              double.infinity,
                                                          dashGapLength: 2,
                                                          lineThickness: 1,
                                                          dashColor:
                                                              Color(0xff939598),
                                                          dashGapColor: Colors
                                                              .transparent,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                          Expanded(
                                            child: Scrollbar(
                                              trackVisibility: true,
                                              radius: const Radius.circular(
                                                  Sizes.RADIUS_6),
                                              interactive: true,
                                              thickness: 12,
                                              thumbVisibility: true,
                                              controller: controller
                                                  .countryRegionScrollController,
                                              child: ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                controller: controller
                                                    .countryRegionScrollController,
                                                itemCount: 5,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          controller
                                                              .isCustomerPriceGroupExpanded
                                                              .value = false;
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: Sizes
                                                                      .PADDING_8),
                                                          child: SizedBox(
                                                            height:
                                                                Sizes.HEIGHT_17,
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  'code',
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
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left: Sizes
                                                                          .PADDING_86),
                                                                  child: Text(
                                                                    'Name',
                                                                    style: context.bodySmall.copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        fontSize:
                                                                            Sizes
                                                                                .TEXT_SIZE_12,
                                                                        color: const Color(
                                                                            0xff58595B)),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets.only(
                                                            right: Sizes
                                                                .PADDING_20),
                                                        child: DottedLine(
                                                          direction:
                                                              Axis.horizontal,
                                                          dashLength: 3,
                                                          lineLength:
                                                              double.infinity,
                                                          dashGapLength: 2,
                                                          lineThickness: 1,
                                                          dashColor:
                                                              Color(0xff939598),
                                                          dashGapColor: Colors
                                                              .transparent,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: Sizes.PADDING_6,
                                                bottom: Sizes.PADDING_2),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Add New',
                                                        style: context.bodySmall
                                                            .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: Sizes
                                                              .TEXT_SIZE_14,
                                                          color: const Color(
                                                              0xff58595B),
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Icons.add,
                                                        color:
                                                            Color(0xff58595B),
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
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(
                        height: Sizes.HEIGHT_10,
                      ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: Sizes.PADDING_40),
              //   child:
              //       Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              //     CustomElevatedButton(
              //       onPressed: () {
              //         Get.back();
              //       },
              //       title: AppStrings.CANCEL,
              //       minWidht: Sizes.WIDTH_90,
              //       minHeight: Sizes.HEIGHT_30,
              //       backgroundColor: LightTheme.buttonBackgroundColor2,
              //       borderRadiusCircular: BorderRadius.circular(Sizes.RADIUS_6),
              //     ),
              //     const SizedBox(
              //       width: Sizes.WIDTH_26,
              //     ),
              //     CustomElevatedButton(
              //       onPressed: () {},
              //       title: AppStrings.SAVE,
              //       minWidht: Sizes.WIDTH_90,
              //       minHeight: Sizes.HEIGHT_30,
              //       backgroundColor: LightTheme.buttonBackgroundColor2,
              //       borderRadiusCircular: BorderRadius.circular(Sizes.RADIUS_6),
              //     )
              //   ]),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
