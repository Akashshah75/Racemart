import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:racemart_app/Utils/app_color.dart';

import '../../Utils/app_asset.dart';

class NotificationListPage extends StatelessWidget {
  const NotificationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: appBg,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: blackColor),
        elevation: 0,
        backgroundColor: white,
        title: Text(
          'Notification',
          style: GoogleFonts.lato(
              fontSize: 16,
              color: blackColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2),
        ),
      ),
      body: const Center(
        child: Text("Don't have any notification!!"),
      ),
    );
  }
}

class BodyOfNotificationPage extends StatelessWidget {
  const BodyOfNotificationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 105,
          width: double.infinity,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageContainer(),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Names'),
                      SizedBox(height: 10),
                      NamesContainer(),
                      SizedBox(height: 10),
                      NamesContainer(),
                    ],
                  ),
                ],
              ),

              // Image.asset(demo, width: 50),
            ],
          ),
        ),
      ],
    );
  }
}

class NamesContainer extends StatelessWidget {
  const NamesContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Last Registration Date:',
          style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const Text('5 Sep 2023'),
      ],
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
          color: blueColor, borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          demo,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
