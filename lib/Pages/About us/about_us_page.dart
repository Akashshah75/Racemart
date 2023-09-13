import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/about%20us/abpout_us_provider.dart';
import 'package:racemart_app/Utils/constant.dart';

import '../../Helper/Widget/text_widget.dart';
import '../../Utils/app_color.dart';
import '../Home/Drawer/zoom_drawer.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  void initState() {
    AboutUsProvider().initMethodOfAboutUs(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        final diffrence = DateTime.now().difference(timeBackPressed);
        final isExitWarning = diffrence >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        return exitTheAppMethod(isExitWarning);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteColor,
          title: const Text('About us', style: TextStyle(color: blackColor)),
          leading: const MenuWidget(),
        ),
        body: Consumer<AboutUsProvider>(
          builder: (context, value, child) {
            return value.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          HtmlWidget(value.aboutUsdata),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
//     Consumer<AboutUsProvider>(builder: (context, value, child) {
//    return  const Padding(
//     padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
//     child: SingleChildScrollView(
//       child: Column(
//         children: [

//               // HtmlWidget(value.aboutUsdata);

//           // DefaultAboutUs(size: size),
//         ],
//       ),
//     ),

// );

class DefaultAboutUs extends StatelessWidget {
  const DefaultAboutUs({
    super.key,
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size * 0.02),
          const TextWidget(
            text: 'RaceMart, The smarter way to choose your next race.',
            fontSize: 16,
            weight: FontWeight.w600,
            color: blackColor,
          ),
          SizedBox(height: size * 0.02),
          //
          Text(
            paragraph1,
            style: TextStyle(
              color: blackColor.withOpacity(.4),
              fontWeight: FontWeight.w200,
            ),
          ),
          SizedBox(height: size * 0.02),
          const TextWidget(
            text: 'For Participants',
            fontSize: 16,
            weight: FontWeight.w600,
            color: blackColor,
          ),
          SizedBox(height: size * 0.02),
          Text(
            paragraph2,
            style: TextStyle(
              color: blackColor.withOpacity(.4),
              fontWeight: FontWeight.w200,
            ),
          ),
          SizedBox(height: size * 0.02),
          AboutRowData(size: size, text: 'Number of Editions'),
          SizedBox(height: size * 0.01),
          AboutRowData(size: size, text: 'Number of Participants'),
          SizedBox(height: size * 0.01),
          AboutRowData(size: size, text: 'Event Organiser'),
          SizedBox(height: size * 0.01),
          AboutRowData(size: size, text: 'Registration and Backoffice Partner'),
          SizedBox(height: size * 0.01),
          AboutRowData(size: size, text: 'Timing Partner'),
          SizedBox(height: size * 0.01),
          AboutRowData(size: size, text: 'Accreditation, and'),
          SizedBox(height: size * 0.01),
          AboutRowData(size: size, text: 'More...'),
          SizedBox(height: size * 0.03),
          Text(
            paragraph3,
            style: TextStyle(
              color: blackColor.withOpacity(.4),
              fontWeight: FontWeight.w200,
            ),
          ),
          SizedBox(height: size * 0.02),
          const TextWidget(
            text: 'For Event Organisers',
            fontSize: 16,
            weight: FontWeight.w600,
            color: blackColor,
          ),
          SizedBox(height: size * 0.02),
          Text(
            paragraph4,
            style: TextStyle(
              color: blackColor.withOpacity(.4),
              fontWeight: FontWeight.w200,
            ),
          ),
          SizedBox(height: size * 0.02),
          const TextWidget(
            text: 'About YouTooCanRun',
            fontSize: 16,
            weight: FontWeight.w600,
            color: blackColor,
          ),
          SizedBox(height: size * 0.02),
          Text(
            paragraph5,
            style: TextStyle(
              color: blackColor.withOpacity(.4),
              fontWeight: FontWeight.w200,
            ),
          ),
          SizedBox(height: size * 0.02),
        ],
      ),
    );
  }
}

class AboutRowData extends StatelessWidget {
  const AboutRowData({
    super.key,
    required this.size,
    required this.text,
  });

  final double size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.adjust,
          color: blackColor.withOpacity(.4),
        ),
        SizedBox(width: size * 0.015),
        Text(
          text,
          style: TextStyle(
            color: blackColor.withOpacity(.4),
            fontWeight: FontWeight.w200,
          ),
        ),
      ],
    );
  }
}

var paragraph1 =
    'YouTooCanRun is proud to bring to you RaceMart, a directory of running events across India, with in-depth data of each race, which includes middle distances, half marathons, marathons and ultra marathons, that helps participants and organisers alike.';
var paragraph2 =
    'The marathon calendar as well as each event page on RaceMart is a detailed listing of the running events that helps participants select races of their choice. From middle distances, half marathons, marathons and ultra marathons, RaceMart covers running events occurring across cities all over India. Participants can select races, not only on Date, Distance and Location, but RaceMart takes the options for choice several steps ahead and also offers curated and verified content of each event such as';
var paragraph3 =
    'What’s more, RaceMart has also integrated a race rating and review system for each event so that participants can help fellow runners make appropriate choices. Race reviews help event organisers improve their future events, while differentiating better managed races from a growing number of events available to runners in India.';
var paragraph4 =
    "Organisers of Running Events get complete control of their event listing on RaceMart. They can add new events to the Race calendar or make changes to existing events as often as required so that participants get the latest and up to date information.Event Organisers can reach out to a targeted segment of participants who regularly visit the site for information on race events and register for races of their choice. Event Organisers can also boost registrations through banner ads prominently placed on RaceMart.";
var paragraph5 =
    'YouTooCanRun is a one-stop-shop for everything in running, that provides a complete range of solutions such as Race Management, Race Registration & Back Office platform, Event Calendar, E Commerce Shop, Runners Loyalty Program, Photo Tagging & Distribution, Brand Servicing, Trainers Tool and more.Since its inception in 2012, YouTooCanRun has successfully supported over 500 running events. YouTooCanRun has a dedicated team of specialists, majority of who are passionate runners, with cumulative experience of over 50 man years, across all aspects of running.';
