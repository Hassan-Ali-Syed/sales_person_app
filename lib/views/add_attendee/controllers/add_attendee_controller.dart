import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/services/api/api_constants.dart';
import 'package:sales_person_app/services/api/base_client.dart';
import 'package:sales_person_app/utils/custom_snackbar.dart';
import 'package:sales_person_app/views/main_page/models/tlicustomers_model.dart';
import 'package:sales_person_app/queries/api_mutate/tlicontact_mutate.dart';

class AddAttendeeController extends GetxController {
  // TliCustomers? tliCustomers;

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
              message: '${response.data!['createtliContact']['message']}',
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

  void ateendeeFormValidation() {
    if (contactCustomerNo.value == '') {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Alert', message: 'please select customer from list');
      return;
    } else if (contactCustomerTextFieldController.text == '' ||
        contactFullNameTextFieldController.text == '' ||
        contactPhoneNoTextFieldController.text == '' ||
        contactEmailTextFieldController.text == '') {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Alert', message: 'please fill all fields');
    } else {
      createTliContacts(
        name: contactFullNameTextFieldController.text,
        customerNo: contactCustomerNo.value,
        email: contactEmailTextFieldController.text,
        phoneNo: contactPhoneNoTextFieldController.text,
      );
    }
  }

  void clearAllTextFieldsOfContactPage() {
    contactFullNameTextFieldController.clear();
    contactCustomerTextFieldController.clear();
    // contactAddressTextFieldController.clear();
    contactEmailTextFieldController.clear();
    contactPhoneNoTextFieldController.clear();
  }

  void filterCustomerList(String query, TliCustomers? tliCustomers) {
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

  void clearFilteredCustomers(TliCustomers? tliCustomers) {
    filteredCustomers.value = List.from(tliCustomers!.value);
  }
}
