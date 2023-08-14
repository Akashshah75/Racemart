import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Network/base_clent.dart';
import '../../Network/url.dart';
import '../authentication_provider.dart';

class TestimonialProvider with ChangeNotifier {
  List<dynamic> testimonialList = [];
  bool isLoading = false;
  //
  Future<void> testimonialData(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient()
        .getMethodWithToken(testimonialUrl, provider.appLoginToken.toString());
    //  print(response);
    isLoading = false;
    notifyListeners();
    var result = jsonDecode(response);
    //
    testimonialList = [];

    if (result['status'] == 'success') {
      testimonialList = result['data'];
      // print(testimonialList);
      notifyListeners();
    }
  }
}
