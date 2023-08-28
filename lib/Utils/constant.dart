import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_color.dart';

void toastMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
  );
}

String convertDate(var date) {
  final DateTime now = DateTime.parse(date);
  final DateFormat formatter = DateFormat('d MMM y');
  final String formatted = formatter.format(now);
  // print(formatted);
  return formatted;
}

bool checkDate(var earlyStartDate, var earlyEndDate) {
  final earlyStart = DateTime.parse(earlyStartDate);
  final earlyEnd = DateTime.parse(earlyEndDate);
  final DateTime now = DateTime.now();
  if (now.isAfter(earlyStart) && now.isBefore(earlyEnd)) {
    return true;
  }
  if (now.isAtSameMomentAs(earlyStart) || now.isAtSameMomentAs(earlyEnd)) {
    return true;
  }
  return false;

  // if ((now.compareTo(earlyStart) == 0 || now.compareTo(earlyStart) == -1) &&
  //     (earlyEnd.compareTo(now) == 1 || earlyEnd.compareTo(now) >= 0)) {
  //   return true;
  // } else {
  //   return false;
  // }
}

//back button method
bool exitTheAppMethod(bool isExitWarning) {
  // final diffrence = DateTime.now().difference(timeBackPressed);
  // final isExitWarning = diffrence >= const Duration(seconds: 2);
  // timeBackPressed = DateTime.now();
  // final syytem = SystemNavigator.pop();
  if (isExitWarning) {
    const message = 'Press back again to exit';
    Fluttertoast.showToast(
        msg: message,
        fontSize: 16,
        backgroundColor: white,
        textColor: blackColor);
    return false;
  } else {
    Fluttertoast.cancel();
    SystemNavigator.pop();
    return false;
  }
}

//lunch url
Future<void> launchUrls(var url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}





//
//(now.compareTo(date1) == 0 || now.compareTo(date1) == -1) &&
      // (date2.compareTo(now) == 1 || date2.compareTo(now) >= 0)
  // print("myDate:${now.compareTo(date1) == 0 || now.compareTo(date1) == 1}");
  // print("myDate:${now.compareTo(date2) > 0 || now.compareTo(date2) == 0}");
  // print("myDate:${now.compareTo(date2) == 0 || now.compareTo(date2) == 1}");

// print(1 == 2 && 2 == 2);
// if (widget.data['early_start_date'] != null) {
//   print(now.compareTo(DateTime.parse(widget.data['early_start_date'])) ==
//           0 &&
//       now.compareTo(DateTime.parse(widget.data['early_end_date'])) == 0);
// }

//  final date1 = DateTime.parse('2023-01-17 14:21:00');
//     final date2 = DateTime.parse('2023-01-18 14:21:00');
//     final DateTime now = DateTime.now();
//     print(
//         "myDat:${(now.compareTo(date1) == 0 || now.compareTo(date1) == 1) && date2.compareTo(now) == -1 || date2.compareTo(now) == 0}");
//     // print("myDae:${date2.compareTo(now) == -1 || date2.compareTo(now) == 0}");

//     //
// TopContainer(data: widget.data),
// const SizedBox(height: 10),
// Expanded(
//   child:
//       VerticalTabBarView(controller: controller, children: [
//     DataAndDescription(data: provider.detailEventData),
//     DistancesAndPartenr(data: provider.detailEventData),
//     PriceAndLocation(data: provider.detailEventData),
//     ImpDateAndTerrains(data: provider.detailEventData),
//     SimilarListingList(data: provider.detailEventData),
//   ]),
// ),

   //
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: TabBar(
                  //       controller: controller,
                  //       labelColor: blackColor,
                  //       indicatorColor: blueColor,
                  //       indicatorWeight: 2,
                  //       isScrollable: true,
                  //       labelPadding:
                  //           const EdgeInsets.symmetric(horizontal: 40),
                  //       tabs: const [
                  //         Tab(text: 'Description'),
                  //         Tab(text: 'Distances&Partners'),
                  //         Tab(text: 'Price&loaction'),
                  //         Tab(text: 'Imporatnt&Terrains'),
                  //         Tab(text: 'Simlilar listing'),
                  //       ]),
                  // ),
                  // Expanded(
                  //   child: ListView(
                  //     // controller: controller,
                  //     children: const [],
                  //   ),
                  // ),
                  //
                  // Expanded(
                  //   child: VerticalTabBarView(
                  //     controller: controller,
                  //     children: const [
                  //       Column(
                  //         children: [
                  //           Text('new'),
                  //           Text('new'),
                  //           Text('new'),
                  //           Text('new'),
                  //           Text('new'),
                  //         ],
                  //       ),
                  //       Text('new'),
                  //       Text('new'),
                  //       Text('new'),
                  //       Text('new'),

                  // DescriptionContainer(data: provider.detailEventData),
                  // DataAndDescription(data: provider.detailEventData),
                  // DistancesAndPartenr(data: provider.detailEventData),
                  // PriceAndLocation(data: provider.detailEventData),
                  // ImpDateAndTerrains(data: provider.detailEventData),
                  // SimilarListingList(data: provider.detailEventData),
                  // ],
                  // ),
                  // ),