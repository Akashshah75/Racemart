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
      wishListData = result['data']['list'];
      lengthOFwishlist = wishListData.length;
      notifyListeners();
      // fav = [];
    }

    print('fav_from_wishlist_method: $fav');
  }

  //
  // List<dynamic> wishListData = [];

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
    // print(res);
    var result = jsonDecode(res);
    final List newEvent = result['data']['list'];
    print("newEvent.length:${newEvent.length}");
    //
    if (newEvent.length == 10) {
      page++;
    } else if (newEvent.isEmpty) {
      page--;
    }
    wishListData.addAll(newEvent);
    notifyListeners();
    print(wishListData.length);
  }

  //
  void checkWishListId(BuildContext context) {
    fav = [];
    if (wishListData.length <= 10) {
      for (int i = 0; i < wishListData.length; i++) {
        fav.add(wishListData[i]['id']);
        notifyListeners();
      }
      //first 10 event add on wishlist
      print('FavOfFirst10ListEvent: $fav');
    }
    wishListEvent(context);
  }

  void checkWishlistData(BuildContext context, int id) {
    fav = [];
    // if (wishListData.length > 10) {
    for (int i = 0; i < wishListData.length; i++) {
      fav.add(wishListData[i]['id']);
      notifyListeners();
    }
    // }
    print('FavOfMoreThan10ListEvent: $fav');
    print(fav.length);

    // wishListEvent(context);
  }
}


//





//////////////////////////////////////////

  // void checkId(BuildContext context) {
  //   print('checkId:$fav');
  //   fav = [];
  //   // Future.delayed(const Duration(milliseconds: 400), () {
  //   // fav.addAll(wishListData['id']);
  //   for (int i = 0; i < wishListData.length; i++) {
  //     print('wishlistLoop:${wishListData.length}');
  //     fav.add(wishListData[i]['id']);
  //     notifyListeners();
  //   }
  //   print('fav from fetch:$fav');
  // });
  //   if (wishListData.length >= limit) {
  //     fetch(context).then(
  //       (_) {
  //         print('loop:${wishListData.length}');
  //         for (int i = 0; i < wishListData.length; i++) {
  //           fav.add(wishListData[i]['id']);
  //           notifyListeners();
  //         }
  //       },
  //     );
  //   } else {
  //     for (int i = 0; i < wishListData.length; i++) {
  //       print('wishlistLoop:${wishListData.length}');
  //       fav.add(wishListData[i]['id']);
  //       notifyListeners();
  //     }
  //   }
  //   print(fav);
// }
// }
//
// if (result['data']['current_page'] * 10 < result['data']['total']) {
//   page++;
//   notifyListeners();
// } else if (result['data']['to'] == null) {
//   page--;
//   notifyListeners();
// }
// print("wishListData.length:${wishListData.length}");

// notifyListeners();
//
// print('fav:${fav.length}');
//
// fav = [];

// fav = [];
// Future.delayed(const Duration(milliseconds: 400), () {
//   for (int i = 0; i < wishListData.length; i++) {
//     print('wishlistLoop:${wishListData.length}');
//     fav.add(wishListData[i]['id']);
//     notifyListeners();
//   }
//   print('fav from fetch:$fav');
// });
//
