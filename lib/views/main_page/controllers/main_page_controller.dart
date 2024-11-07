import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/preferences/preferences.dart';
import 'package:sales_person_app/queries/api_quries/tlicustomers_query.dart';
import 'package:sales_person_app/routes/app_routes.dart';
import 'package:sales_person_app/services/api/api_constants.dart';
import 'package:sales_person_app/services/api/base_client.dart';
import 'package:sales_person_app/utils/custom_snackbar.dart';
import 'package:sales_person_app/views/main_page/models/tlicustomers_model.dart';
import 'package:sales_person_app/views/main_page/views/contact_page_screen.dart';
import 'package:sales_person_app/views/main_page/views/customer_page_screen.dart';
import 'package:sales_person_app/views/main_page/views/home_page_screen.dart';
import 'package:sales_person_app/views/main_page/views/more_page_screen.dart';

class MainPageController extends GetxController {
  final GlobalKey<ScaffoldState> mainPageScaffoldKey =
      GlobalKey<ScaffoldState>();

  // Observable for selecte Index from NavBar
  var selectedIndex = 0.obs;

  // flag for tracking API process
  var isLoading = false.obs;

  // Pages for bottom navigation
  List pages = [
    HomePageScreen(),
    const CustomerPageScreen(),
    const ContactPageScreen(),
    const MorePageScreen()
  ];

  // AppBar title
  final List<String> appBarTitle = [
    AppStrings.HOME_TITLE,
    AppStrings.CUSTOMER_TITLE,
    AppStrings.CONTACT_TITLE,
    AppStrings.MORE_TITLE
  ];
  TliCustomers? tliCustomers;
  // Method to update selectedIndex of Bottom Navigation Bar
  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() async {
    super.onInit();
    selectedIndex.value = 0;
    await getCustomersFromGraphQL();
  }

  Future<void> getCustomersFromGraphQL() async {
    await BaseClient.safeApiCall(
      ApiConstants.BASE_URL_GRAPHQL,
      RequestType.query,
      headersForGraphQL: await BaseClient.generateHeadersWithTokenForGraphQL(),
      query: TlicustomersQuery.tliCustomersQuery(),
      onLoading: () {
        isLoading.value = true;
        log('loading...................................');
      },
      onSuccessGraph: (response) async {
        addTliCustomerModel(response.data!['tliCustomers']);

        isLoading.value = false;
      },
      onError: (e) {
        isLoading.value = false;
        CustomSnackBar.showCustomErrorSnackBar(
          title: 'Server Error',
          message: e.message,
          duration: const Duration(seconds: 5),
        );
        log('*** onError *** \n ${e.message}');
      },
    );
  }

  addTliCustomerModel(response) {
    tliCustomers = TliCustomers.fromJson(response);
    Preferences().setCustomerRecords(tliCustomers);
    log("******************addedTliCustomerModel****************");
    isLoading.value = false;
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
      onError: (e) {
        isLoading.value = false;
        if (e.statusCode == 302) {
          CustomSnackBar.showCustomErrorSnackBar(
            title: 'Server Error',
            message: 'Please try again later',
            duration: const Duration(seconds: 2),
          );
        } else {
          CustomSnackBar.showCustomErrorSnackBar(
            title: 'Server Error',
            message: 'Please try again later',
            duration: const Duration(seconds: 2),
          );
        }
      },
    );
  }

  String currentDate() {
    String formattedDate = DateFormat('MMMM d, yyyy').format(DateTime.now());
    return formattedDate;
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }
  //******************** CUSTOMER PAGE PORTION ************************//

  // ******************* CONTACT PAGE PORTION ************************//

  // ************************* MORE PAGE *****************************//
}
