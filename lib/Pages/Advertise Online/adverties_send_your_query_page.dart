import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Helper/Widget/custome_textfield.dart';
import '../../Helper/Widget/text_button_widget.dart';
import '../../Provider/adverties/adverties_provider.dart';

class AdvertiesSendQueryPage extends StatelessWidget {
  const AdvertiesSendQueryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AdveriesProvider>(context, listen: true);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomeTextField(
              hintText: 'Name',
              textInputType: TextInputType.name,
              controller: controller.name,
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
            CustomeTextField(
              hintText: 'Company',
              textInputType: TextInputType.name,
              icon: Icons.mail,
              controller: controller.company,
            ),
            const SizedBox(height: 10),
            MultiLineTextBox(
              hintText: 'Your message',
              maxLine: 10,
              textInputType: TextInputType.name,
              controller: controller.message,
            ),
            const SizedBox(height: 15),
            controller.downloadProgress != null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : TextButtonWidget(
                    text: 'Download Report',
                    pres: () {
                      controller.userRegistration(context);
                      //
                    },
                  )
          ],
        ),
      ),
    );
  }
}
