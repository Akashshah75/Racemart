import 'package:flutter/material.dart';

import '../../Utils/app_color.dart';
import '../../Utils/app_size.dart';
import '../Contact Us/components/contact_data_contaner.dart';
import '../Home/DetailPage/Components/how_to_reac_container.dart';

class AdvertiesGetInTouchPage extends StatelessWidget {
  const AdvertiesGetInTouchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: defaultSymetricPeding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 10),
              Container(
                padding: defaultSymetricPeding,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: defaultSymetricPeding,
                      child: Text(
                        advString,
                        style: TextStyle(
                          color: blueColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          // letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const RowHedingContactInfo(
                        text: 'Address :', icon: Icons.location_on),
                    const SizedBox(height: 5),
                    ContactDataContainer(text: address),
                    const SizedBox(height: 20),
                    const RowHedingContactInfo(
                        text: 'Phone :', icon: Icons.phone),
                    const SizedBox(height: 5),
                    ContactDataContainer(text: phoneNumber),
                    const SizedBox(height: 20),
                    const RowHedingContactInfo(
                        text: 'Mail:', icon: Icons.email),
                    const SizedBox(height: 5),
                    ContactDataContainer(text: emailId),
                    const SizedBox(height: 20),
                    const RowHedingContactInfo(
                        text: 'YouTooCanRun Sports Management Pvt \nLtd :',
                        icon: Icons.email),
                    const SizedBox(height: 5),
                    ContactDataContainer(text: companyEmailId),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        SocialMediaIconContainer(icon: Icons.facebook),
                        SizedBox(width: 20),
                        SocialMediaIconContainer(icon: Icons.g_mobiledata),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
