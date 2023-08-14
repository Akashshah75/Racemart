import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:racemart_app/Network/url.dart';

import '../../Network/base_clent.dart';
import '../../Utils/constant.dart';

class ContactUsProvider with ChangeNotifier {
  bool isLoading = false;
  //
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();
  //
  Future<void> sendContactUsMessage(BuildContext context) async {
    var body = {
      "name": name.text.trim(),
      "email": email.text.trim(),
      "phone": mobileNo.text.trim(),
      "subject": subject.text.trim(),
      "message": message.text.trim(),
    };
    //
    if (name.text.isEmpty) {
      toastMessage("name can't be empty?");
    } else if (email.text.isEmpty) {
      toastMessage("email can't be empty?");
    } else if (EmailValidator.validate(email.text) == false) {
      toastMessage('Please enter correct email id?');
    } else if (mobileNo.text.isEmpty) {
      toastMessage("mobile no can't be empty?");
    } else if (mobileNo.text.length < 10) {
      toastMessage("mobile no can't be less than 10?");
    } else if (mobileNo.text.length > 10) {
      toastMessage("mobile no can't be more than 10?");
    } else if (subject.text.isEmpty) {
      toastMessage("subject can't be empty?");
    } else if (message.text.isEmpty) {
      toastMessage("message can't be empty?");
    } else {
      isLoading = true;
      notifyListeners();
      var response = await BaseClient().post(contactUsUrl, body);
      isLoading = false;
      notifyListeners();
      //
      var result = jsonDecode(response);
      if (result['status'] == "success") {
        toastMessage(result['message']);
        clearTextFieldOfSignUp();
      } else {
        toastMessage(result['message']);
        isLoading = true;
        notifyListeners();
      }
      //
    }
    //
  }

  void clearTextFieldOfSignUp() {
    name.clear();
    email.clear();
    mobileNo.clear();
    subject.clear();
    message.clear();
  }
}
