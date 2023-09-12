import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Network/url.dart';
import 'package:racemart_app/Provider/wishlist/wishlist_provider.dart';

import '../../Network/base_clent.dart';
import '../../Utils/constant.dart';
import '../authentication_provider.dart';

class FavEventAddWishlist with ChangeNotifier {
  final List wishlistEvent = [];
  bool isFav = false;

//
  Future<void> addEvent(int eventId, BuildContext context) async {
    print('addEvent');
    isFav = true;
    notifyListeners();
    final wishProvider = Provider.of<WishListProvider>(context, listen: false);
    //print(eventId);
    var body = {'event_id': eventId};
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient().postMethodWithToken(
        addEventUrl, provider.appLoginToken.toString(), body);
    print(response);
    var result = jsonDecode(response);
    if (result['status'] == "success") {
      toastMessage(result['message']);

      //first 10 event add on wishlist
      if (wishProvider.wishListData.length < 10) {
        Future.delayed(Duration.zero, () {
          wishProvider.wishListEvent(context);
        });
        //
        Future.delayed(const Duration(milliseconds: 350), () {
          print('wish');
          wishProvider.checkWishListId(context);
        });
      }
      //  else if (wishProvider.wishListData.length > 10) {
      //   print('work');
      //   Future.delayed(Duration.zero, () {
      //     wishProvider.fetch(context);
      //   });
      //   Future.delayed(const Duration(milliseconds: 450), () {
      //     print('fav');
      //     wishProvider.checkWishlistData(context);
      //   });
      // }
      //check wishlist
      // Future.delayed(const Duration(milliseconds: 350), () {
      //   wishProvider.checkWishListId(context);
      // });
      ///////////////////////////////////////////////////////////////////////////
      toastMessage('');
    }
  }

  Future<void> addEvent2(int eventId, BuildContext context) async {
    print('addEvent2');
    final wishProvider = Provider.of<WishListProvider>(context, listen: false);
    var body = {'event_id': eventId};
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient().postMethodWithToken(
        addEventUrl, provider.appLoginToken.toString(), body);
    print(response);
    var result = jsonDecode(response);
    if (result['status'] == "success") {
      toastMessage(result['message']);
////////////////////////////////////////////
      print('work');
      Future.delayed(Duration.zero, () {
        wishProvider.fetch(context);
      });
      Future.delayed(const Duration(milliseconds: 450), () {
        print('fav');
        wishProvider.checkWishlistData(context, eventId);
      });

      //check wishlist
      // Future.delayed(const Duration(milliseconds: 350), () {
      //   wishProvider.checkWishListId(context);
      // });
      ///////////////////////////////////////////////////////////////////////////
      toastMessage('');
    }
  }
}
