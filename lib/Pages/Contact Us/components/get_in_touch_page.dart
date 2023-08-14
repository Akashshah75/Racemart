import 'package:flutter/material.dart';

import '../../../Utils/app_color.dart';
import '../../../Utils/app_size.dart';
import '../../Home/DetailPage/Components/how_to_reac_container.dart';
import 'contact_data_contaner.dart';

class GetInTouchPage extends StatelessWidget {
  const GetInTouchPage({
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
              const SizedBox(height: 10),
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
                        text: 'YouTooCanRun Sports Management Pvt \nLtd ',
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
              //
              // Container(
              //   padding: defaultSymetricPeding,
              //   width: double.infinity,
              //   height: 50,
              //   decoration: BoxDecoration(
              //     color: whiteColor,
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: const Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         'Send Message',
              //         style: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w400,
              //           letterSpacing: 1.2,
              //         ),
              //       ),
              //       Icon(Icons.arrow_right_alt_outlined),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
