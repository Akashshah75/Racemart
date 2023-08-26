import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Network/url.dart';
import 'package:http/http.dart' as http;
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
  bool isEdite = false;
  File? selectedImage;
  //
  bool isLoading = false;
  bool updateProfile = false;
  Map<String, dynamic> mapOfProfileData = {};
  //
  //start profile edited;
  void activeProfileEditeMode() {
    isEdite = !isEdite;
    notifyListeners();
  }

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
    selectedImage = null;
    isEdite = false;
  }

  //image picker
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      selectedImage = imageTemporary;
      notifyListeners();
      // print(selectedImage);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image:$e');
      }
    }
  }

  //update profile by formdata
  Future updateProfileByMultiportData(
    BuildContext context, {
    required String selectedName,
    required String selecetdMobile,
    required String selectedEmail,
    var image,
  }) async {
    updateProfile = true;
    notifyListeners();
    // get token
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    // print(provider.appLoginToken);
    var url = Uri.parse(userUrl);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${provider.appLoginToken}"
    };
    http.MultipartRequest request = http.MultipartRequest('POST', url);
    // print(url);
    request.headers.addAll(headers);
    request.fields['name'] = name.text.isEmpty ? selectedName : name.text;

    request.fields['mobile'] =
        mobileNo.text.isEmpty ? selecetdMobile : name.text;
    request.fields['email'] = email.text.isEmpty ? selectedEmail : email.text;
    //
    if (selectedImage != null) {
      var stream = http.ByteStream(selectedImage!.openRead());
      stream.cast();
      var length = await selectedImage!.length();
      var multiport = http.MultipartFile('profile', stream, length,
          filename: selectedImage!.path.split('/').last);
      request.files.add(multiport);
    }
    var response = await request.send();
    //
    updateProfile = false;
    notifyListeners();
    var result = await http.Response.fromStream(response);

    dynamic resultOfProfileData = jsonDecode(result.body);
    // print(resultOfProfileData);
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      fetchUserProfile(context);
      clearText();
    } else {
      if (resultOfProfileData['status'] == 'error') {
        Map error = resultOfProfileData['errors'];
        error.forEach(
          (key, value) {
            if (key == 'profile') {
              List val = value;
              for (int i = 0; i < val.length; i++) {
                toastMessage(value[i]);
              }
            } else if (key == 'name') {
              List val = value;
              for (int i = 0; i < val.length; i++) {
                toastMessage(value[i]);
              }
            } else if (key == 'mobile') {
              List val = value;
              for (int i = 0; i < val.length; i++) {
                toastMessage(value[i]);
              }
            } else if (key == 'email') {
              List val = value;
              for (int i = 0; i < val.length; i++) {
                toastMessage(value[i]);
              }
            }
          },
        );
      }
      // print('upload faild');
    }
  }
}
