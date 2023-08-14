import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Network/url.dart';

import '../Network/base_clent.dart';
import '../Utils/constant.dart';
import 'authentication_provider.dart';

class FindARacesProvider with ChangeNotifier {
  TextEditingController lookingFor = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  //
  String choseValue = '';
  List searchListData = [];
  bool isLoading = false;
  bool isClear = false;

  //
  void addDateTIme(BuildContext context) async {
    DateTime? pikedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(3000));
    //
    if (pikedDate != null) {
      startDate.text = DateFormat('dd-MM-yyyy').format(pikedDate);
      notifyListeners();
    }
  }

  void addDateTimeForEndTime(BuildContext context) async {
    DateTime? pikedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(3000));
    //
    if (pikedDate != null) {
      endDate.text = DateFormat('dd-MM-yyyy').format(pikedDate);
      notifyListeners();
    }
  }

  //
  void changeDropDownVal(var val) {
    choseValue = val;
    notifyListeners();
  }

  //////////////////////////////////////
  ///
  Future<void> searchEvent(BuildContext context,
      {var category,
      var city,
      List? distance,
      List? badge,
      List? partner}) async {
    isLoading = true;
    notifyListeners();
    var body = {
      "search": lookingFor.text,
      "distance": distance ?? [],
      "badge": badge ?? [],
      "partner": partner ?? [],
      "category": category,
      "city": city,
      "start_date": startDate.text,
      "end_date": endDate.text,
      "sortby": ""
    };
    //

    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient().postMethodWithToken(
        searchEventUrl, provider.appLoginToken.toString(), body);
    isLoading = false;
    notifyListeners();
    //
    searchListData = [];
    var result = jsonDecode(response);
    if (result['status'] == "success") {
      searchListData = result['data']['list'];
      notifyListeners();
//
      if (searchListData.isEmpty) {
        toastMessage("No event Found");
        //

        lookingFor.clear();
        startDate.clear();
        endDate.clear();
      }
      //
    } else {
      toastMessage(result['message']);
    }

    //
  }

  void changePage() {
    searchListData.clear();
    notifyListeners();
  }

  //
  void cleanTextBoxes() {
    lookingFor.clear();
    startDate.clear();
    endDate.clear();
  }
}
