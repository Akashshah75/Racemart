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
    // print(response);
    var result = jsonDecode(response);
    if (result['status'] == "success") {
      // isFav = result['fav'];
      // notifyListeners();
      toastMessage(result['message']);
      // ignore: use_build_context_synchronously
      wishProvider.wishListEvent(context);
      //
      Future.delayed(const Duration(milliseconds: 350), () {
        wishProvider.checkId(context);
      });

      //
    } else {
      toastMessage('');
    }
  }
}
