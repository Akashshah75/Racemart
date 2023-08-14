import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Network/url.dart';

import '../../Network/base_clent.dart';
import '../../Utils/constant.dart';
import '../authentication_provider.dart';

class ProfileProvider with ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController role = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController email = TextEditingController();
  //
  TextEditingController password = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();

  //
  bool isLoading = false;
  bool updateProfile = false;
  Map<String, dynamic> mapOfProfileData = {};
  //
  Future<void> fetchProfileData(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient()
        .getMethodWithToken(userUrl, provider.appLoginToken.toString());
    // print(response);
    isLoading = false;
    notifyListeners();
    var result = jsonDecode(response);
    //print(result['data']);
    mapOfProfileData = {};
    if (result['status'] == 'success') {
      mapOfProfileData = result['data'];
    }
    // print(mapOfProfileData);
  }

  //
  void fetchUserProfile(BuildContext context) {
    final controller = Provider.of<ProfileProvider>(context, listen: false);
    controller.fetchProfileData(context);
    Navigator.of(context).pop();
  }

  //
  Future<void> editProfile(BuildContext context) async {
    updateProfile = true;
    notifyListeners();
    var body = {
      "name": name.text.trim(),
      "email": email.text.trim(),
      "mobile": mobileNo.text.trim(),
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
    } else {
      final provider =
          Provider.of<AuthenticationProvider>(context, listen: false);
      var response = await BaseClient().postMethodWithToken(
          userUrl, provider.appLoginToken.toString(), body);
      // print(response);
      updateProfile = false;
      notifyListeners();
      //
      var result = jsonDecode(response);
      if (result['status'] == "success") {
        // ignore: use_build_context_synchronously
        fetchUserProfile(context);
        clearText();
      } else {
        toastMessage(result['message']);
      }
      //
    }
  }

  Future<void> changePassword(BuildContext context) async {
    var body = {
      "password": newPassword.text.trim(),
      "password_confirmation": confirmNewPassword.text.trim(),
    };
    //
    if (password.text.isEmpty) {
      toastMessage("password can't be empty?");
    } else if (password.text.length < 8) {
      toastMessage("The Password must be at least 8 characters.");
    } else if (newPassword.text.isEmpty) {
      toastMessage("new password can't be empty?");
    } else if (confirmNewPassword.text.isEmpty) {
      toastMessage("confirm password can't be empty?");
    } else if (newPassword.text != confirmNewPassword.text) {
      toastMessage('Enter confirm new password same as new password');
    } else {
      final provider =
          Provider.of<AuthenticationProvider>(context, listen: false);
      var response = await BaseClient().postMethodWithToken(
          userUrl, provider.appLoginToken.toString(), body);
      // print(response);
      //
      var result = jsonDecode(response);
      if (result['status'] == "success") {
        // ignore: use_build_context_synchronously
        updatePassword(context);
        clearText();
      } else {
        toastMessage(result['errors']['password'][0]);
      }
      //
    }
  }

  void updatePassword(BuildContext context) {
    Navigator.of(context).pop();
  }

  void clearText() {
    name.clear();
    email.clear();
    mobileNo.clear();
    password.clear();
    newPassword.clear();
    confirmNewPassword.clear();
  }
}
