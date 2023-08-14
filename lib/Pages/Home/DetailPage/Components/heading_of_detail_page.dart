import 'package:flutter/material.dart';
import '../../../../Helper/Widget/heading_text.dart';
import '../../../../Utils/app_color.dart';

class HedingOfDetailPage extends StatelessWidget {
  const HedingOfDetailPage({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: HeadingText(
        fontSize: 16,
        text: title, // 'MG VADODARA MARATHON 2024',
        color: blackColor,
      ),
    );
  }
}
