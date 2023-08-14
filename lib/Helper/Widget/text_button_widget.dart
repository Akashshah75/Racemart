import 'package:flutter/material.dart';
import 'package:racemart_app/Helper/Widget/text_widget.dart';

import '../../utils/app_color.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    super.key,
    required this.text,
    required this.pres,
    this.isLoading = false,
  });
  final String text;
  final VoidCallback pres;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: blueColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: isLoading
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : TextButton(
                onPressed: pres,
                child: TextWidget(
                  text: text,
                  color: whiteColor,
                ),
              ),
      ),
    );
  }
}
