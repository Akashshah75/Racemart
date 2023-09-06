import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Network/base_clent.dart';
import 'package:racemart_app/Network/url.dart';
import 'package:racemart_app/Provider/authentication_provider.dart';

class AdvertiesmentProvider with ChangeNotifier {
  bool isLoading = false;
  int activeIndex = 0;
  Map advertismentData = {};
  List homePageAdvertismentData = [];

//change advertisment index
  void changeIndex(int index) {
    activeIndex = index;
    notifyListeners();
  }

  //
  Future<void> fetchAdvertismentData(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient()
        .getMethodWithToken(advertismentUrl, provider.appLoginToken.toString());
    print(response);
    isLoading = false;
    notifyListeners();
    var result = jsonDecode(response);
    //print(result['data']);
    advertismentData = {};
    homePageAdvertismentData = [];
    if (result['status'] == 'success') {
      advertismentData = result['data'];
      print(advertismentData);
      advertismentData.forEach((key, value) {
        if (key == 'horizontal') {
          homePageAdvertismentData = value;
          notifyListeners();
        }
      });
    }
    // print(mapOfProfileData);
  }
}
