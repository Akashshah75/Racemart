import 'package:flutter/material.dart';

import '../../../Helper/Widget/heading_text.dart';
import '../../../utils/app_color.dart';

class DistanceContainer extends StatelessWidget {
  const DistanceContainer({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 10 - 8, vertical: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: greyColor.withAlpha(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadingText(
            fontSize: 16,
            text: title,
            color: blueColor.withAlpha(200),
          ),
          const Divider(),
          const Row(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
