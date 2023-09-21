import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Network/url.dart';

import '../../Network/base_clent.dart';
import '../../Utils/constant.dart';
import '../authentication_provider.dart';

class RatingProvider with ChangeNotifier {
  TextEditingController ratingComment = TextEditingController();
  double userRating = 0;
  Map<String, double> rating = {};
  bool isLoading = false;
  //for user rating
  void getUserStarRating(var rateingStar) {
    userRating = rateingStar;
    notifyListeners();
  }

  void getRatingData(String type, int rate) {
    rating.addAll({type: rate.floorToDouble()});
    notifyListeners();
    print(rating);
  }

  //post api for rataing
  Future<void> postRating(
    BuildContext context,
    var eventId,
  ) async {
    isLoading = true;
    notifyListeners();
    var body = {
      "event_id": eventId,
      "comments": ratingComment.text,
      "rating": rating
    };
    //
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient().postMethodWithToken(
        postReviewsUrl, provider.appLoginToken.toString(), body);
    // print(response);
    isLoading = false;
    notifyListeners();
    //
    var result = jsonDecode(response);
    print('result$result');
    if (result['status'] == "success") {
      toastMessage(result['message']);
    } else {
      toastMessage(result['message']);
    }
    //
  }
}
