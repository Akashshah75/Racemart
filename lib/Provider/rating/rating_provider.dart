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
  Map<String, int> rating = {};
  List partnerRatingData = [];
  int totalRating = 0;
  bool isLoading = false;
  //for user rating
  void getUserStarRating(var rateingStar) {
    userRating = rateingStar;
    notifyListeners();
  }

  void getRatingData(String type, int rate) {
    rating.addAll({type: rate});
    notifyListeners();
    print(rating);
  }

  //post api for rataing
  Future<void> postRating(BuildContext context, var eventId) async {
    // isLoading = true;
    // notifyListeners();
    var body = {
      "event_id": eventId,
      "comments": ratingComment.text,
      "rating": rating
    };
    print(body);

    //
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient().postMethodWithToken(
        postReviewsUrl, provider.appLoginToken.toString(), body);
    // print(response);
    // isLoading = false;
    // notifyListeners();
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

  //fetch updated review data
  Future<void> fetchReview(BuildContext context, var eventId) async {
    final url = fethREviewUrl + eventId;
    isLoading = true;
    notifyListeners();
    //
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient()
        .getMethodWithToken(url, provider.appLoginToken.toString());
    isLoading = false;
    notifyListeners();
    //
    var result = jsonDecode(response);
    //
    partnerRatingData = [];
    if (result['status'] == "success") {
      partnerRatingData = result['data']['user_rating'];
      totalRating = result['data']['rate']['stars'];
      notifyListeners();
      print(partnerRatingData);
    } else {
      toastMessage(result['message']);
    }
    //
  }
}
