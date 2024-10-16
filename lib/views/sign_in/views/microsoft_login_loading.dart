import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/services/api/api_constants.dart';
import 'package:sales_person_app/services/api/base_client.dart';
import 'package:sales_person_app/views/sign_in/controller/sign_in_controller.dart';
import 'package:sales_person_app/widgets/custom_dialogue.dart';


class MicrosoftLoginLoading extends StatefulWidget {
  const MicrosoftLoginLoading({super.key, required this.token});

  final String token;
  @override
  State<MicrosoftLoginLoading> createState() => _MicrosoftLoginLoadingState();
}

class _MicrosoftLoginLoadingState extends State<MicrosoftLoginLoading> {
  final loginController = Get.find<SignInController>();
  Future<void> getUserData(String token) async {
    await BaseClient.safeApiCall(
      ApiConstants.MICROSOFT_USER_DATA,
      RequestType.get,
      headers: await BaseClient.generateHeaders(),
      queryParameters: {"MSID": token},
      onSuccess: (response) {
        if (response.data["success"]) {
          loginController.addUserLoginData(response.data);
        } else {
          Get.back();
          showCustomDialog(false, "${response.data["msg"]}");
        }
      },
      onLoading: () {},
      onError: (e) {
        Get.back();
      },
    );
  }

  @override
  void initState() {
    getUserData(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
