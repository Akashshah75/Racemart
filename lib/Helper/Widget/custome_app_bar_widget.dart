import 'package:flutter/material.dart';
import 'package:racemart_app/Provider/profile/profile_provider.dart';

class CustomeAppBarWidget extends StatelessWidget {
  const CustomeAppBarWidget({
    super.key,
    required this.title,
    required this.controller,
  });
  final String title;
  final ProfileProvider controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              controller.clearText();
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 20,
            ),
          ),
          const SizedBox(width: 50),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
