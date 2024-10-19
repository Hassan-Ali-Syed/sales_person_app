import 'package:flutter/material.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hinttext,
    this.suffixIcon,
    this.obscureText = false,
    this.keyBoardType,
    this.controller,
  });
  final String hinttext;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyBoardType;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyBoardType ?? TextInputType.text,
      obscureText: obscureText,
      decoration: InputDecoration(
          hintStyle: context.titleSmall.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xff939598),
          ),
          hintText: hinttext,
          focusedBorder: const UnderlineInputBorder(),
          enabledBorder: const UnderlineInputBorder(),
          suffixIcon: suffixIcon),
    );
  }
}
