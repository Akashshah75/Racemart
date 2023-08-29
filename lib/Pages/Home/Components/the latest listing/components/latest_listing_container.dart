import 'package:flutter/material.dart';

import '../../../../../Helper/Widget/heading_text.dart';
import '../../../../../Helper/Widget/text_widget.dart';
import '../../../../../Utils/app_color.dart';

class LatestListingContainer extends StatelessWidget {
  const LatestListingContainer({
    super.key,
    this.data,
  });
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(color: blackColor.withOpacity(0.1)),
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(data['poster']),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10),
            child: HeadingText(
                fontSize: 16,
                text: data['title'], //'Heading',
                color: redColor //blueColor,
                ),
          ),
          //
          const SizedBox(height: 10),
          Container(
            width: 350,
            margin: const EdgeInsets.only(bottom: 10, left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on,
                  size: 15,
                  color: redColor,
                ),
                const SizedBox(width: 2),
                TextWidget(
                  fontSize: 14,
                  text: data['city'], // 'location',
                  color: blueColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
