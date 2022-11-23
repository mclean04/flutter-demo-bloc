import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

class BaseServices {
  static Future<dynamic> getMethod(String url, param) async {
    try {
      String queryString = Uri(queryParameters: param).query;
      var requestUrl = url + "?" + queryString;
      Uri tempUrl = Uri.parse(requestUrl);
      Response res = await get(tempUrl).timeout(Duration(minutes: 5));

      var responseDecode = json.decode(res.body);
      switch (res.statusCode) {
        case 200:
        case 201:
          return responseDecode;
        case 400:
        case 500:
          print("API message: ${responseDecode["message"]}");
          return null;
        default:
          print("Cannot executed GET Method, status code : ${res.statusCode}");
          return null;
      }
    } on TimeoutException catch (_) {
      print("Server not response");
      return null;
    }
  }

  static Future<dynamic> postMethod(String url, param, header) async {
    try {
      Uri tempUri = Uri.parse(url);
      String data = json.encode(param);
      Response res;
      if (header == null) {
        res = await post(tempUri, body: data).timeout(Duration(minutes: 5));
      } else {
        res = await post(tempUri, headers: header, body: data)
            .timeout(Duration(minutes: 5));
      }

      print("Body Http Post: ${res.body}");
      var responseDecode = json.decode(res.body);
      switch (res.statusCode) {
        case 200:
          return responseDecode;
        case 201:
          break;
        case 400:
        case 401:
        case 500:
          print("API message: ${responseDecode["message"]}");
          return null;
        default:
          print("Cannot executed Post Method, status code : ${res.statusCode}");
          return null;
      }
    } on TimeoutException catch (_) {
      print("Server not response");
      return null;
    }
  }

  static Future<dynamic> putMethod(String url, param, header) async {
    try {
      Uri tempUri = Uri.parse(url);
      String data = json.encode(param);
      Response res;
      if (header == null) {
        res = await put(tempUri, body: data).timeout(Duration(minutes: 5));
      } else {
        res = await put(tempUri, headers: header, body: data)
            .timeout(Duration(seconds: 5));
      }

      print("Body Http Put: ${res.body}");
      var responseDecode = json.decode(res.body);

      switch (res.statusCode) {
        case 200:
          return responseDecode;
        case 201:
          break;
        case 400:
        case 401:
        case 500:
          print("API message: ${responseDecode["message"]}");
          return null;
        default:
          print("Cannot executed Post Method, status code : ${res.statusCode}");
          return null;
      }

      if (res.statusCode == 200 || res.statusCode == 201) {
        return responseDecode;
      } else {
        print("Cannot executed Put Method, status code : ${res.statusCode}");
        return null;
      }
    } on TimeoutException catch (_) {
      print("Server not response");
      return null;
    }
  }

  static Future<dynamic> deleteMethod(String url, param) async {
    try {
      String queryString = Uri(queryParameters: param).query;
      var requestUrl = url + "?" + queryString;
      Uri tempUrl = Uri.parse(requestUrl);
      Response res = await delete(tempUrl).timeout(Duration(minutes: 5));
      var responseDecode = json.decode(res.body);
      print("Body Http Delete: ${res.body}");
      switch (res.statusCode) {
        case 200:
          return responseDecode;
        case 201:
          break;
        case 400:
        case 401:
        case 500:
          print("API message: ${responseDecode["message"]}");
          return null;
        default:
          print(
              "Cannot executed DELETE Method, status code : ${res.statusCode}");
          return null;
      }
    } on TimeoutException catch (_) {
      print("Server not response");
      return null;
    }
  }
}
