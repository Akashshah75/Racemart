import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

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
  final date1 = DateTime.parse(earlyStartDate);
  final date2 = DateTime.parse(earlyEndDate);
  final DateTime now = DateTime.now();
  //
  if (now.compareTo(date1) <= 0) {
    return true;
  } else if (now.compareTo(date2) == 0) {
    return true;
  }
  if (now.compareTo(date1) < 0) {
    return true;
  }
  if (now.compareTo(date1) > 0) {
    return true;
  } else {
    return false;
  }
}

 // print(1 == 2 && 2 == 2);
    // if (widget.data['early_start_date'] != null) {
    //   print(now.compareTo(DateTime.parse(widget.data['early_start_date'])) ==
    //           0 &&
    //       now.compareTo(DateTime.parse(widget.data['early_end_date'])) == 0);
    // }