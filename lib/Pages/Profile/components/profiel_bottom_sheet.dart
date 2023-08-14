import 'package:flutter/material.dart';

import '../../../Helper/Widget/custome_app_bar_widget.dart';
import '../../../Helper/Widget/custome_textfield.dart';
import '../../../Helper/Widget/text_button_widget.dart';
import '../../../Provider/profile/profile_provider.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet(
      {super.key, required this.h, required this.controller});
  final double h;
  final ProfileProvider controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: h * 0.75,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomeAppBarWidget(
            title: 'Edit Profile',
            controller: controller,
          ),
          const Divider(),
          const SizedBox(height: 20),
          CustomeTextField(
            hintText: 'Name',
            controller: controller.name,
            textInputType: TextInputType.name,
          ),
          const SizedBox(height: 10),
          CustomeTextField(
            hintText: 'Email',
            icon: Icons.email,
            textInputType: TextInputType.emailAddress,
            controller: controller.email,
          ),
          const SizedBox(height: 10),
          CustomeTextField(
            hintText: 'Mobile no',
            icon: Icons.phone_android,
            textInputType: TextInputType.number,
            controller: controller.mobileNo,
          ),
          const SizedBox(height: 10),
          //
          const SizedBox(height: 15),
          TextButtonWidget(
            text: 'Submit',
            pres: () {
              controller.editProfile(context);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
