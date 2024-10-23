import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sales_person_app/constants/constants.dart';

class CalenderDateWidget extends StatelessWidget {
  const CalenderDateWidget({
    super.key,
    this.rightMargin,
    required this.day,
    required this.date,
  });
  final double? rightMargin;
  final String day;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Sizes.PADDING_4),
          child: Text(
            day,
            style: GoogleFonts.inter(
              fontSize: Sizes.TEXT_SIZE_12,
              fontWeight: FontWeight.w400,
              color: const Color(0xff58595B),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: Sizes.MARGIN_6, right: rightMargin ?? Sizes.MARGIN_20),
          height: Sizes.HEIGHT_32,
          width: Sizes.WIDTH_32,
          decoration: BoxDecoration(
            color: const Color(0xffE9E8E7),
            borderRadius: BorderRadius.circular(Sizes.RADIUS_6),
          ),
          child: Center(
            child: Text(
              date,
              style: GoogleFonts.inter(
                fontSize: Sizes.TEXT_SIZE_12,
                fontWeight: FontWeight.w400,
                color: const Color(0xff58595B),
              ),
            ),
          ),
        )
      ],
    );
  }
}