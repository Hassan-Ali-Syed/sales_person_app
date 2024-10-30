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
  RxBool isLoading = false.obs;

  late TextEditingController companyNameController;
  late CustomerVisitController customerVisitController;
  TextEditingController addressController = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countyController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryRegionController = TextEditingController();
  RxBool isCountryRegionExpanded = false.obs;
  ScrollController countryRegionScrollController = ScrollController();

  TliCountrys? tliCountrys;
  @override
  onInit() {
    super.onInit();
    customerVisitController = Get.find<CustomerVisitController>();
    getTliCountrys();
    companyNameController = TextEditingController(
        text: customerVisitController.selectedCustomer!.name);
  }

  @override
  void dispose() {
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
    log("Dispose controllers of ship to add ");
    super.dispose();
  }

  addTliCountrys(response) {
    tliCountrys = TliCountrys.fromJson(response);
  }

  Future<void> getTliCountrys() async {
    await BaseClient.safeApiCall(
      ApiConstants.BASE_URL_GRAPHQL,
      RequestType.query,
      headersForGraphQL: BaseClient.generateHeadersWithTokenForGraphQL(),
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
      headersForGraphQL: BaseClient.generateHeadersWithTokenForGraphQL(),
      query: TliShipToAddMutate.tliShipToAddMutate(
        code: customerVisitController.customersShipToAdd.length + 1 > 9
            ? "${customerVisitController.customersShipToAdd.length + 1}"
            : "0${customerVisitController.customersShipToAdd.length + 1}",
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

  void clearAllFields() {
    companyNameController.clear();
    addressController.clear();
    address2Controller.clear();
    zipCodeController.clear();
    cityController.clear();
    countyController.clear();
    contactController.clear();
    phoneNumberController.clear();
    emailController.clear();
    countryRegionController.clear();
  }
}
