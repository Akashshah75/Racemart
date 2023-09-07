import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Pages/Push%20Notification/notification_detail_page.dart';

import '../../../../Provider/notifications/notifications_provider.dart';
import '../../../../Utils/app_asset.dart';
import '../../../../Utils/app_color.dart';

class BodyOfNotificationPage extends StatelessWidget {
  const BodyOfNotificationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final notificationProvider =
        Provider.of<NotificationProvider>(context, listen: true);
    return notificationProvider.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: notificationProvider.notificationData.length,
            itemBuilder: (context, index) {
              final dataOfNotification =
                  notificationProvider.notificationData[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NotificationDetailPage(
                        eventId: dataOfNotification['id']),
                  ));
                },
                child: NotificationContainer(data: dataOfNotification),
              );
            },
          );
  }
}

class NotificationContainer extends StatelessWidget {
  const NotificationContainer({
    super.key,
    this.data,
  });
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 105,
      width: double.infinity,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageContainer(
                imageUrl: data['image'],
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 10),
                  SizedBox(
                    width: 250,
                    // height: ,
                    child: Text(
                      // 'asdf asd sdf werf asdv erg wefg 2erg qwdcv sdfgh wertgh werghj sdfgh',
                      data['title'].toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  // SizedBox(height: 4),
                  const NamesContainer(),
                  // const SizedBox(height: 10),
                  // const NamesContainer(),
                ],
              ),
            ],
          ),
        ],
      ),
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
    required this.imageUrl,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
          color: blueColor, borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: imageUrl.isNotEmpty
            ? Image.network(imageUrl, fit: BoxFit.cover)
            : Image.asset(
                demo,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
