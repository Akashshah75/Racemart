import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:racemart_app/Network/base_clent.dart';
import 'package:racemart_app/Network/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Push Notification/notification_api.dart';
import '../Routes/route_names.dart';
import '../Utils/constant.dart';

class AuthenticationProvider with ChangeNotifier {
  //forget password page
  TextEditingController emailOfForgetPassword = TextEditingController();
  //login page
  TextEditingController emailOfLogin = TextEditingController();
  TextEditingController passwordOfLogin = TextEditingController();
  //
  TextEditingController nameOfSignUp = TextEditingController();
  TextEditingController mobileNoOfSignUp = TextEditingController();
  TextEditingController emailOfSignUp = TextEditingController();
  TextEditingController passwordOfSignUp = TextEditingController();
  TextEditingController confirmPasswordOfSignUp = TextEditingController();
  //
  var appToken = '';
  String? appLoginToken;
  bool isLoading = false;
  bool isLogOut = false;
  String? fcmToken;
  late String device;
  //get fcm token
  NotificationFeat notification = NotificationFeat();
  final firebaseMessaging = FirebaseMessaging.instance;
  //request for permission
  Future<dynamic> requestNotificationPermission() async {
    await firebaseMessaging.requestPermission();
    final token = await firebaseMessaging.getToken();
    fcmToken = token!;
    notifyListeners();
    print('fcm:$fcmToken');
  }

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

//get device type
  void getDeviceType() async {
    if (Platform.isAndroid) {
      // device = 'android';
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on ${androidInfo.model}');
      device = androidInfo.model;
      print(device);
      notifyListeners();
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Running on ${iosInfo.utsname.machine}');
      device = iosInfo.utsname.machine;
      notifyListeners();
    }
  }

  //////////////////////////////////////////////////////////////////////
  //
  Future<void> login(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    if (emailOfLogin.text.isEmpty) {
      toastMessage("Username can't be empty?");
      isLoading = false;
      notifyListeners();
    } else if (passwordOfLogin.text.isEmpty) {
      toastMessage("Password Field can't be empty?");
      isLoading = false;
      notifyListeners();
    } else {
      // try {
      var body = {
        'email': emailOfLogin.text.trim(),
        'password': passwordOfLogin.text.trim(),
        'device': device,
        'token': fcmToken
      };
      print(body);
      var response = await BaseClient().post(loginUrl, body);

      if (response == null) {
        isLoading = false;
        notifyListeners();
        return;
      }
      if (response == 'timeOut') {
        isLoading = false;
        notifyListeners();
        toastMessage("Try again!");
      } else {
        isLoading = false;
        notifyListeners();
        var result = jsonDecode(response);
        appToken = '';
        if (result['status'] == "success") {
          appToken = result['token'];
          saveUserToken(appToken);
          getUserToken();
          notifyListeners();
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.homePage);
            // Navigator.pushReplacementNamed(context, RouteNames.homePage);
          }
          clearTextFiled();
        } else {
          toastMessage('Pls enter correct credential?');
          clearTextFiled();
        }
      }
    }
  }

  //

  Future<bool> logOut(BuildContext context) async {
    isLogOut = true;
    notifyListeners();
    // print(appLoginToken);
    var response = await BaseClient().postOfLogout(logOutUrl, appLoginToken);
    // print(response);
    isLogOut = false;
    notifyListeners();
    var result = jsonDecode(response);
    if (result['status'] == 'success') {
      return true;
      // if (context.mounted) {
      //   Navigator.of(context).pushReplacementNamed(RouteNames.splashPage);
      // }
    } else {
      return false;
    }
  }

  //
  void clearTextFiled() {
    emailOfLogin.clear();
    passwordOfLogin.clear();
  }

  // user registration
  Future<void> userRegistration(
      BuildContext context, bool accepTermAndCondition) async {
    var body = {
      "name": nameOfSignUp.text.trim(),
      "mobile": mobileNoOfSignUp.text.trim(),
      "email": emailOfSignUp.text.trim(),
      "password": passwordOfSignUp.text.trim(),
      "password_confirmation": confirmPasswordOfSignUp.text.trim(),
      "role": "6",
      "company": null
    };
    //
    if (nameOfSignUp.text.isEmpty) {
      toastMessage("name can't be empty?");
    } else if (emailOfSignUp.text.isEmpty) {
      toastMessage("email can't be empty?");
    } else if (EmailValidator.validate(emailOfSignUp.text) == false) {
      toastMessage('Please enter correct email id?');
    } else if (mobileNoOfSignUp.text.isEmpty) {
      toastMessage("mobile no can't be empty?");
    } else if (mobileNoOfSignUp.text.length < 10) {
      toastMessage("mobile no can't be less than 10?");
    } else if (mobileNoOfSignUp.text.length > 10) {
      toastMessage("mobile no can't be more than 10?");
    } else if (passwordOfSignUp.text.isEmpty) {
      toastMessage("password can't be empty?");
    } else if (passwordOfSignUp.text.length < 8) {
      toastMessage("password can't be less than 8?");
    } else if (confirmPasswordOfSignUp.text.isEmpty) {
      toastMessage("confirm password can't be empty?");
    } else if (passwordOfSignUp.text != confirmPasswordOfSignUp.text) {
      toastMessage("Please enter confirm password  same as password?");
    } else if (accepTermAndCondition == false) {
      toastMessage('please accept terms and condition?');
    } else {
      var response = await BaseClient().post(registrationUrl, body);
      //
      var result = jsonDecode(response);
      if (result['status'] == "success") {
        if (context.mounted) {
          Navigator.of(context).pushReplacementNamed(RouteNames.loginPage);
        }
        clearTextFieldOfSignUp();
      } else {
        toastMessage(result['message']);
      }
      //
    }
    //
  }

//
  void clearTextFieldOfSignUp() {
    nameOfSignUp.clear();
    emailOfSignUp.clear();
    mobileNoOfSignUp.clear();
    passwordOfSignUp.clear();
    confirmPasswordOfSignUp.clear();
  }

  //user token
  Future<bool> saveUserToken(String token) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', token);
    notifyListeners();
    return true;
  }

  Future<String> getUserToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString('token').toString();
    appLoginToken = token;
    notifyListeners();
    return appLoginToken = token;
  }

  Future<bool> removeToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.clear();
  }

  //
  //Forget password
  Future<void> forgetPassword(BuildContext context) async {
    var body = {
      "email": emailOfForgetPassword.text.trim(),
    };
    // print(body);
    //
    if (emailOfForgetPassword.text.isEmpty) {
      toastMessage("email can't be empty?");
    } else if (EmailValidator.validate(emailOfForgetPassword.text) == false) {
      toastMessage('Please enter correct email id?');
    } else {
      var response = await BaseClient().post(forgetPasswordUrl, body);
      // print(response);
      //
      var result = jsonDecode(response);
      if (result['status'] == "success") {
        toastMessage(result['message']);
        emailOfForgetPassword.clear();
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      } else {
        toastMessage(result['message']);
        emailOfForgetPassword.clear();
      }
      //
    }
  }
}
