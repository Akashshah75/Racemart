import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/wishlist/fav_event_add_wishlist_provider.dart';

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
  checkWishlistId(int id, BuildContext context) {
    print(id);
    // print(wishListData);
    // for (var element in wishListData) {
    //   // print(element['id']);
    //   if (element['id'] == id) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // }
    // FavEventAddWishlist().addEvent(id, context).then((value) {

    wishListEvent(context);
    // .then((value) {
    Future.delayed(const Duration(milliseconds: 350), () {
      for (var element in wishListData) {
        // print(element['id']);
        if (element['id'] == id) {
          return true;
        } else {
          return false;
        }
        // print("wishListData.contains(id)${element['id']}");
        // print("wishListData.contains(id)${element['id'] == id}");
        // print(wishListData.length);
      }
      // });
    });
    // });

    // return true;
  }

  //
  //
  List fav = [];
  int page = 2;

  bool hasMore = true;
  bool isFav = false;
  int limit = 10;
  Future fetch(BuildContext context) async {
    print('page:$page');
    var provider = Provider.of<AuthenticationProvider>(context, listen: false);
    final url = "https://racemart.youtoocanrun.com/api/wishlist?page=$page";
    var res = await BaseClient()
        .getMethodWithToken(url, provider.appLoginToken.toString());
    print(res);
    var result = jsonDecode(res);
    final List newEvent = result['data']['list'];
    print(result['data']['current_page'] * 10);
    print(result['data']['total']);
//
    if (result['data']['current_page'] * 10 < result['data']['total']) {
      page++;
      notifyListeners();
    } else if (result['data']['to'] == null) {
      page--;
      notifyListeners();
    }

    // if (result['data']['to'] < result['data']['total']) {
    //   page++;
    //   notifyListeners();
    // } else if (result['data']['to'] == null) {
    //   page--;
    //   notifyListeners();
    // }

    // if (limit == newEvent.length) {
    //   page++;
    //   notifyListeners();
    // }

    // if (newEvent.length < limit) {
    //   hasMore = false;
    //   notifyListeners();
    // } else {
    //   if (limit == newEvent.length) {
    //     print(page);
    //     page++;
    //     notifyListeners();
    //   }
    // }
    // print(newEvent.length);
    wishListData.addAll(newEvent);
    print('final length:${wishListData.length}');
    notifyListeners();
    //
  }

  void checkId(BuildContext context) {
    print(page);
    fav = [];
    if (wishListData.length >= limit) {
      print(wishListData.length);
      print("ok");
      fetch(context).then(
        (_) {
          print('loop:${wishListData.length}');
          for (int i = 0; i < wishListData.length; i++) {
            fav.add(wishListData[i]['id']);
            notifyListeners();
          }
        },
      );
    } else {
      for (int i = 0; i < wishListData.length; i++) {
        print('wishlistLoop:${wishListData.length}');
        fav.add(wishListData[i]['id']);
        notifyListeners();
      }
    }
  }
}
