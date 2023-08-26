import 'package:flutter/material.dart';

import '../../../../../Helper/Widget/heading_text.dart';
import '../../../../../Helper/Widget/text_widget.dart';
import '../../../../../Utils/app_color.dart';

class SimilarListingtContainer extends StatelessWidget {
  const SimilarListingtContainer({
    super.key,
    this.data,
    required this.width,
  });
  final dynamic data;
  final double width;

  @override
  Widget build(BuildContext context) {
    final String titleLength = data['title'];
    // print(titleLength.length);
    return Container(
      width: width,
      // height: 300,
      margin: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 40,
          bottom: titleLength.length > 23
              ? 70
              : titleLength.length > 46
                  ? 90
                  : 70),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: blackColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              // color: redColor,
              color: whiteColor.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    data['poster'],
                  )
                  // AssetImage(demo),
                  ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: HeadingText(
              text: data['title'] ?? '...',
              fontSize: 16,
              color: blackColor,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 6),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 18,
                  color: redColor,
                ),
                const SizedBox(width: 6),
                //
                TextWidget(
                  text: data['city'] ?? 'Location',
                  color: greyColor,
                  fontSize: 15,
                  weight: FontWeight.w800,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
