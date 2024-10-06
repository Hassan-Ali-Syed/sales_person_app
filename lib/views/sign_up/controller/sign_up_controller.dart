import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final GlobalKey<ScaffoldState> signUpScaffoldKey = GlobalKey<ScaffoldState>();

// Initially password is obscured
  RxBool isObscurePaswword = true.obs;
  RxBool isObscureConfirmPaswword = true.obs;

  // Method to toggle password visibility
  void togglePasswordObscure() {
    isObscurePaswword.value = !isObscurePaswword.value;
  }

  // Method to toggle Confirm password visibility
  void toggleConfirmPasswordObscure() {
    isObscureConfirmPaswword.value = !isObscureConfirmPaswword.value;
  }
}
