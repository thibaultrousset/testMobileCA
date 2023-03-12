import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Api {
  /// *
  /// Class that major method sends http requests depending on http method and parameters
  /// handles response status, error messages, refresh token and encoding of response to return

  // next three lines makes this class a Singleton

  // avoid other instances
  Api._privateConstructor();
  // instance of singleton
  static final Api _instance = Api._privateConstructor();
  // method to access singleton from other files
  static Api get instance {
    return _instance;
  }

  // the response is encoded
  final JsonDecoder _decoder = const JsonDecoder();

  // the url of the api. I add the specific routes to call a specific web service
  static const String base = "https://cdf-test-mobile-default-rtdb.europe-west1.firebasedatabase.app/";

  Future<dynamic> request(
      String? methodType,
      String? url, {
        body,
        encoding,
        required needAuthentication
      }) async {
    Map<String, String>? headers;
    headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    var responseJson;

    // switch case through http methods
    switch (methodType) {
      case "post":
        {
          try {
            final response = await http.post(Uri.parse(base + url!), body: body, headers: headers, encoding: encoding);
            print(response);
            print(response.request);
            print(response.body);
            responseJson = responseHandle(response, methodType);
          } catch (e) {
            print(e);
            throw (e);
          }
          return responseJson;
        }

      case "put":
        {
          try {
            final response = await http.put(Uri.parse(base + url!), body: body, headers: headers, encoding: encoding);
            responseJson = responseHandle(response, methodType);
          } on SocketException {
            throw ("no internet");
          }
          return responseJson;
        }
      case "get":
        {
          try {
            final response = await http.get(Uri.parse(base + url!), headers: headers);
            responseJson = responseHandle(response, methodType);
          } on SocketException {
            throw ("no internet");
          }
          return responseJson;
        }
    }
  }

  // check status code to handle error as token expired
  Future responseHandle(response, String? type) async {
    // final response if no err
    dynamic res;
    // status to check to know what to do with response
    int statusCode = response.statusCode;
    print(response);
    res = _decoder.convert(response.body);
    print(res);
    //  res = response.data;

    /// way of treating err mess translation in front
    switch (statusCode) {
    // check which english err is received to know which french err to display
      case 400:
        {
          // response contains only one err message as a string
          throw (res["error"]["message"]);
        }
    }
    // if status code diff than 200 I have an error message send in the body with key "error_message" in post requests
    if (statusCode != 200 && statusCode != 202) {
      throw (res);
    }
    // no error status => i can return my response in expected format
    return res;
  }
}
