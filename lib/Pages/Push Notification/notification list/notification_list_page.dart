import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../Provider/Home providers/home_page_provider.dart';
import '../../../Provider/notifications/notifications_provider.dart';
import '../../../Utils/app_color.dart';
import 'components/body_of_notification_page.dart';

class NotificationListPage extends StatefulWidget {
  const NotificationListPage({super.key});

  @override
  State<NotificationListPage> createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final notificationProvider =
          Provider.of<NotificationProvider>(context, listen: false);
      notificationProvider.fetchNotificationData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);
    final notificationProvider =
        Provider.of<NotificationProvider>(context, listen: true);
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
        actions: [
          IconButton(
            onPressed: () {
              homeProvider.chageListToGrid();
            },
            icon: Icon(
              homeProvider.isList ? Icons.grid_view : Icons.list,
              color: blackColor,
            ),
          )
        ],
      ),
      body: BodyOfNotificationPage(notificationProvider: notificationProvider),
    );
  }
}
