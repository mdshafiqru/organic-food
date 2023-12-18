import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../constants/app_helper.dart';
import '../constants/app_strings.dart';
import '../models/api_response.dart';

class Api {
  Api._();

  static final Client _client = Client();

  static Future<ApiResponse> get(String apiEndpoint, bool isAuthNeeded) async {
    var headers = <String, String>{};

    if (isAuthNeeded) {
      String token = await AppHelper.getToken();
      headers = {
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      };
    } else {
      headers = {
        "Accept": "application/json",
      };
    }

    var url = Uri.parse(apiEndpoint);

    final ApiResponse apiResponse = ApiResponse();

    try {
      final response = await _client.get(url, headers: headers);

      var json = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        apiResponse.json = json;
      } else {
        apiResponse.error = AppHelper.handleError(response.statusCode, json);
      }
    } on SocketException {
      apiResponse.error = AppString.noInternetConnection;
    } catch (e) {
      apiResponse.error = AppString.somethingWentWrong;
    }
    return apiResponse;
  }

  static Future<ApiResponse> post(String apiEndpoint, String body) async {
    String token = await AppHelper.getToken();

    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse(apiEndpoint);

    final ApiResponse apiResponse = ApiResponse();

    try {
      final response = await _client.post(url, body: body, headers: headers);

      var json = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        apiResponse.json = json;
      } else {
        apiResponse.error = AppHelper.handleError(response.statusCode, json);
      }
    } on SocketException {
      apiResponse.error = AppString.noInternetConnection;
    } catch (e) {
      apiResponse.error = AppString.somethingWentWrong;
    }

    return apiResponse;
  }

  static Future<ApiResponse> put(String apiEndpoint, String body) async {
    String token = await AppHelper.getToken();

    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse(apiEndpoint);

    final ApiResponse apiResponse = ApiResponse();

    try {
      final response = await _client.put(url, body: body, headers: headers);

      var json = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        apiResponse.json = json;
      } else {
        apiResponse.error = AppHelper.handleError(response.statusCode, json);
      }
    } on SocketException {
      apiResponse.error = AppString.noInternetConnection;
    } catch (e) {
      apiResponse.error = AppString.somethingWentWrong;
    }
    return apiResponse;
  }

  static Future<ApiResponse> delete(String apiEndpoint) async {
    String token = await AppHelper.getToken();

    var headers = {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse(apiEndpoint);

    final ApiResponse apiResponse = ApiResponse();

    try {
      final response = await _client.delete(url, headers: headers);

      var json = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        apiResponse.json = json;
      } else {
        apiResponse.error = AppHelper.handleError(response.statusCode, json);
      }
    } on SocketException {
      apiResponse.error = AppString.noInternetConnection;
    } catch (e) {
      apiResponse.error = AppString.somethingWentWrong;
    }
    return apiResponse;
  }
}
