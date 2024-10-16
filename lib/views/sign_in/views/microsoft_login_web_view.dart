
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/services/api/api_constants.dart';
import 'package:sales_person_app/views/sign_in/views/microsoft_login_loading.dart';
import 'package:webview_flutter/webview_flutter.dart';


class MicrosoftLoginWebView extends StatefulWidget {
  const MicrosoftLoginWebView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MicrosoftLoginWebViewState createState() => _MicrosoftLoginWebViewState();
}

class _MicrosoftLoginWebViewState extends State<MicrosoftLoginWebView> {
  bool call = false;
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(
      const Color(0x00000000),
    )
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {
          Uri uri = Uri.parse(url);
          if (url.contains("login.microsoftonline.com") == false) {
            Get.to(
              () => MicrosoftLoginLoading(token: uri.queryParameters['code']!),
            );
          }
        },
        onWebResourceError: (WebResourceError error) {},
      ),
    )
    ..loadRequest(
      Uri.parse(ApiConstants.MICROSOFT_LOGIN),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}

