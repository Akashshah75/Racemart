import 'package:flutter/material.dart';

import '../../../../Helper/Widget/text_widget.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/app_size.dart';
import 'registration_now_container.dart';

class LocationAndRegisterNowContainer extends StatelessWidget {
  const LocationAndRegisterNowContainer({
    super.key,
    required this.location,
    required this.registrationUrl,
  });
  final String location;
  final String registrationUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
          //
          RegisternowBtn(url: registrationUrl)
        ],
      ),
    );
  }
}
