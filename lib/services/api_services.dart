import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  final String _baseUrl = "3awn.com";//3awn
  late SharedPreferences preferences;
  late String userToken;

  Future<void> getPrefs() async {
    preferences = await SharedPreferences.getInstance();
    String? g = preferences.getString('token');
    userToken = g ??"";
  }

  Future<dynamic> get(String uri, {dynamic body, String? fullUrl}) async {
    await getPrefs();
    try{
      if (userToken.isNotEmpty) {
        print("before $uri");
        var url = fullUrl == null ? Uri.https(this._baseUrl, uri, body) : Uri.parse(fullUrl);
        print("get function url : $url");
        print("get function userToken : $userToken");
        var header = <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + this.userToken,
          'Content-Type': 'application/json',
        };
        var response = await http.get(url, headers: header);
        return _returnResponse(response, edit: false);
      }
    }on SocketException{
      Get.offNamedUntil('/noConnectionPage', (route) => false);
    }
  }
  Future<dynamic> delete(String uri) async {
    try{
      await getPrefs();
      if (userToken.isNotEmpty) {
        print("get function : $uri");
        print("get function : $userToken");
        var url = Uri.https(this._baseUrl, uri);
        var header = <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + this.userToken,
        };
        var response = await http.delete(url, headers: header);
        print("Get fun Res ${json.decode(response.body)}");
        return _returnResponse(response, edit: false);
      }
    }catch(e){
      print("Error ${e.toString()}");
    }
  }

  Future<dynamic> postFullLink(Uri uri, String type, [dynamic body]) async {
    await getPrefs();
    if (userToken.isNotEmpty) {
      print("get function : $uri");
      print("get function : $userToken");
      var header = <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + this.userToken,
      };
      var response = await http.post(uri, headers: header);
      print("Get fun Res ${json.decode(response.body)}");
      return _returnResponse(response, edit: false);
    }
  }

  Future<dynamic> post(String uri, [dynamic body, bool shouldEncodeBody = false]) async {
    await getPrefs();
      var url = Uri.https(_baseUrl, uri);
      //print("$url $uri $context $body");
      Map<String, String> headers = {
        'Accept': 'application/json',
      };
      if (shouldEncodeBody) {
        headers['Content-Type'] = 'application/json';
      }
      if (userToken.isNotEmpty) {
        headers['Authorization'] = 'Bearer ' + userToken;
      }
      http.Response response = await http.post(url,
          headers: headers,
          body: body != null
              ? shouldEncodeBody
                  ? json.encode(body)
                  : body
              : {});
      return _returnResponse(response, edit: false);
  }

  Future<dynamic> put(String uri, [dynamic body, bool shouldEncodeBody = false]) async {
    await getPrefs();
    if (userToken.isNotEmpty) {
      var url = Uri.https(this._baseUrl, uri);
      Map<String, String> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + userToken,
      };
      body['_method'] = 'PUT';
      http.Response response = await http.post(url, headers: headers, body: body != null ? json.encode(body) : {});
      return jsonDecode(response.body);
    }
  }

  dynamic _returnResponse(http.Response response, {required bool edit}) async{
    switch (response.statusCode) {
      case 200:
        return edit ? response.body : json.decode(response.body.toString());
      case 201:
        return {'created': json.decode(response.body.toString())};
      case 400:
        throw Exception(response.body.toString());
      case 401:
        preferences.setString('token', '');
        userToken = "";
        return Get.offNamedUntil('/login', (route) => false);
      case 403:
        throw json.decode(response.body.toString())["message"];
      case 422:
        return _formatLaravelErrors(json.decode(response.body.toString()));
      case 500:
        return Exception(response.body.toString());
      default:
        throw Exception(' Error occurred while Communication with Server with StatusCode:'
            '${response.statusCode}');
    }
  }

  dynamic _formatLaravelErrors(response) {
    List formattedErrors = [];
    if (response.containsKey('errors')) {
      print('errors are');
      print(response['errors']);
      Map<String, dynamic> errors = response['errors'];
      errors.forEach((key, value) {
        print(key);
        print(value[0]);
        if (value[0] != null) {
          formattedErrors.add(value[0]);
        }
      });
    }
    return {'errors': formattedErrors};
  }
}
