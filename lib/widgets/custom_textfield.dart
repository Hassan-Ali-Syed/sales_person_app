import 'package:flutter/material.dart';
import 'package:sales_person_app/constants/constants.dart';

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
          floatingLabelStyle: const TextStyle(
            color:
                Color(0xff7C7A7A), // Customize the label color when it floats
            fontSize: 24, // Customize the font size
          ),
          labelText: hinttext,
          hintText: hinttext,
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
          suffixIcon: suffixIcon),
    );
  }
}
