import 'package:flutter/material.dart';

import '../../../Utils/app_color.dart';

class ContactDataContainer extends StatelessWidget {
  const ContactDataContainer({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: textColor,
          fontWeight: FontWeight.w200,
          wordSpacing: 2,
        ),
      ),
    );
  }
}

var address =
    '3A, Valmiki, Next to Pharmacy College,Behind Kalina Muncipal School, Sunder Nagar,Kalina, Mumbai 400098';
var phoneNumber = '+91-xxxxxxx009';
var emailId = 'support@racemart.in';
var companyEmailId = 'sales@youtoocanrun.com';

class RowHedingContactInfo extends StatelessWidget {
  const RowHedingContactInfo({
    super.key,
    required this.text,
    required this.icon,
  });
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: redColor,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
