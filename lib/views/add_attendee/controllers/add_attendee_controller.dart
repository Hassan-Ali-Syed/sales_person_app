import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/preferences/preferences.dart';
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
  TliCustomers? tliCustomers;

  RxBool isLoading = false.obs;
// CONTACT PAGE's SCROLL CONTROLLERS
  ScrollController contactCustomerScrollController = ScrollController();

  //FLAGS OF CUSTOMER's TEXTFIELD
  RxBool isContactCustomerExpanded = false.obs;
  RxBool isContactCustomerSearch = false.obs;

  var filteredCustomers = [].obs; // Filtered customers list

  RxString customerName = ''.obs;
  RxString customerNo = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    customerName.value = Preferences().getSelectedCustomerData()['name'];
    customerNo.value = Preferences().getSelectedCustomerData()['no'];
    contactCustomerTextFieldController =
        TextEditingController(text: customerName.value);
    // log('==CustomerName :  ${customrName.value}==========CustomerNo :  ${customrNo.value}====================');

    await addTliCustomerModel();
  }

  @override
  void onClose() {
    super.onClose();
    clearAllTextFieldsOfContactPage();
  }

  addTliCustomerModel() {
    tliCustomers = Preferences().getCustomerRecords();
  }

  void setCustomerData(var indexNo) async {
    filteredCustomers.value = tliCustomers!.value;

    contactCustomerTextFieldController.text =
        tliCustomers!.value[indexNo].name!;

    isContactCustomerExpanded.value = false;

    customerNo.value = tliCustomers!.value[indexNo].no!;
    log('====customer no======${customerNo}======================');

    log('====Selected Customer Map from cache======${Preferences().getSelectedCustomerData()}======================');
  }

  Future<void> createTliContacts({
    required String name,
    required String customerNo,
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
        email: email,
        phoneNo: phoneNo,
      ),
      onLoading: () {
        isLoading.value = true;
      },
      onSuccessGraph: (response) {
        log("******* RESPONSE: *********\n ${response.data!}");

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
    if (contactCustomerTextFieldController.text.isNotEmpty) {
      var list = tliCustomers!.value
          .where(
            (customer) =>
                customer.name!.toLowerCase() ==
                contactCustomerTextFieldController.text.toLowerCase(),
          )
          .toList();
      if (list.isEmpty) {
        CustomSnackBar.showCustomErrorSnackBar(
            title: 'Alert', message: 'Invalid Customer Name');
      }
    }
    if (contactCustomerTextFieldController.text == '' &&
        contactFullNameTextFieldController.text == '' &&
        contactPhoneNoTextFieldController.text == '' &&
        contactEmailTextFieldController.text == '') {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Alert', message: 'please fill all fields');
    } else if (contactFullNameTextFieldController.text == '') {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Alert', message: 'please enter Full Name');
      return;
    } else if (contactCustomerTextFieldController.text == '') {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Alert', message: 'please enter customer');
      return;
    } else if (contactEmailTextFieldController.text == '') {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Alert', message: 'please enter an email ');
      return;
    } else if (contactPhoneNoTextFieldController.text == '') {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Alert', message: 'please enter Phone Number');
      return;
    } else {
      createTliContacts(
        name: contactFullNameTextFieldController.text,
        customerNo: customerNo.value,
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
    filteredCustomers.clear();
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
