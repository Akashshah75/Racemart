import 'package:flutter/material.dart';

import '../../Utils/app_color.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
    this.color = blackColor,
    this.fontSize = 16,
    this.letterSpacing = 1.5,
    this.weight = FontWeight.bold,
  });
  final String text;
  final Color color;
  final double fontSize;
  final double letterSpacing;
  final FontWeight weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: weight,
        fontFamily: 'Roboto',
        letterSpacing: 1.5,
        color: color,
      ),
    );
  }
}
