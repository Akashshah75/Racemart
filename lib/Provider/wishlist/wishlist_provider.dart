import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Network/base_clent.dart';
import '../../Network/url.dart';
import '../authentication_provider.dart';

class WishListProvider with ChangeNotifier {
  List fav = [];
  List<dynamic> wishListData = [];
  bool isLoading = false;
  //
  int? lengthOFwishlist;

  Future<void> wishListEvent(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient()
        .getMethodWithToken(wishlistUrl, provider.appLoginToken.toString());
    // print(response);
    isLoading = false;
    notifyListeners();
    var result = jsonDecode(response);
    //
    wishListData = [];
    if (result['status'] == 'success') {
      wishListData = result['data'];
      lengthOFwishlist = wishListData.length;
      notifyListeners();
    }
  }

  void checkWishlistid(BuildContext context) {
    fav = [];
    for (int i = 0; i < wishListData.length; i++) {
      fav.add(wishListData[i]['id']);
      notifyListeners();
    }
  }
}
