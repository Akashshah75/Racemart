import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Network/base_clent.dart';
import 'package:racemart_app/Network/url.dart';
import 'package:racemart_app/Provider/authentication_provider.dart';

enum AdvertisementData { horizontal, vertical }

class AdvertiesmentProvider with ChangeNotifier {
  bool isLoading = false;
  int activeIndex = 0;
  Map advertismentData = {};
  List horizontalAdvertismentData = [];
  List verticleAdvertismentData = [];
  List shuffleList = [];

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
    // print(response);
    isLoading = false;
    notifyListeners();
    var result = jsonDecode(response);
    //print(result['data']);
    advertismentData = {};
    horizontalAdvertismentData = [];
    verticleAdvertismentData = [];
    shuffleList = [];
    if (result['status'] == 'success') {
      advertismentData = result['data'];
      // print(advertismentData);
      advertismentData.forEach((key, value) {
        if (key == 'horizontal') {
          horizontalAdvertismentData = value;
          notifyListeners();
        }
        if (key == 'vertical') {
          verticleAdvertismentData = value;
          List getSuffledAnswer() {
            final suffeldList = List.of(verticleAdvertismentData);
            suffeldList.shuffle();
            return suffeldList;
          }

          shuffleList = getSuffledAnswer();
          notifyListeners();
        }
      });
    }
    // print("horizontalAdvertismentData:$horizontalAdvertismentData");
    // print("verticleAdvertismentData$verticleAdvertismentData");
    // print(mapOfProfileData);
  }
}
