import 'dart:convert';
import 'dart:io';

import 'package:news_app/constants/const.dart';
import 'package:http/http.dart' as http;

class RestAPIService {
  static RestAPIService? instance;
  static String? apiKey;
  static String? baseUrl;

  static RestAPIService getInstance() {
    if (instance == null) {
      initializeParam();
      instance = RestAPIService.internal();
    }
    return instance!;
  }

  static initializeParam() {
    apiKey = "33987db4491c4d32a49c525d42863838";
    baseUrl = "https://newsapi.org";
  }

  RestAPIService.internal();

  Future<dynamic> fetchData(String url, RestAPIEndPoint endPoint) async {
    switch (endPoint) {
      case RestAPIEndPoint.GET:
        try {
          final response = await http.read(Uri.parse("$url"));
          return {"data": json.decode(response)};
        } on SocketException {
          return {
            "error":
                'No internet connection found, Please check your internet and try again!'
          };
        } on FormatException {
          return {
            "error":
                'Unable to process your request due to some failure, Please try again later!'
          };
        } on http.ClientException {
          return {
            "error":
                'Oh No! Unable to process your request. Possible cases may be server is not reachable or if server runs on VPN then VPN should be connected on mobile device!'
          };
        } catch (exe) {
          return {"error": "Unexpected Error"};
        }
      default:
    }
  }

  Map<String, dynamic> parseRequest(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return {'data': response.body};
      default:
        return {'error': "Unexpected error"};
    }
  }
}
