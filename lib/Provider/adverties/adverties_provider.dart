import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:racemart_app/Network/url.dart';

import '../../Network/base_clent.dart';
import '../../Utils/constant.dart';

class AdveriesProvider with ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController message = TextEditingController();
  //
  String downloadUrl = '';
  bool isLoading = false;
  double? downloadProgress;
  //
  Future<void> userRegistration(BuildContext context) async {
    var body = {
      "name": name.text.trim(),
      "email": email.text.trim(),
      "phone": mobileNo.text.trim(),
      "subject": subject.text.trim(),
      "company": company.text.trim(),
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
    } else if (company.text.isEmpty) {
      toastMessage("company can't be empy?");
    } else if (message.text.isEmpty) {
      toastMessage("message can't be empty?");
    } else {
      isLoading = true;
      notifyListeners();
      var response = await BaseClient().post(advertiesOnlineUrl, body);
      // print(response);
      isLoading = false;
      notifyListeners();
      //
      downloadUrl = '';
      var result = jsonDecode(response);
      if (result['status'] == "success") {
        // print(result['data']);
        // downloadUrl = result['data'];
        // notifyListeners();
        //
        // Future.delayed(const Duration(milliseconds: ), () {
        FileDownloader.downloadFile(
          url: result['data'],
          onProgress: (fileName, progress) {
            downloadProgress = progress;
            notifyListeners();
          },
          //download completed
          onDownloadCompleted: (path) {
            // print("Path:$path");
            downloadProgress = null;
            OpenFile.open(path);
            notifyListeners();
          },
          //
          onDownloadError: (errorMessage) {
            toastMessage(errorMessage);
          },
        );

        // }
        // );
        clearTextFieldOfSignUp();
      } else {
        toastMessage(result['message']);
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
    company.clear();
    message.clear();
  }
}
