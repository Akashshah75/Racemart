import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Network/base_clent.dart';
import 'package:racemart_app/Network/url.dart';
import 'package:racemart_app/Provider/authentication_provider.dart';

class NotificationProvider with ChangeNotifier {
  bool isLoading = false;
  List notificationData = [];

  Future<void> fetchNotificationData(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient()
        .getMethodWithToken(notificationUrl, provider.appLoginToken.toString());
    print(response);
    isLoading = false;
    notifyListeners();
    var result = jsonDecode(response);
    notificationData = [];
    if (result['status'] == 'success') {
      notificationData = result['data']['list'];
    }
    print(notificationData);
  }
}
