import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/contact%20us/contact_us_provider.dart';

import '../../../Helper/Widget/custome_textfield.dart';
import '../../../Helper/Widget/text_button_widget.dart';

class DroupUsLinePage extends StatelessWidget {
  const DroupUsLinePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ContactUsProvider>(context, listen: true);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomeTextField(
              hintText: 'Name',
              controller: controller.name,
              textInputType: TextInputType.name,
            ),
            const SizedBox(height: 10),
            CustomeTextField(
              hintText: 'Email',
              icon: Icons.mail,
              textInputType: TextInputType.emailAddress,
              controller: controller.email,
            ),
            const SizedBox(height: 10),
            CustomeTextField(
              hintText: 'Mobile',
              icon: Icons.phone_android,
              textInputType: TextInputType.number,
              controller: controller.mobileNo,
            ),
            const SizedBox(height: 10),
            CustomeTextField(
              hintText: 'Subject',
              textInputType: TextInputType.name,
              icon: Icons.edit,
              controller: controller.subject,
            ),
            const SizedBox(height: 10),
            MultiLineTextBox(
              hintText: 'Your message',
              maxLine: 10,
              textInputType: TextInputType.name,
              controller: controller.message,
            ),
            const SizedBox(height: 15),
            TextButtonWidget(
              text: 'Send Message',
              pres: () {
                controller.sendContactUsMessage(context);
              },
              isLoading: controller.isLoading,
            )
          ],
        ),
      ),
    );
  }
}
