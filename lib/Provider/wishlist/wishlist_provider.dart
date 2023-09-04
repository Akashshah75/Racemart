import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Network/base_clent.dart';
import '../../Network/url.dart';
import '../authentication_provider.dart';

class WishListProvider with ChangeNotifier {
  List<dynamic> wishListData = [];
  bool isLoading = false;
  //
  int? lengthOFwishlist;
  //
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
      wishListData = result['data']['list'];
      lengthOFwishlist = wishListData.length;
      notifyListeners();
      print("wishListData.length : $lengthOFwishlist");
      notifyListeners();
      // wishListData.length;
    }
  }

  //
  //
  List fav = [];
  int page = 2;
  bool hasMore = true;
  bool isFav = false;
  int limit = 10;
  Future fetch(BuildContext context) async {
    page = 2;
    var provider = Provider.of<AuthenticationProvider>(context, listen: false);
    final url = "https://racemart.youtoocanrun.com/api/wishlist?page=$page";
    var res = await BaseClient()
        .getMethodWithToken(url, provider.appLoginToken.toString());
    // print(res);
    var result = jsonDecode(res);
    final List newEvent = result['data']['list'];
    // print(newEvent); //
    page++;
    if (newEvent.length < limit) {
      hasMore = false;
      notifyListeners();
    }
    wishListData.addAll(newEvent);
    notifyListeners();
    //
  }

  void checkId(BuildContext context) {
    fav = [];
    if (wishListData.length >= limit) {
      // print(wishListData.length);
      // print("ok");
      fetch(context).then((_) {
        for (int i = 0; i < wishListData.length; i++) {
          fav.add(wishListData[i]['id']);
          notifyListeners();
        }
      });
      //
      // Future.delayed(const Duration(milliseconds: 400), () {
      //   // print(fav);
      //   // print('next');
      //   // print(wishListData.length);

      //   for (int i = 0; i < wishListData.length; i++) {
      //     fav.add(wishListData[i]['id']);
      //     notifyListeners();
      //   }
      // });
    } else {
      for (int i = 0; i < wishListData.length; i++) {
        fav.add(wishListData[i]['id']);
        notifyListeners();
      }
    }
  }
}
