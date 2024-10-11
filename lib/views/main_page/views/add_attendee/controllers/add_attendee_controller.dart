import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/preferences/preferences.dart';
import 'package:sales_person_app/routes/app_routes.dart';
import 'package:sales_person_app/services/api/api_constants.dart';
import 'package:sales_person_app/services/api/base_client.dart';
import 'package:sales_person_app/utils/custom_snackbar.dart';
import 'package:sales_person_app/views/main_page/models/tlicustomers_model.dart';
import 'package:sales_person_app/views/main_page/queries/api_mutate/tlicontact_mutate.dart';
import 'package:sales_person_app/views/main_page/queries/api_quries/tlicustomers_query.dart';

class AddAttendeeController extends GetxController {
  TliCustomers? tliCustomers;

  TextEditingController contactFullNameTextFieldController =
      TextEditingController();
  TextEditingController contactSearchTextFieldController =
      TextEditingController();
  TextEditingController contactCustomerTextFieldController =
      TextEditingController();
  TextEditingController contactEmailTextFieldController =
      TextEditingController();
  TextEditingController contactPhoneNoTextFieldController =
      TextEditingController();

  var contactCustomerNo = ''.obs;
  RxBool isLoading = false.obs;
// CONTACT PAGE's SCROLL CONTROLLERS
  ScrollController contactCustomerScrollController = ScrollController();

  //FLAGS OF CUSTOMER's TEXTFIELD
  RxBool isContactCustomerExpanded = false.obs;
  RxBool isContactCustomerSearch = false.obs;

  var filteredCustomers = [].obs; // Filtered customers list
  @override
  void onInit() async {
    super.onInit();
    await getCustomersFromGraphQL();
  }

  addTliCustomerModel(response) {
    tliCustomers = TliCustomers.fromJson(response);
    isLoading.value = false;
  }

  Future<void> getCustomersFromGraphQL() async {
    await BaseClient.safeApiCall(
      ApiConstants.BASE_URL_GRAPHQL,
      RequestType.query,
      headersForGraphQL: BaseClient.generateHeadersWithTokenForGraphQL(),
      query: TlicustomersQuery.tliCustomersQuery(),
      onLoading: () {
        isLoading.value = true;
      },
      onSuccessGraph: (response) {
        addTliCustomerModel(response.data!['tliCustomers']);
        log("########RESPONSE: ############## \n ${response.data!['tliCustomers']}");
        isLoading.value = false;
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

  Future<void> createTliContacts({
    required String name,
    required String customerNo,
    // required String address,
    required String email,
    required String phoneNo,
  }) async {
    await BaseClient.safeApiCall(
      ApiConstants.BASE_URL_GRAPHQL,
      RequestType.mutate,
      headersForGraphQL: BaseClient.generateHeadersWithTokenForGraphQL(),
      query: TlicontactMutate.tliContactMutate(
        name: name,
        customerNo: customerNo,
        // address: address,
        email: email,
        phoneNo: phoneNo,
      ),
      onLoading: () {
        isLoading.value = true;
      },
      onSuccessGraph: (response) {
        log("******* RESPONSE: *********\n ${response.data!['message']}");

        if (response.data!['createtliContact']['status'] == 400) {
          CustomSnackBar.showCustomToast(
              message: '${response.data!['createtliContact']['success']}',
              duration: const Duration(seconds: 3),
              color: AppColors.redShade5);
          isLoading.value = false;
        } else {
          CustomSnackBar.showCustomToast(
            message: '${response.data!['createtliContact']['message']}',
            duration: const Duration(seconds: 3),
            color: Colors.green,
          );
          isLoading.value = false;
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

  void clearAllTextFieldsOfContactPage() {
    contactFullNameTextFieldController.clear();
    contactCustomerTextFieldController.clear();
    // contactAddressTextFieldController.clear();
    contactEmailTextFieldController.clear();
    contactPhoneNoTextFieldController.clear();
  }

  void filterCustomerList(String query) {
    if (tliCustomers?.value == null) return;
    if (query.isEmpty) {
      filteredCustomers.value = List.from(tliCustomers!.value);
    } else {
      filteredCustomers.value = tliCustomers!.value
          .where((customer) =>
              customer.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void clearFilteredCustomers() {
    filteredCustomers.value = List.from(tliCustomers!.value);
  }

  Future<void> userLogOut() async {
    await BaseClient.safeApiCall(
      ApiConstants.LOG_OUT,
      RequestType.post,
      headers: await BaseClient.generateHeadersForLogout(),
      onLoading: () {
        isLoading.value = true;
      },
      onSuccess: (response) {
        Preferences().removeToken();
        isLoading.value = false;
        Get.offAllNamed(AppRoutes.SIGN_IN);
      },
      onError: (p0) {
        isLoading.value = false;
        CustomSnackBar.showCustomErrorSnackBar(
          title: 'Error',
          message: p0.message,
          duration: const Duration(seconds: 2),
        );
      },
    );
  }
}
