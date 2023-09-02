import 'package:flutter/material.dart';
import 'package:racemart_app/Helper/Widget/heading_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/app_color.dart';

class ComapreEventContainer extends StatelessWidget {
  const ComapreEventContainer({
    super.key,
    required this.width,
    required this.image,
    this.data,
    required this.eventTitleLength,
    required this.eventAddressLength,
  });

  final double width;
  final String image;
  final dynamic data;
  final int eventTitleLength;
  final int eventAddressLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: width * 0.332,
      decoration: BoxDecoration(
          border: Border.all(
        color: greyColor.withOpacity(0.1),
      )),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //poster
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 75,
                child: const CompareEventHeadingText(text: 'Poster'),
              ),
              const SizedBox(height: 10),
              //title
              Container(
                alignment: Alignment.center,
                height: eventTitleLength > 50
                    ? 120
                    : eventTitleLength > 30
                        ? 80
                        : 60,
                child: const CompareEventHeadingText(text: 'Title'),
              ),
              const Divider(),
              //Address
              Container(
                alignment: Alignment.center,
                height: 20,
                child: const CompareEventHeadingText(text: 'Address'),
              ),
              //Editions
              const Divider(),
              Container(
                alignment: Alignment.center,
                height: 20,
                child: const CompareEventHeadingText(text: 'Editions'),
              ),
              //city
              const Divider(),
              Container(
                alignment: Alignment.center,
                height: eventAddressLength > 30
                    ? 70
                    : eventAddressLength > 50
                        ? 80
                        : 60,
                child: const CompareEventHeadingText(text: 'City'),
              ),
              //location type
              const SizedBox(height: 10),
              const Divider(),
              const CompareEventHeadingText(text: 'Location type'),
              // Text(data['type'] ?? 'On-ground', style: customeTextStyle),
              //distancess
              const Divider(),
              Container(
                alignment: Alignment.center,
                height: 40,
                child: const CompareEventHeadingText(text: 'Distances'),
              ),
              const Divider(),
              // deliverables
              Container(
                alignment: Alignment.center,
                height: 45,
                child: const CompareEventHeadingText(text: 'Deliverables'),
              ),
              // //partners
              const Divider(),
              Container(
                alignment: Alignment.center,
                height: 80,
                child: const CompareEventHeadingText(text: 'Partners'),
              ),
              //Terrains
              const Divider(),
              Container(
                alignment: Alignment.center,
                height: 50,
                child: const CompareEventHeadingText(text: 'Terrains'),
              ),
              // //end event
              const Divider(),
              Container(
                alignment: Alignment.center,
                height: 40,
                child: const CompareEventHeadingText(text: 'Start Date'),
              ),
              // //end event
              const Divider(),
              Container(
                alignment: Alignment.center,
                height: 40,
                child: const CompareEventHeadingText(text: 'End Date'),
              ),
              //avg..rating
              const Divider(),
              Container(
                alignment: Alignment.center,
                height: 30,
                child: const CompareEventHeadingText(text: 'Rating'),
              ),
              //oragnasied
              const Divider(),
              Container(
                alignment: Alignment.center,
                height: 40,
                child: const CompareEventHeadingText(text: 'Oragnasied'),
              ),
              // //socila
              const Divider(),
              Container(
                alignment: Alignment.center,
                height: 40,
                child: const CompareEventHeadingText(text: 'Social media'),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
