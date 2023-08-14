import 'package:flutter/material.dart';
import 'package:racemart_app/Provider/profile/profile_provider.dart';

import '../../../Helper/Widget/custome_app_bar_widget.dart';
import '../../../Helper/Widget/password_test_filed.dart';
import '../../../Helper/Widget/text_button_widget.dart';

class ChangePasswordBottomSheet extends StatelessWidget {
  const ChangePasswordBottomSheet(
      {super.key, required this.h, required this.controller});
  final double h;
  final ProfileProvider controller;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: h * 0.73,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            CustomeAppBarWidget(
              title: 'Change Password',
              controller: controller,
            ),
            const Divider(),
            const SizedBox(height: 20),
            PasswordTextField(
              text: 'Current Password',
              controller: controller.password,
            ),
            const SizedBox(height: 10),
            PasswordTextField(
              text: 'New Password',
              controller: controller.newPassword,
            ),
            const SizedBox(height: 10),
            PasswordTextField(
              text: 'Confirm Password',
              controller: controller.confirmNewPassword,
            ),
            const SizedBox(height: 20),
            TextButtonWidget(
              text: 'Update',
              pres: () {
                controller.changePassword(context);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
