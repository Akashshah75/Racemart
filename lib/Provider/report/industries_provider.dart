import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Network/url.dart';

import '../../Network/base_clent.dart';
import '../../Utils/constant.dart';
import '../authentication_provider.dart';

class IndustriesReportProvider with ChangeNotifier {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController email = TextEditingController();
  bool isLoading = false;
  bool isLoadingForDetail = false;
  List industriesReportList = [];
  Map showReportData = {};
  //
  String downloadUrl = '';
  bool isLoadingForDownload = false;
  double? downloadProgress;
  //fetch industries reports
  Future<void> fetchIndustriesReportList(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient()
        .getMethodWithToken(reportUrl, provider.appLoginToken.toString());
    isLoading = false;
    notifyListeners();
    var result = jsonDecode(response);
    industriesReportList = [];
    if (result['status'] == 'success') {
      industriesReportList = result['data'];
    }
    // print(industriesReportList);
  }

  //show industries report data.
  Future<void> fetchShowReportData(BuildContext context, int id) async {
    // print("$reportShowbyIdUrl$id");
    isLoadingForDetail = true;
    notifyListeners();
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient().getMethodWithToken(
        "$reportShowbyIdUrl$id", provider.appLoginToken.toString());

    isLoadingForDetail = false;
    notifyListeners();
    var result = jsonDecode(response);
    showReportData = {};
    if (result['status'] == 'success') {
      showReportData = result['data'];
    }
    // print(showReportData);
  }

  //
  Future<void> downloadReport(BuildContext context, int id) async {
    var body = {
      'report_id': id,
      "first_name": firstName.text.trim(),
      "last_name": lastName.text.trim(),
      "email": email.text.trim(),
      "mobile": mobileNo.text.trim(),
    };
    //
    if (firstName.text.isEmpty) {
      toastMessage("first name can't be empty?");
    } else if (lastName.text.isEmpty) {
      toastMessage("last name can't be empty?");
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
          reportUrlForPostMethod, provider.appLoginToken.toString(), body);
      // print(response);
      //
      var result = jsonDecode(response);
      // print(result);
      downloadUrl = '';
      if (result['status'] == "success") {
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

        clearTextFieldOfSignUp();
      } else if (result['status'] == 'error') {
        toastMessage(result['message']);
        // clearTextFieldOfSignUp();
      }
      //
    }
    //
  }

  void clearTextFieldOfSignUp() {
    firstName.clear();
    lastName.clear();
    email.clear();
    mobileNo.clear();
  }

  //luanch url
  Future launchUrl(var uri) async {
    // var url = Uri.parse(uri);
    if (await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}
