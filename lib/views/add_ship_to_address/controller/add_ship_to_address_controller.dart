import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/queries/api_mutate/tlishiptoadd_mutate.dart';
import 'package:sales_person_app/services/api/api_constants.dart';
import 'package:sales_person_app/services/api/base_client.dart';
import 'package:sales_person_app/utils/custom_snackbar.dart';
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
  @override
  onInit() {
    super.onInit();
    customerVisitController = Get.find<CustomerVisitController>();
    companyNameController = TextEditingController(
        text: customerVisitController.selectedCustomer!.name);
    log('==CustomerName :  ${customerVisitController.selectedCustomer!.name}==========CustomerNo :  ${customerVisitController.selectedCustomer!.no}====================');
  }

  Future<void> createTliShipToAdd({required String countryRegionCode}) async {
    await BaseClient.safeApiCall(
      ApiConstants.BASE_URL_GRAPHQL,
      RequestType.mutate,
      headersForGraphQL: BaseClient.generateHeadersWithTokenForGraphQL(),
      query: TliShipToAddMutate.tliShipToAddMutate(
        code: '',
        companyName: companyNameController.text,
        customerNo: customerVisitController.selectedCustomer!.no!,
        address: addressController.text,
        address2: address2Controller.text,
        city: cityController.text,
        postCode: zipCodeController.text,
        countryRegionCode: countryRegionCode,
        county: countyController.text,
        contact: contactController.text,
        phoneNo: phoneNumberController.text,
        email: emailController.text,
      ),
      onLoading: () {
        isLoading.value = true;
      },
      onSuccessGraph: (response) {
        customerVisitController.getCustomerbyIdFromGraphQL(
            customerVisitController.selectedCustomer!.no!);
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
}
