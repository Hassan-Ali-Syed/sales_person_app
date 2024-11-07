import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/themes/themes.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  const ShimmerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          // Shimmer effect for the first container
          Container(
            padding: const EdgeInsets.only(
              top: Sizes.PADDING_56,
              left: Sizes.PADDING_18,
              right: Sizes.PADDING_14,
              bottom: Sizes.PADDING_12,
            ),
            height: Sizes.HEIGHT_150,
            color: LightTheme.appBarBackgroundColor,
            child: Column(
              children: [
                // Row 1 with text and icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      height: 20,
                      color: Colors.white,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: Sizes.PADDING_10),
                // Row 2 with three shimmer containers
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: Sizes.HEIGHT_42,
                      color: Colors.white,
                    ),
                    const SizedBox(width: Sizes.PADDING_8),
                    Container(
                      width: 50,
                      height: Sizes.HEIGHT_42,
                      color: Colors.white,
                    ),
                    const SizedBox(width: Sizes.PADDING_8),
                    Container(
                      width: 30,
                      height: Sizes.HEIGHT_42,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Shimmer effect for the second container with a row of 7 boxes
          Padding(
            padding: const EdgeInsets.all(Sizes.PADDING_24),
            child: Row(
              children: List.generate(
                7,
                (index) => Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: Sizes.HEIGHT_80,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // Shimmer effect for the third container
          Container(
            padding: const EdgeInsets.all(Sizes.PADDING_24),
            height: Sizes.HEIGHT_60,
            color: LightTheme.appBarBackgroundColor,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 20,
                width: 100,
                color: Colors.white,
              ),
            ),
          ),

          // Shimmer effect for the last box in the bottom
          SizedBox(
            height: Sizes.HEIGHT_62,
            child: Center(
              child: Container(
                height: 20,
                width: 200,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
