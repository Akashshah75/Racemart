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
// void size(BuildContext context) {
//   final size = MediaQuery.of(context).size.height;
//   // print(size * 0.75);
// }

final urlImage = [
  "https://racemart.youtoocanrun.com/storage/advertisement/giGxwbeMGpLUh9LNilCYZZhFyMAfewbGckWryYUQ.gif",
  "https://racemart.youtoocanrun.com/storage/advertisement/FKkee52MdmIbPQImQgNYnLnim4UEw7LHQqcKxfGJ.png"
];
