import 'package:flutter/material.dart';
import 'package:sales_person_app/constants/constants.dart';

class MorePageScreen extends StatelessWidget {
  static const String routeName = '/more_page_screen';
  const MorePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.maxFinite,
        ),
        Text(AppStrings.COMING_SOON),
      ],
    );
  }
}
