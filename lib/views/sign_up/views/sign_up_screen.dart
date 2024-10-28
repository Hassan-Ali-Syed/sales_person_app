import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/routes/app_routes.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/views/sign_up/controller/sign_up_controller.dart';
import 'package:sales_person_app/widgets/custom_elevated_button.dart';
import 'package:sales_person_app/widgets/custom_textfield.dart';
import 'package:sales_person_app/widgets/custom_appbar.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});
  static const String routeName = '/Sign_up_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.signUpScaffoldKey,
      appBar: customAppBar(
        context: context,
        automaticallyImplyLeading: true,
        appBarColor: LightTheme.scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.PADDING_24, vertical: Sizes.PADDING_30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.HI,
                style: context.titleLarge.copyWith(
                  color: const Color(0xff58595B),
                ),
              ),
              Text(
                AppStrings.CREATE_NEW_ACCOUNT,
                style: context.bodyLarge.copyWith(
                  color: const Color(0xff58595B),
                ),
              ),
              const SizedBox(
                height: Sizes.HEIGHT_42,
              ),
              const CustomTextField(
                hintText: AppStrings.EMAIL,
              ),
              const Padding(
                padding: EdgeInsets.only(top: Sizes.PADDING_6),
                child: CustomTextField(
                  hintText: AppStrings.NAME,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: Sizes.PADDING_6),
                child: CustomTextField(
                  keyBoardType: TextInputType.number,
                  hintText: AppStrings.PH_NUMBER,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Sizes.PADDING_6),
                child: Obx(
                  () => CustomTextField(
                    hintText: AppStrings.PASSWORD,
                    obscureText: controller.isObscurePaswword.value,
                    suffixIcon: GestureDetector(
                      onTap: controller.togglePasswordObscure,
                      child: controller.isObscurePaswword.value
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                ),
              ),
              Obx(
                () => CustomTextField(
                  hintText: AppStrings.CONFIRM_PASSWORD,
                  obscureText: controller.isObscureConfirmPaswword.value,
                  suffixIcon: GestureDetector(
                    onTap: controller.toggleConfirmPasswordObscure,
                    child: controller.isObscureConfirmPaswword.value
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: Sizes.PADDING_44, bottom: Sizes.PADDING_80),
                child: CustomElevatedButton(
                  title: AppStrings.SEND_REQUEST,
                  onPressed: () {},
                  minHeight: Sizes.HEIGHT_30,
                  minWidht: double.maxFinite,
                ),
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: AppStrings.ALREADY_HAVE_AN_ACCOUNT,
                    style: context.titleSmall.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff0A0A0B),
                        fontSize: Sizes.TEXT_SIZE_16),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.offNamed(AppRoutes.SIGN_IN);
                          },
                        text: AppStrings.SIGN_IN,
                        style: context.titleSmall.copyWith(
                            color: const Color(
                              0xff003772,
                            ),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
