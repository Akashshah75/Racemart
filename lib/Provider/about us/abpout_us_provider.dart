import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/authentication_provider.dart';

import '../../Network/base_clent.dart';
import '../../Network/url.dart';

class AboutUsProvider with ChangeNotifier {
  late String aboutUsdata;
  bool isLoading = false;
  //
  Future<void> aboutUsData(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient()
        .getMethodWithToken(aboutUsUrl, provider.appLoginToken.toString());
    //  print(response);
    isLoading = false;
    notifyListeners();
    var result = jsonDecode(response);
    // print(result);
    aboutUsdata = '';
    if (result['status'] == 'success') {
      aboutUsdata = result['data'];
      notifyListeners();
    }
    // print(aboutUsdata);
  }

  void initMethodOfAboutUs(BuildContext context) {
    final provider = Provider.of<AboutUsProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      provider.aboutUsData(context);
    });
  }
}
