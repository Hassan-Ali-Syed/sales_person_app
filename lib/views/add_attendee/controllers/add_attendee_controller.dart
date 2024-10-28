import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/preferences/preferences.dart';
import 'package:sales_person_app/services/api/api_constants.dart';
import 'package:sales_person_app/services/api/base_client.dart';
import 'package:sales_person_app/utils/custom_snackbar.dart';
import 'package:sales_person_app/views/customer_visit/controllers/customer_visit_controller.dart';
import 'package:sales_person_app/views/main_page/controllers/main_page_controller.dart';
import 'package:sales_person_app/views/main_page/models/tlicustomers_model.dart';
import 'package:sales_person_app/queries/api_mutate/tlicontact_mutate.dart';

class AddAttendeeController extends GetxController {
  late MainPageController mainPageController;
  late CustomerVisitController customerVisitController;

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

  RxBool isLoading = false.obs;
// CONTACT PAGE's SCROLL CONTROLLERS
  ScrollController contactCustomerScrollController = ScrollController();

  //FLAGS OF CUSTOMER's TEXTFIELD
  RxBool isContactCustomerExpanded = false.obs;

  @override
  void onInit() async {
    super.onInit();
    mainPageController = Get.find<MainPageController>();
    customerVisitController = Get.find<CustomerVisitController>();

    contactCustomerTextFieldController = TextEditingController(
        text: customerVisitController.selectedCustomer!.name!);
    // log('==CustomerName :  ${customrName.value}==========CustomerNo :  ${customrNo.value}====================');
  }

  @override
  void onClose() {
    super.onClose();
    clearAllTextFieldsOfContactPage();
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
        mainPageController.getCustomersFromGraphQL();

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
    if (contactFullNameTextFieldController.text == '' ||
        contactEmailTextFieldController.text == '' ||
        contactPhoneNoTextFieldController.text == '') {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Alert', message: 'please enter All Fields');
      return;
    } else {
      createTliContacts(
        name: contactFullNameTextFieldController.text,
        customerNo: customerVisitController.selectedCustomer!.no!,
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
}
