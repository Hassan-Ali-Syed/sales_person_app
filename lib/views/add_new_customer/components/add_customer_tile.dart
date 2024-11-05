import 'package:flutter/material.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';

class AddCustomerTile extends StatelessWidget {
  const AddCustomerTile(
      {super.key, this.onTap, required this.title, required this.icon});

  final void Function()? onTap;
  final String title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.PADDING_10),
        height: Sizes.HEIGHT_46,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0.3,
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
          color: const Color(0xff979797),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: context.bodySmall.copyWith(
                    color: Colors.white,
                    fontSize: Sizes.TEXT_SIZE_18,
                    fontWeight: FontWeight.w600),
              ),
              icon,
            ],
          ),
        ),
      ),
    );
  }
}
