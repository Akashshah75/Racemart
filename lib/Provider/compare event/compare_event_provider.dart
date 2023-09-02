import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Network/url.dart';

import '../../Network/base_clent.dart';
import '../authentication_provider.dart';

class CompareEventProvider with ChangeNotifier {
  Map detailFirstEventData = {};
  Map detailSecondEventData = {};
  Map detailThirdEventData = {};
  bool isLoading = false;
  Map<String, dynamic> mapCompareEvent = {};
  List listOfCompareEventNames = [];
  String choseFirstEvent = '';
  String choseSecondEvent = '';
  String choseThirdEvent = '';
  void choseFirstEventName(var val) {
    choseFirstEvent = val;
    notifyListeners();
  }

  void choseSecondEventName(var val) {
    if (val != null) {
      choseSecondEvent = val;
      notifyListeners();
    }
  }

  void choseThirdEventName(var val) {
    if (val != null) {
      choseThirdEvent = val;
      notifyListeners();
    }
  }

//

  Future<void> compareEvent() async {
    isLoading = true;
    notifyListeners();
    var response = await BaseClient().getMethodWithOutToken(compareEventUrl);
    var result = jsonDecode(response);
    //
    mapCompareEvent = {};
    listOfCompareEventNames = [];
    if (result['status'] == 'success') {
      listOfCompareEventNames = result['data'];
      isLoading = false;
      notifyListeners();
    }
  }

  //
  Future<void> fetchEventDetail(BuildContext context,
      {var eventId, int? id}) async {
    // isLoading = true;
    // notifyListeners();
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient().getMethodWithToken(
        '$eventUrl/$eventId', provider.appLoginToken.toString());
    // isLoading = false;
    // notifyListeners();
    var result = jsonDecode(response);
    // //
    if (result['status'] == 'success') {
      if (id == 1) {
        detailFirstEventData = {};
        detailFirstEventData = result['data'];
        notifyListeners();
      } else if (id == 2) {
        detailSecondEventData = {};
        detailSecondEventData = result['data'];
        notifyListeners();
      } else if (id == 3) {
        detailThirdEventData = {};
        detailThirdEventData = result['data'];
        notifyListeners();
      }
    }
    //
  }
  //
}
