import 'package:flutter/material.dart';

class RatingProvider with ChangeNotifier {
  TextEditingController ratingComment = TextEditingController();
  double userRating = 0;
  double timingPartnerRating = 0;
  double eventOranizerRating = 0;
  double registrationPartnerRating = 0;

  //for user rating
  void getUserStarRating(var rateingStar) {
    userRating = rateingStar;
    notifyListeners();
  }

  //for timing partner rating
  void getTimingPartnerRating(var rateingStar) {
    timingPartnerRating = rateingStar;
    notifyListeners();
  }

  //for event organiser rating
  void getEventOrganiserRating(var rateingStar) {
    eventOranizerRating = rateingStar;
    notifyListeners();
  }

  //for registration Partner rating
  void getRegistrationPartnerRating(var rateingStar) {
    registrationPartnerRating = rateingStar;
    notifyListeners();
  }
}
