import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/compare event/compare_event_provider.dart';
import '../../Utils/app_asset.dart';
import '../../Utils/app_color.dart';
import '../Home/Drawer/zoom_drawer.dart';
import 'Components/compare_event_containers.dart';
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
    final provider = Provider.of<CompareEventProvider>(context, listen: true);
    var width = MediaQuery.of(context).size.width;
    // print('build');
    // print(width * 0.332);
    return Scaffold(
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
    int columnLength(String keyName) {
      var length = 0;
      if (provider.detailFirstEventData.containsKey(keyName) &&
          provider.detailFirstEventData[keyName].length > length) {
        length = provider.detailFirstEventData[keyName].length;
      }
      if (provider.detailSecondEventData.containsKey(keyName) &&
          provider.detailSecondEventData[keyName].length > length) {
        length = provider.detailSecondEventData[keyName].length;
      }
      if (provider.detailThirdEventData.containsKey(keyName) &&
          provider.detailThirdEventData[keyName].length > length) {
        length = provider.detailThirdEventData[keyName].length;
      }

      return length;
    }

    final eventTitleLength = columnLength('title');
    print(eventTitleLength);
    // final eventTitle2 = provider.detailSecondEventData['title'].length;
    // final eventTitle3 = provider.detailThirdEventData['title'].length;
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ComapreEventContainer1(
                  width: width,
                  image: demo,
                  data: firstEventData,
                  eventLenth: eventTitleLength,
                ),
                ComapreEventContainer1(
                  width: width,
                  image: demo1,
                  data: provider.detailSecondEventData,
                  eventLenth: eventTitleLength,
                ),
                ComapreEventContainer1(
                  width: width,
                  image: demo2,
                  data: provider.detailThirdEventData,
                  eventLenth: eventTitleLength,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
