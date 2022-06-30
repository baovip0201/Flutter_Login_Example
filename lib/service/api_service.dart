import 'dart:convert';

import 'package:flutter_login_api/config.dart';
import 'package:flutter_login_api/models/login_request_model.dart';
import 'package:flutter_login_api/models/login_response_model.dart';
import 'package:flutter_login_api/models/register_request_model.dart';
import 'package:flutter_login_api/models/register_response_model.dart';
import 'package:flutter_login_api/service/shared_service.dart';
import 'package:http/http.dart' as http;

class APIService {
  static var client = http.Client();

  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.loginAPI);

    var response = await client.post(url, headers: requestHeaders, body: json.encode(model.toJson()));

    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else{
      return false;
      }
  }

  static Future<RegisterResponseModel> register(RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.loginAPI);

    var response = await client.post(url, headers: requestHeaders, body: json.encode(model.toJson()));

    return registerResponseModel(response.body);
  }

    static Future<String> getUserProfile() async {
      var loginDetails= await SharedService.loginDetails();
    
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token}'
    };

    var url = Uri.http(Config.apiURL, Config.profileAPI);

    var response = await client.post(url, headers: requestHeaders,);

    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return response.body;
    } else{
      return "";
      }
  }

}
