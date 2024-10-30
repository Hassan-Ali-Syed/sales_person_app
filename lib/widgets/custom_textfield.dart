// import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.suffixIcon,
      this.obscureText = false,
      this.keyBoardType,
      this.controller,
      this.readOnly = false});
  final String hintText;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyBoardType;
  final bool readOnly;
  final TextEditingController? controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      // log('Focus changed: ${_focusNode.hasFocus}');
      setState(() {});
    });
    widget.controller?.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool shouldShowLabel = (widget.controller?.text.isNotEmpty ?? false);
    return TextField(
      readOnly: widget.readOnly,
      controller: widget.controller,
      focusNode: _focusNode,
      style: context.bodySmall.copyWith(
        fontSize: Sizes.TEXT_SIZE_16,
        fontWeight: FontWeight.w400,
        color: const Color(0xff58595B),
      ),
      keyboardType: widget.keyBoardType ?? TextInputType.text,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
          floatingLabelBehavior: shouldShowLabel
              ? FloatingLabelBehavior.always
              : FloatingLabelBehavior.auto,
          floatingLabelStyle: context.titleLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xff939598),
          ),
          label: Text(
            widget.hintText,
            style: context.titleSmall.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xff939598),
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff7C7A7A),
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff7C7A7A),
            ),
          ),
          suffixIcon: widget.suffixIcon),
    );
  }
}
