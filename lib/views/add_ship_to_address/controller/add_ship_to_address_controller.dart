import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/preferences/preferences.dart';
import 'package:sales_person_app/queries/api_mutate/tlishiptoadd_mutate.dart';
import 'package:sales_person_app/services/api/api_constants.dart';
import 'package:sales_person_app/services/api/base_client.dart';
import 'package:sales_person_app/utils/custom_snackbar.dart';

class AddShipToAddressController extends GetxController {
  RxBool isLoading = false.obs;
  RxString customrName = ''.obs;
  RxString customrNo = ''.obs;
  late TextEditingController nameController;
  @override
  onInit() {
    super.onInit();
    customrName.value = Preferences().getSelectedCustomerData()['name'];
    customrNo.value = Preferences().getSelectedCustomerData()['no'];
    nameController = TextEditingController(text: customrName.value);
    log('==CustomerName :  ${customrName.value}==========CustomerNo :  ${customrNo.value}====================');
  }

  Future<void> createTliShipToAdd({
    required String customerNo,
    required String name,
    required String address,
    required String address2,
    required String postCode,
    required String city,
    required String countryRegionCode,
    required String county,
    required String code,
    required String phoneNo,
    required String email,
  }) async {
    await BaseClient.safeApiCall(
      ApiConstants.BASE_URL_GRAPHQL,
      RequestType.mutate,
      headersForGraphQL: BaseClient.generateHeadersWithTokenForGraphQL(),
      query: TliShipToAddMutate.tliShipToAddMutate(
        name: name,
        customerNo: customerNo,
        address: address,
        address2: address2,
        code: code,
        city: city,
        countryRegionCode: countryRegionCode,
        county: county,
        email: email,
        phoneNo: phoneNo,
        postCode: postCode,
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
}
