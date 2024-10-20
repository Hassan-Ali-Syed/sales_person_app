import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sales_person_app/extensions/context_extension.dart';

class CustomTextField extends StatefulWidget {
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
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      log('Focus changed: ${_focusNode.hasFocus}');
      setState(() {});
    });
    widget.controller?.addListener(() {
      setState(() {}); // Rebuild when the text in the controller changes
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
      focusNode: _focusNode,
      style: context.titleMedium.copyWith(
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
          hintStyle: context.titleSmall.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xff939598),
          ),
          hintText: widget.hinttext,
          label: Text(
            widget.hinttext,
            style: context.titleSmall.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xff939598),
            ),
          ),
          focusedBorder: const UnderlineInputBorder(),
          enabledBorder: const UnderlineInputBorder(),
          suffixIcon: widget.suffixIcon),
    );
  }
}
