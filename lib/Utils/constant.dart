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
