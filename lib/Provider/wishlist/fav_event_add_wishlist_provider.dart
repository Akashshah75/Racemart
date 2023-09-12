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
    final wishProvider = Provider.of<WishListProvider>(context, listen: false);
    var body = {'event_id': eventId};
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient().postMethodWithToken(
        addEventUrl, provider.appLoginToken.toString(), body);
    var result = jsonDecode(response);
    if (result['status'] == "success") {
      toastMessage(result['message']);
      Future.delayed(Duration.zero, () {
        wishProvider.wishListEvent(context);
      });
      Future.delayed(const Duration(milliseconds: 450), () {
        wishProvider.checkWishlistid(context);
      });
    }
  }
}
