import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Network/base_clent.dart';
import '../../Network/url.dart';
import '../../Utils/constant.dart';
import '../Home providers/home_page_provider.dart';
import '../authentication_provider.dart';

class UserInterestProvider with ChangeNotifier {
  //infinite scrolling
  bool hasMore = true;

  //
  List selectedCities = [];
  List selectedType = [];
  List selectedDistances = [];
  List selectedTerrains = [];
  bool isLoading = false;
  bool isSelected = false;
  Future<void> updateUserInterest(BuildContext context,
      {List? city, List? type, List? distances, List? terrains}) async {
    isLoading = true;
    notifyListeners();
    var body = {
      "cities": city ?? [],
      "type": type ?? [],
      "distances": distances ?? [],
      "terrains": terrains ?? [],
    };
    print(body);
    //

    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient().postMethodWithToken(
        userInterestUrl, provider.appLoginToken.toString(), body);
    //

    // print(response);
    isLoading = false;
    notifyListeners();
    //
    var result = jsonDecode(response);
    if (result['status'] == "success") {
      toastMessage("user interest updated");
      Future.delayed(Duration.zero, () {
        initUserInterestList(context);
        Navigator.pop(context, true);
      });
    }
    //
    else {
      // toastMessage(result['message']);
    }
  }

  //
  //profile
  Future<void> fetchSelectedUserInterest(BuildContext context) async {
    isSelected = true;
    notifyListeners();
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient().getMethodWithToken(
        selectUserInterestUrl, provider.appLoginToken.toString());
    // print(response);
    isSelected = false;
    notifyListeners();
    var result = jsonDecode(response);
    // print(result['data']);
    selectedCities = [];
    selectedType = [];
    selectedDistances = [];
    selectedTerrains = [];
    if (result['status'] == 'success') {
      result['data']['cities'] != null
          ? selectedCities = result['data']['cities']
          : [];
      result['data']['type'] != null
          ? selectedType = result['data']['type']
          : [];
      result['data']['distances'] != null
          ? selectedDistances = result['data']['distances']
          : [];
      result['data']['terrains'] != null
          ? selectedTerrains = result['data']['terrains']
          : [];
    }
  }

  ///
  void initUserInterestList(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    provider.userInterest(context);
  }

  ///
}
