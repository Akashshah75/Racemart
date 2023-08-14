import 'package:flutter/material.dart';

import '../../Utils/app_color.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.text,
    required this.controller,
  });
  final String text;
  final TextEditingController controller;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool active = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: blueColor.withOpacity(0.3),
          // color: greyColor.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: active,
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: IconButton(
            splashColor: blueColor.withOpacity(0.1),
            onPressed: () {
              setState(() {
                active = !active;
              });
            },
            icon: active
                ? Icon(
                    Icons.visibility,
                    color: blueColor,
                  )
                : Icon(
                    Icons.visibility_off,
                    color: blueColor,
                  ),
          ),
          hintText: widget.text,
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
