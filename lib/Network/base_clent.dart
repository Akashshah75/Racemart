import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class BaseClient {
  var client = http.Client();
  var headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  //global post api without token
  Future<dynamic> post(String api, dynamic body) async {
    var url = Uri.parse(api);
    try {
      var response = await client
          .post(url, body: jsonEncode(body), headers: headers)
          .timeout(const Duration(seconds: 10));
      //
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response.body;
      }
    } on TimeoutException catch (_) {
      return 'timeOut';
    } on SocketException catch (_) {
      return 'internet_error';
    }
  }

  //post api for logout with token
  Future<dynamic> postOfLogout(String api, var token) async {
    var header = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    var url = Uri.parse(api);
    var response = await client
        .post(url, headers: header)
        .timeout(const Duration(seconds: 10));
    //
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  //post method with token
  Future<dynamic> postMethodWithToken(
      String api, var token, dynamic body) async {
    var header = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };
    var url = Uri.parse(api);
    var response = await client
        .post(url, headers: header, body: jsonEncode(body))
        .timeout(const Duration(seconds: 15));
    //
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

//global get method with token
  Future<dynamic> getMethodWithToken(String api, String token) async {
    var header = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    var url = Uri.parse(api);
    var response = await client
        .get(url, headers: header)
        .timeout(const Duration(seconds: 15));

    //
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  //global get metod without token
  Future<dynamic> getMethodWithOutToken(String api) async {
    var url = Uri.parse(api);
    var response = await client
        .get(url, headers: headers)
        .timeout(const Duration(seconds: 15));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }
}
