import 'package:flutter/material.dart';

import '../../Utils/app_color.dart';

class HeadingText extends StatelessWidget {
  const HeadingText({
    super.key,
    required this.text,
    this.color = blackColor,
    this.fontSize = 22,
  });
  final String text;
  final Color color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        letterSpacing: 1.5,
        color: color,
      ),
    );
  }
}

class CompareEventHeadingText extends StatelessWidget {
  const CompareEventHeadingText({
    super.key,
    required this.text,
    this.fontSize = 14,
  });
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        letterSpacing: 1.5,
        color: blueColor,
      ),
    );
  }
}
