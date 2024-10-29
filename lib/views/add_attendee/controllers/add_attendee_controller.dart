import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/services/api/api_constants.dart';
import 'package:sales_person_app/services/api/base_client.dart';
import 'package:sales_person_app/utils/custom_snackbar.dart';
import 'package:sales_person_app/views/customer_visit/controllers/customer_visit_controller.dart';
import 'package:sales_person_app/queries/api_mutate/tlicontact_mutate.dart';

class AddAttendeeController extends GetxController {
  late CustomerVisitController customerVisitController;

  // TliCustomers? tliCustomers;
  TextEditingController contactFullNameTextFieldController =
      TextEditingController();
  TextEditingController contactCustomerTextFieldController =
      TextEditingController();
  TextEditingController contactEmailTextFieldController =
      TextEditingController();
  TextEditingController contactPhoneNoTextFieldController =
      TextEditingController();

  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    customerVisitController = Get.find<CustomerVisitController>();
    contactCustomerTextFieldController = TextEditingController(
        text: customerVisitController.selectedCustomer!.name!);
  }

  @override
  void dispose() {
    contactFullNameTextFieldController.dispose();
    contactCustomerTextFieldController.dispose();
    contactEmailTextFieldController.dispose();
    contactPhoneNoTextFieldController.dispose();
    super.dispose();
  }

  Future<void> createTliContacts() async {
    await BaseClient.safeApiCall(
      ApiConstants.BASE_URL_GRAPHQL,
      RequestType.mutate,
      headersForGraphQL: BaseClient.generateHeadersWithTokenForGraphQL(),
      query: TlicontactMutate.tliContactMutate(
        name: contactFullNameTextFieldController.text,
        customerNo: customerVisitController.selectedCustomer!.no!,
        email: contactEmailTextFieldController.text,
        phoneNo: contactPhoneNoTextFieldController.text,
      ),
      onLoading: () {
        isLoading.value = true;
      },
      onSuccessGraph: (response) async {
        if ((response.data!['createtliContact']['status'] == 200)) {
          {
            log("******* RESPONSE: *********\n ${response.data!}");
            await customerVisitController.getCustomerbyIdFromGraphQL(
                customerVisitController.selectedCustomer!.no!);
            Get.back();
            isLoading.value = false;
          }
        } else if (response.data!['createtliContact']['status'] == 400) {
          log("******* else If Block *********\n ${response.data!}");
          CustomSnackBar.showCustomToast(
              title: 'Invalid Format',
              message: '${response.data!['createtliContact']['message']}',
              duration: const Duration(seconds: 3),
              color: AppColors.redShade5);
          isLoading.value = false;
        } else {
          log("******* Else Block: *********\n ${response.data!}");
          CustomSnackBar.showCustomToast(
              message: '${response.data!['createtliContact']['message']}',
              duration: const Duration(seconds: 3),
              color: AppColors.redShade5);
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
      createTliContacts();
    }
  }

  void clearAllTextFieldsOfContactPage() {
    contactFullNameTextFieldController.clear();
    contactCustomerTextFieldController.clear();
    contactEmailTextFieldController.clear();
    contactPhoneNoTextFieldController.clear();
  }
}
