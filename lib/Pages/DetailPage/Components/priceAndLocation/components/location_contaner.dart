import 'package:flutter/material.dart';

import '../../../../../Helper/Widget/text_widget.dart';
import '../../../../../Utils/app_color.dart';
import '../../../../../Utils/app_size.dart';

class LoctionContair extends StatelessWidget {
  const LoctionContair({
    super.key,
    required this.location,
  });
  final String location;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding / 2,
      child: Row(
        children: [
          const Icon(
            Icons.location_on,
            color: redColor,
            size: 18,
          ),
          TextWidget(
            color: greyTextColor,
            fontSize: 14,
            text: location, // 'Location',
          ),
        ],
      ),
    );
  }
}
