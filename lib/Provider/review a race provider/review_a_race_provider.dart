import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Network/base_clent.dart';
import '../../Network/url.dart';
import '../authentication_provider.dart';

class ReviewARaceProvider with ChangeNotifier {
  List<dynamic> reviewRaceList = [];
  bool isLoading = false;
  //
  Future<void> reviewRaceEvent(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient()
        .getMethodWithToken(pastEventUrl, provider.appLoginToken.toString());
    // print(response);
    isLoading = false;
    notifyListeners();
    var result = jsonDecode(response);
    //
    reviewRaceList = [];

    if (result['status'] == 'success') {
      reviewRaceList = result['data']['list'];
      //   print(reviewRaceList);
      notifyListeners();
    }
  }
}
