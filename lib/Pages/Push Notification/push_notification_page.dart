import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:racemart_app/Utils/app_color.dart';

class NotificationListPage extends StatelessWidget {
  const NotificationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: const Column(),
    );
  }
}
