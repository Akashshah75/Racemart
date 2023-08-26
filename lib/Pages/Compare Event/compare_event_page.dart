import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Utils/constant.dart';

import '../../Provider/compare event/compare_event_provider.dart';
import '../../Utils/app_asset.dart';
import '../../Utils/app_color.dart';
import '../Home/Drawer/zoom_drawer.dart';
import 'Components/compare_event_containers.dart';
import 'Components/compare_event_heder_container.dart';
import 'compare_event_search_screen.dart';

class CompareEventPage extends StatefulWidget {
  const CompareEventPage({super.key});

  @override
  State<CompareEventPage> createState() => _CompareEventPageState();
}

class _CompareEventPageState extends State<CompareEventPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final provider =
          Provider.of<CompareEventProvider>(context, listen: false);
      provider.choseFirstEvent = '';
      provider.choseSecondEvent = '';
      provider.choseThirdEvent = '';
      provider.compareEvent();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();
    final provider = Provider.of<CompareEventProvider>(context, listen: true);
    var width = MediaQuery.of(context).size.width;
    // print('build');
    // print(width * 0.332);
    return WillPopScope(
      onWillPop: () async {
        final diffrence = DateTime.now().difference(timeBackPressed);
        final isExitWarning = diffrence >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        return exitTheAppMethod(isExitWarning);
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: const MenuWidget(),
          elevation: 0,
          backgroundColor: appBarBagroundColor,
          iconTheme: const IconThemeData(color: whiteColor),
          title: const Text(
            'Compare Event',
            style: TextStyle(
              color: blackColor,
            ),
          ),
        ),
        body: provider.isLoading
            ? const Center(
                child: Text('Loading...'),
              )
            : CompareEventSearchScreen(width: width),
        // ListOfCompareEvents(width: width),
      ),
    );
  }
}

class ListOfCompareEvents extends StatelessWidget {
  const ListOfCompareEvents({
    super.key,
    required this.width,
    required this.provider,
    this.firstEventData,
  });

  final double width;
  final CompareEventProvider provider;
  final dynamic firstEventData;

  @override
  Widget build(BuildContext context) {
    int eventTitleLengths = 0;
    int eventAddressLength = 0;
    final eventTitle1 = provider.detailFirstEventData['title'].length ?? 0;
    final eventTitle2 = provider.detailSecondEventData['title'].length ?? 0;
    final eventTitle3 = provider.detailThirdEventData['title'].length ?? 0;
    final eventAddress1 = provider.detailFirstEventData['address'].length ?? 0;
    final eventAddress2 = provider.detailSecondEventData['address'].length ?? 0;
    final eventAddress3 = provider.detailThirdEventData['address'].length ?? 0;
    //
    if (eventTitle1 > eventTitle2) {
      eventTitleLengths = eventTitle1;
      // print("e1$eventTitleLengths");
    } else if (eventTitle2 > eventTitle3) {
      eventTitleLengths = eventTitle2;
      // print("e2:$eventTitleLengths");
    } else if (eventTitle3 > eventTitle1) {
      eventTitleLengths = eventTitle3;
      // print("e3:$eventTitleLengths");
    }
    //
    if (eventAddress1 > eventAddress2) {
      eventAddressLength = eventAddress1;
      // print("e1$eventAddressLength");
    } else if (eventAddress2 > eventAddress3) {
      eventAddressLength = eventAddress2;
      // print("e2:$eventAddressLength");
    } else if (eventAddress3 > eventAddress1) {
      eventAddressLength = eventAddress3;
      // print("e3:$eventAddressLength");
    }
    //

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarBagroundColor,
        iconTheme: const IconThemeData(color: blackColor),
        title: const Text(
          'Compare Event',
          style: TextStyle(
            color: blackColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ComapreEventContainer(
                    width: width,
                    image: demo,
                    data: firstEventData,
                    eventTitleLength: eventTitleLengths,
                    eventAddressLength: eventAddressLength,
                  ),
                  ComapreEventContainer1(
                    width: width,
                    image: demo,
                    data: firstEventData,
                    eventTitleLength: eventTitleLengths,
                    eventAddressLength: eventAddressLength,
                  ),
                  ComapreEventContainer1(
                    width: width,
                    image: demo1,
                    data: provider.detailSecondEventData,
                    eventTitleLength: eventTitleLengths,
                    eventAddressLength: eventAddressLength,
                  ),
                  ComapreEventContainer1(
                    width: width,
                    image: demo2,
                    data: provider.detailThirdEventData,
                    eventTitleLength: eventTitleLengths,
                    eventAddressLength: eventAddressLength,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
