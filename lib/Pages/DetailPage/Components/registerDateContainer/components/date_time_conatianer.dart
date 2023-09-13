import 'package:flutter/material.dart';

import '../../../../../Helper/Widget/text_widget.dart';
import '../../../../../utils/app_color.dart';

class DateTimeContainer extends StatelessWidget {
  const DateTimeContainer({
    super.key,
    required this.title,
    required this.date,
  });

  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.calendar_month,
          size: 16,
          color: blackColor.withAlpha(150),
        ),
        const SizedBox(width: 5),
        TextWidget(
          fontSize: 14,
          text: '$title:',
          color: blackColor.withAlpha(150),
        ),
        const SizedBox(width: 10),
        TextWidget(
          fontSize: 14,
          text: date,
          color: blueColor.withAlpha(150),
        ),
      ],
    );
  }
}
