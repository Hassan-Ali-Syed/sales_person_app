import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/routes/app_routes.dart';
import 'package:sales_person_app/views/sign_in/controller/sign_in_controller.dart';
import 'package:sales_person_app/widgets/custom_elevated_button.dart';
import 'package:sales_person_app/widgets/custom_appbar.dart';

class SignInScreen extends GetView<SignInController> {
  static const String routeName = '/sign_in_screen';
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.signInScaffoldKey,
      appBar: customAppBar(context: context, automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.PADDING_16, vertical: Sizes.PADDING_30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.WELCOME,
                style: context.titleLarge.copyWith(
                  color: const Color(0xff2B2829),
                ),
              ),
              const SizedBox(
                height: Sizes.HEIGHT_6,
              ),
              Text(
                AppStrings.SIGN_IN_TO_CONTINUE,
                style: context.bodyLarge.copyWith(
                  color: const Color(0xff433E3F),
                ),
              ),
              const SizedBox(
                height: Sizes.HEIGHT_62,
              ),
              TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  floatingLabelStyle: const TextStyle(
                    color: Color(0xff7C7A7A),
                    fontSize: 24,
                  ),
                  labelText: AppStrings.EMAIL,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Sizes.RADIUS_8),
                    borderSide: const BorderSide(
                      color: Color(0xff7C7A7A),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Sizes.RADIUS_8),
                    borderSide: const BorderSide(
                      color: Color(0xff7C7A7A),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Sizes.PADDING_18),
                child: Obx(
                  () => TextField(
                    controller: controller.passwordController,
                    obscureText: controller.isObscure.value,
                    decoration: InputDecoration(
                      floatingLabelStyle: const TextStyle(
                        color: Color(0xff7C7A7A),
                        fontSize: 24,
                      ),
                      labelText: AppStrings.PASSWORD,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Sizes.RADIUS_8),
                        borderSide: const BorderSide(
                          color: Color(0xff7C7A7A),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Sizes.RADIUS_8),
                        borderSide: const BorderSide(
                          color: Color(0xff7C7A7A),
                        ),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () => controller.isObscure.value =
                            !controller.isObscure.value,
                        child: controller.isObscure.value
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
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
                    bottom: Sizes.PADDING_60, top: Sizes.PADDING_6),
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
                      onTap: () {},
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
