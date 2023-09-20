import 'package:flutter/material.dart';

import '../../Utils/app_color.dart';

class CustomeTextField extends StatelessWidget {
  const CustomeTextField({
    super.key,
    required this.hintText,
    this.icon = Icons.person,
    this.maxLine = 1,
    this.textInputType = TextInputType.none,
    required this.controller,
    this.pres,
    this.readOnly = false,
    this.radius = 12,
    this.iconColor = redColor,
  });
  final String hintText;
  final IconData icon;
  final int maxLine;
  final TextInputType textInputType;
  final TextEditingController controller;
  final VoidCallback? pres;
  final bool readOnly;
  final double radius;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: blueColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: TextFormField(
        readOnly: readOnly,
        onTap: pres,
        controller: controller,
        maxLines: maxLine,
        keyboardType: textInputType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          suffixIcon: Icon(
            icon,
            color: iconColor,
          ),
          // iconColor: blueColor,
          hintStyle: TextStyle(
            color: greyColor.withOpacity(0.6),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
    );
  }
}

class MultiLineTextBox extends StatelessWidget {
  const MultiLineTextBox({
    super.key,
    required this.hintText,
    this.maxLine = 1,
    this.textInputType = TextInputType.none,
    required this.controller,
    this.autoFocus = false,
  });
  final String hintText;

  final int maxLine;
  final TextInputType textInputType;
  final TextEditingController controller;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: blueColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: TextFormField(
        autofocus: autoFocus,
        controller: controller,
        maxLines: maxLine,
        keyboardType: textInputType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: greyColor.withOpacity(0.6),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        ),
      ),
    );
  }
}
