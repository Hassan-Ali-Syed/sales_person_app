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
  RxString errorTitle = ''.obs;

  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void dispose() {
    passwordController.clear();
    emailController.clear();
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    Preferences().clearAll();

    emailController = TextEditingController(text: 'Hassan@gmail.com');
    passwordController = TextEditingController(text: 'hassan123');
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

  Future<void> signInRest() async {
    await BaseClient.safeApiCall(
      ApiConstants.LOGIN,
      RequestType.post,
      headers: await BaseClient.generateHeaders(),
      data: {
        "email": emailController.text,
        "password": passwordController.text
      },
      onLoading: () {
        isLoading.value = true;
      },
      onSuccess: (response) async {
        if (response.data!['success']) {
          addUserLoginData(response.data!);
        }
      },
      onError: (e) {
        if (e.statusCode == 401) {
          log('status code ${e.statusCode}: ${e.response?.data['message']}');
          msg.value = e.response?.data['message'];
          errorTitle.value = 'Invalid credentials';
        } else if (e.statusCode == 422) {
          log('status code ${e.statusCode}: ${e.response?.data['errors']['email'][0]}');
          msg.value = e.response?.data['errors']['email'][0];
          errorTitle.value = 'Invalid email';
        } else {
          log('status code ${e.statusCode}: ${e.response}');
          errorTitle.value = 'Server error';
          msg.value = e.message;
        }
        CustomSnackBar.showCustomErrorSnackBar(
          title: errorTitle.value,
          message: msg.value,
          duration: const Duration(seconds: 2),
        );
        isServerError.value = true;
      },
    );
  }

  void addUserLoginData(Map<String, dynamic> data) async {
    isLoading.value = true;
    userLoginData = SignInModel.fromJson(data);
    Preferences().setUser(userLoginData!.data!);
    Preferences().setUserToken(userLoginData!.data!.token!);
    log('Token: ${Preferences().getUserToken()}');
    log('User: ${Preferences().getUser().name}');
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.MAIN_PAGE);
  }

  void signInMethod() {
    if (emailController.text == '' && passwordController.text == '') {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Invalid Input',
        message: 'Enter email address & password',
        duration: const Duration(seconds: 3),
      );
    } else if (emailController.text == '') {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Invalid Input',
        message: 'Enter email address',
        duration: const Duration(seconds: 3),
      );
    } else if (passwordController.text == '') {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Invalid Input',
        message: 'Enter Password',
        duration: const Duration(seconds: 3),
      );
    } else {
      signInRest();
    }
  }

// Initially password is obscured
  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }
}
