import 'package:flutter/material.dart';
import 'package:sales_person_app/constants/constants.dart';

class ContactPageTextField extends StatelessWidget {
  const ContactPageTextField(
      {super.key,
      required this.hintText,
      this.isSuffixIcon = false,
      this.onPressed,
      required this.controller,
      this.onSubmitted,
      this.onChanged});
  final String hintText;
  final bool isSuffixIcon;
  final void Function()? onPressed;
  final TextEditingController controller;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.left,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: isSuffixIcon
              ? IconButton(
                  onPressed: onPressed,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    size: Sizes.WIDTH_30,
                    color: Colors.black,
                  ))
              : null),
    );
  }
}
