import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/queries/api_mutate/tlishiptoadd_mutate.dart';
import 'package:sales_person_app/queries/api_quries/tlicountrys_query.dart';
import 'package:sales_person_app/services/api/api_constants.dart';
import 'package:sales_person_app/services/api/base_client.dart';
import 'package:sales_person_app/utils/custom_snackbar.dart';
import 'package:sales_person_app/views/add_ship_to_address/models/tlicountrys_model.dart';
import 'package:sales_person_app/views/customer_visit/controllers/customer_visit_controller.dart';

class AddShipToAddressController extends GetxController {
  TliCountrys? tliCountrys;

  RxBool isLoading = false.obs;
  RxBool countryRegionFieldRefresh = false.obs;
  RxBool isCountryRegionExpanded = false.obs;
  RxBool isAllFieldsFilled = false.obs;

  late CustomerVisitController customerVisitController;
  late TextEditingController companyNameController;
  late TextEditingController addressController;
  late TextEditingController address2Controller;
  late TextEditingController zipCodeController;
  late TextEditingController cityController;
  late TextEditingController countyController;
  late TextEditingController contactController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;
  late TextEditingController countryRegionController;

  late ScrollController countryRegionScrollController;

  List<TliCountrysValue> filteredCountry = <TliCountrysValue>[].obs;

  @override
  void onInit() {
    super.onInit();
    companyNameController = TextEditingController();
    addressController = TextEditingController();
    address2Controller = TextEditingController();
    zipCodeController = TextEditingController();
    cityController = TextEditingController();
    countyController = TextEditingController();
    contactController = TextEditingController();
    phoneNumberController = TextEditingController();
    emailController = TextEditingController();
    countryRegionController = TextEditingController();

    countryRegionScrollController = ScrollController();

    customerVisitController = Get.find<CustomerVisitController>();
    getTliCountrys();
    if (customerVisitController.selectedCustomer != null) {
      companyNameController.text =
          customerVisitController.selectedCustomer!.name.toString();
    }
  }

  @override
  void onClose() {
    customerVisitController.dispose();
    companyNameController.dispose();
    addressController.dispose();
    address2Controller.dispose();
    zipCodeController.dispose();
    cityController.dispose();
    countyController.dispose();
    contactController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    countryRegionController.dispose();
    countryRegionScrollController.dispose();
    log("Dispose controllers of ship to add ");
    super.onClose();
  }

  Future<void> getTliCountrys() async {
    await BaseClient.safeApiCall(
      ApiConstants.BASE_URL_GRAPHQL,
      RequestType.query,
      headersForGraphQL: await BaseClient.generateHeadersWithTokenForGraphQL(),
      query: TliCountrysQuery.tliCountrysQuery(),
      onLoading: () {
        isLoading.value = true;
      },
      onSuccessGraph: (response) {
        log("******* RESPONSE: *********\n ${response.data}");
        addTliCountrys(response.data!['tliCountrys']);
      },
      onError: (e) {
        isLoading.value = false;
        log('*** onError *** \n ${e.message}');
      },
    );
  }

  Future<void> createTliShipToAdd() async {
    await BaseClient.safeApiCall(
      ApiConstants.BASE_URL_GRAPHQL,
      RequestType.mutate,
      headersForGraphQL: await BaseClient.generateHeadersWithTokenForGraphQL(),
      query: TliShipToAddMutate.tliShipToAddMutate(
        code: customerVisitController.tliShipToAddresses!.length + 1 > 9
            ? "${customerVisitController.tliShipToAddresses!.length + 1}"
            : "0${customerVisitController.tliShipToAddresses!.length + 1}",
        companyName: companyNameController.text,
        customerNo: customerVisitController.selectedCustomer!.no!,
        address: addressController.text,
        address2: address2Controller.text,
        city: cityController.text,
        postCode: zipCodeController.text,
        countryRegionCode: countryRegionController.text,
        county: countyController.text,
        contact: contactController.text,
        phoneNo: phoneNumberController.text,
        email: emailController.text,
      ),
      onLoading: () {
        isLoading.value = true;
      },
      onSuccessGraph: (response) {
        if (response.data!['createtliShipToAdd']['status'] == 200) {
          log("******* RESPONSE SUCCESS: *********\n ${response.data}");
          customerVisitController.getCustomerbyIdFromGraphQL(
              customerVisitController.selectedCustomer!.no!);
          // clearAllFields();
          Get.back();
        } else if (response.data!['createtliShipToAdd']['status'] == 400) {
          isLoading.value = false;
          CustomSnackBar.showCustomErrorSnackBar(
            title: 'Record Exists',
            message: response.data!['createtliShipToAdd']['message'],
            duration: const Duration(seconds: 5),
          );
        } else {
          isLoading.value = false;
          CustomSnackBar.showCustomErrorSnackBar(
            title: 'Error',
            message: response.data!['createtliShipToAdd']['message'],
            duration: const Duration(seconds: 5),
          );
        }
      },
      onError: (e) {
        isLoading.value = false;
        CustomSnackBar.showCustomErrorSnackBar(
          title: 'Error',
          message: e.message,
          duration: const Duration(seconds: 5),
        );
        log('*** onError *** \n ${e.message}');
      },
    );
  }

  addTliCountrys(response) {
    tliCountrys = TliCountrys.fromJson(response);
    filteredCountry = tliCountrys!.value;
  }

  void filterCountryRegionCode() {
    countryRegionFieldRefresh.value = true;
    if (tliCountrys?.value == null) return;
    if (countryRegionController.text.isEmpty ||
        countryRegionController.text == '') {
      filteredCountry = tliCountrys!.value;
      countryRegionFieldRefresh.value = false;
    } else {
      filteredCountry = [];
      for (var element in tliCountrys!.value) {
        if (element.code!.toLowerCase().contains(
              countryRegionController.text.toLowerCase(),
            )) {
          filteredCountry.add(element);
        }
      }
      countryRegionFieldRefresh.value = false;
    }
    log('List $filteredCountry');
  }

  void shipToAddressFormValidation() {
    if (int.tryParse(phoneNumberController.text) == null ||
        int.tryParse(phoneNumberController.text) == null) {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Alert', message: 'Phone Number should be in digits');
    } else if (int.tryParse(zipCodeController.text) == null ||
        int.tryParse(zipCodeController.text) == null) {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Alert', message: 'Zip Code should be in digits');
    } else {
      createTliShipToAdd();
    }
  }

  checkAllFieldsFilled() {
    log("Checking fields...");
    isAllFieldsFilled.value = addressController.text.isNotEmpty &&
        address2Controller.text.isNotEmpty &&
        zipCodeController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        countyController.text.isNotEmpty &&
        contactController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        countryRegionController.text.isNotEmpty;
  }
}
