import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Network/base_clent.dart';
import 'package:racemart_app/Network/url.dart';
import 'package:racemart_app/Provider/authentication_provider.dart';

enum CategoryOfBottomNavigation {
  home,
  running,
  cycling,
  duathathlon,
  trithalon
}

class AdvertiesmentProvider with ChangeNotifier {
  bool isLoading = false;
  int activeIndex = 0;
  Map advertismentData = {};
  // List horizontalAdvertismentData = [];
  List homePageAdvertisementpopUp = [];
  List homePageTopSectionAdvertiesment = [];
  List runningPageTopSectionAdvertiesment = [];
  List cyclingPageTopSectionAdvertiesment = [];
  List duathalonPageTopSectionAdvertiesment = [];
  List trithalonPageTopSectionAdvertiesment = [];
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
    homePageAdvertisementpopUp = [];
    homePageTopSectionAdvertiesment = [];
    runningPageTopSectionAdvertiesment = [];
    cyclingPageTopSectionAdvertiesment = [];
    duathalonPageTopSectionAdvertiesment = [];
    trithalonPageTopSectionAdvertiesment = [];
    shuffleList = [];
    if (result['status'] == 'success') {
      advertismentData = result['data'];
      // print(advertismentData);
      advertismentData.forEach((key, value) {
        if (key == '10') {
          homePageAdvertisementpopUp = value;
          List getSuffledAnswer() {
            final suffeldList = List.of(homePageAdvertisementpopUp);
            suffeldList.shuffle();
            return suffeldList;
          }

          shuffleList = getSuffledAnswer();
          notifyListeners();
        }

        ///
        if (key == '11') {
          homePageTopSectionAdvertiesment = value;
          notifyListeners();
        }
        if (key == '12') {
          runningPageTopSectionAdvertiesment = value;
          notifyListeners();
        }
        if (key == '13') {
          cyclingPageTopSectionAdvertiesment = value;
          notifyListeners();
        }
        if (key == '14') {
          duathalonPageTopSectionAdvertiesment = value;
          notifyListeners();
        }
        if (key == '15') {
          trithalonPageTopSectionAdvertiesment = value;
          notifyListeners();
        }

        ///
      });
    }
  }

  //
  List changeAdvertisementAsPerPage(CategoryOfBottomNavigation category) {
    if (CategoryOfBottomNavigation.home == category) {
      return homePageTopSectionAdvertiesment;
    } else if (CategoryOfBottomNavigation.running == category) {
      return runningPageTopSectionAdvertiesment;
    } else if (CategoryOfBottomNavigation.cycling == category) {
      return cyclingPageTopSectionAdvertiesment;
    } else if (CategoryOfBottomNavigation.duathathlon == category) {
      return duathalonPageTopSectionAdvertiesment;
    } else if (CategoryOfBottomNavigation.trithalon == category) {
      return trithalonPageTopSectionAdvertiesment.isEmpty
          ? []
          : trithalonPageTopSectionAdvertiesment;
    } else {
      return [];
    }
  }
}
