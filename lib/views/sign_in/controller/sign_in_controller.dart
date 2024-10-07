import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/preferences/preferences.dart';
import 'package:sales_person_app/routes/app_routes.dart';

import 'package:sales_person_app/services/api/api_constants.dart';
import 'package:sales_person_app/services/api/base_client.dart';
import 'package:sales_person_app/utils/custom_snackbar.dart';
import 'package:sales_person_app/views/sign_in/models/sign_in_model.dart';

class SignInController extends GetxController {
  final GlobalKey<ScaffoldState> signInScaffoldKey = GlobalKey<ScaffoldState>();

  SignInModel? userLoginData;
  RxBool isObscure = true.obs;
  RxBool isLoading = false.obs;
  RxBool isServerError = false.obs;
  RxString msg = "".obs;

  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void onInit() {
    super.onInit();
    Preferences().clearAll();
    emailController = TextEditingController(text: 'mansoor.messo@gmail.com');
    passwordController = TextEditingController(text: 'messo123');
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<String> getToken() async {
    String token = await Preferences().getUserToken();
    return token;
  }

  Future<void> userLoginGraph() async {
    await BaseClient.safeApiCall(
      ApiConstants.BASE_URL_GRAPHQL,
      RequestType.mutate,
      headersForGraphQL: BaseClient.generateHeadersForGraphQL2_0(),
      query: """
        mutation {
            login(input: {
                email: "${emailController.text}"
                password: "${passwordController.text}"
            }) {
                token
            }
        }""",
      onLoading: () {
        isLoading.value = true;
      },
      onSuccessGraph: (response) async {
        Preferences().setUserToken(response.data!['login']["token"]);

        if (Preferences().getUserToken() != null) {
          log('Token: ${Preferences().getUserToken()}');
          Get.offNamed(AppRoutes.MAIN_PAGE);
        }
      },
      onError: (e) {
        isServerError.value = true;
        CustomSnackBar.showCustomErrorSnackBar(
            title: 'Error',
            message: e.message,
            duration: const Duration(seconds: 3));
      },
    );
  }

// Initially password is obscured
  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }
}
