import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Network/url.dart';

import '../Network/base_clent.dart';
import 'authentication_provider.dart';

class DetailProvider with ChangeNotifier {
  int selectedIndex = 0;
  var htmlDscriptionTextLength = 10;
//
  bool flag = false;
  String intialHtmlText = '';
  String expendedHtmlText = '';
  //
  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  //
  bool isLoading = false;
  Map detailEventData = {};
  //
  Future<void> fetchEventDetail(BuildContext context, var eventId) async {
    isLoading = true;
    notifyListeners();
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient().getMethodWithToken(
        '$eventUrl/$eventId', provider.appLoginToken.toString());
    isLoading = false;
    notifyListeners();
    var result = jsonDecode(response);
    // //
    detailEventData = {};
    if (result['status'] == 'success') {
      detailEventData = result['data'];
      notifyListeners();
    }
    // print(detailEventData);
  }

  //
  void changeLength(String htmlText) {
    // print(htmlText.length);
    if (htmlText.length > 450) {
      intialHtmlText = htmlText.substring(0, 350);
      expendedHtmlText = htmlText.substring(0, htmlText.length);
      notifyListeners();
    } else if (htmlText.length > 300) {
      intialHtmlText = htmlText.substring(0, 300);
      expendedHtmlText = htmlText.substring(0, htmlText.length);
      notifyListeners();
    } else if (htmlText.length > 150) {
      intialHtmlText = htmlText.substring(0, 150);
      expendedHtmlText = htmlText.substring(0, htmlText.length);
      notifyListeners();
    } else {
      intialHtmlText = htmlText;
      expendedHtmlText = '';
      notifyListeners();
    }
  }

  void changeText() {
    flag = !flag;
    notifyListeners();
  }
}
