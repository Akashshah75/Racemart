import 'package:flutter/material.dart';

import '../../../Utils/app_size.dart';
import '../../../utils/app_color.dart';

class ProfileEditDataRowContainer extends StatelessWidget {
  const ProfileEditDataRowContainer({
    super.key,
    required this.title,
    required this.icon,
    required this.press,
  });
  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: defaultSymetricPeding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 1.3,
                ),
              ),
              Icon(
                icon,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
