import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Network/base_clent.dart';
import '../../Network/url.dart';
import '../../Utils/constant.dart';
import '../authentication_provider.dart';

class ReviewARaceProvider with ChangeNotifier {
  TextEditingController search = TextEditingController();

  //
  List<dynamic> reviewRaceList = [];
  bool isLoading = false;
  bool isLoadingInSearch = false;
  //
  String choseAllType = '';
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

  //type of
  void changeAllType(var val) {
    choseAllType = val;
    notifyListeners();
  }

  //city
  String choseCity = '';
  void changeDropDownVal(var val) {
    choseCity = val;
    notifyListeners();
  }

  //distances
  List listOfDistanceData = [];
  void changeDistance(var val) {
    listOfDistanceData = val;
    notifyListeners();
  }

  //badge
  List listOfBadgeData = [];
  void changeBadge(var val) {
    listOfBadgeData = val;
    notifyListeners();
  }

  //partners
  List listOfPartnersData = [];
  void changePartners(var val) {
    listOfPartnersData = val;
    notifyListeners();
  }

  List searchListData = [];
  //search past event
  Future<void> searchEvent(BuildContext context,
      {var category,
      var city,
      List? distance,
      List? badge,
      List? partner}) async {
    isLoadingInSearch = true;
    notifyListeners();
    var body = {
      "search": search.text,
      "distance": distance ?? [],
      "badge": badge ?? [],
      "partner": partner ?? [],
      "category": category,
      "city": city,
    };
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient().postMethodWithToken(
        searchEventUrl, provider.appLoginToken.toString(), body);
    //
    isLoadingInSearch = false;
    notifyListeners();
    searchListData = [];
    var result = jsonDecode(response);
    if (result['status'] == "success") {
      searchListData = result['data']['list'];
      print(searchListData);
      notifyListeners();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      //
    } else {
      toastMessage(result['message']);
    }
  }

  //clear field
  void cleanDropDownBoxes() {
    search.clear();
    choseAllType = '';
    choseCity = '';
    listOfDistanceData = [];
    listOfBadgeData = [];
    listOfPartnersData = [];
    notifyListeners();
  }
}
