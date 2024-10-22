import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/routes/app_routes.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/views/sign_in/controller/sign_in_controller.dart';
import 'package:sales_person_app/views/sign_in/views/microsoft_login_web_view.dart';
import 'package:sales_person_app/widgets/custom_elevated_button.dart';
import 'package:sales_person_app/widgets/custom_appbar.dart';
import 'package:sales_person_app/widgets/custom_textfield.dart';

class SignInScreen extends GetView<SignInController> {
  static const String routeName = '/sign_in_screen';
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.signInScaffoldKey,
      appBar: customAppBar(
        backButton: false,
        context: context,
        automaticallyImplyLeading: false,
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
                AppStrings.WELCOME,
                style: context.titleLarge.copyWith(
                  color: const Color(0xff58595B),
                ),
              ),
              Text(
                AppStrings.SIGN_IN_TO_CONTINUE,
                style: context.bodyLarge.copyWith(
                  color: const Color(0xff58595B),
                ),
              ),
              const SizedBox(
                height: Sizes.HEIGHT_62,
              ),
              CustomTextField(
                hinttext: AppStrings.EMAIL,
                controller: controller.emailController,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: Sizes.PADDING_6, bottom: Sizes.PADDING_44),
                child: Obx(
                  () => CustomTextField(
                    hinttext: AppStrings.PASSWORD,
                    controller: controller.passwordController,
                    obscureText: controller.isObscure.value,
                    suffixIcon: GestureDetector(
                      onTap: controller.toggleObscure,
                      child: controller.isObscure.value
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                ),
              ),
              CustomElevatedButton(
                minHeight: Sizes.HEIGHT_30,
                minWidht: double.maxFinite,
                title: AppStrings.SIGN_IN,
                onPressed: () {
                  controller.signInMethod();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: Sizes.PADDING_60,
                    top: Sizes.PADDING_6,
                    right: Sizes.PADDING_6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        AppStrings.FORGOT_PASSWORD,
                        style: context.titleSmall.copyWith(
                            color: const Color(0xff0A0A0B),
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: Text(
                  AppStrings.SIGN_IN_WITH,
                  style: context.titleSmall.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff0A0A0B),
                      fontSize: Sizes.TEXT_SIZE_18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Sizes.PADDING_54,
                    right: Sizes.PADDING_54,
                    top: Sizes.PADDING_36,
                    bottom: Sizes.PADDING_80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        AppAssets.getPNGIcon(AppAssets.GOOGLE_LOGO),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.apple_outlined,
                        color: AppColors.black,
                        size: Sizes.HEIGHT_60,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Get.to(() {
                          return const MicrosoftLoginWebView();
                        });
                      },
                      child: Image.asset(
                        AppAssets.getPNGIcon(AppAssets.MICROSOFT_LOGO),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: AppStrings.AUTH_USER_SIGN_UP,
                    style: context.titleSmall.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff0A0A0B),
                        fontSize: Sizes.TEXT_SIZE_16),
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(AppRoutes.SIGN_UP);
                          },
                        text: AppStrings.HERE,
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
