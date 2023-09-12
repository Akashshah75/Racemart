import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Network/url.dart';
import 'package:racemart_app/Provider/wishlist/wishlist_provider.dart';

import '../../Network/base_clent.dart';
import '../../Utils/constant.dart';
import '../authentication_provider.dart';

class FavEventAddWishlist with ChangeNotifier {
  bool isFav = false;

//
//
  Future<void> addEvent(int eventId, BuildContext context) async {
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
      // ignore: use_build_context_synchronously
      toastMessage(result['message']);
      if (wishProvider.wishListData.length < 10) {
        print('if wishlist data less than 10:');
        Future.delayed(const Duration(milliseconds: 350), () {
          wishProvider.wishListEvent(context).then((_) {
            wishProvider.fav = [];
            if (wishProvider.wishListData.length < 10) {
              for (int i = 0; i < wishProvider.wishListData.length; i++) {
                print(
                    'wishlistLoop from fav_event:${wishProvider.wishListData.length}');
                wishProvider.fav.add(wishProvider.wishListData[i]['id']);
                notifyListeners();
              }
            }
          });
        });
      } else {
        print('if wishlist data more than 10:');

        Future.delayed(const Duration(milliseconds: 100), () {
          wishProvider.fetch(context).then((value) {
            Future.delayed(const Duration(milliseconds: 500), () {
              wishProvider.checkId(context);
              // wishProvider.checkId(context);
            });
          });
        });
      }

      toastMessage('');
    }
  }
}
