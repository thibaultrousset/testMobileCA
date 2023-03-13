import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:test_mobile_ca/helpers/error_messages.dart';
import 'package:test_mobile_ca/helpers/http.dart';

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
    Future responseJson;

    // switch case through http methods
    switch (methodType) {
      case Http.post:
        {
          try {
            final response = await http.post(Uri.parse(base + url!), body: body, headers: headers, encoding: encoding);
            responseJson = responseHandle(response, methodType);
          } on SocketException {
            throw (ErrorMessages.noInternet);
          }
          return responseJson;
        }

      case Http.put:
        {
          try {
            final response = await http.put(Uri.parse(base + url!), body: body, headers: headers, encoding: encoding);
            responseJson = responseHandle(response, methodType);
          } on SocketException {
            throw (ErrorMessages.noInternet);
          }
          return responseJson;
        }
      case Http.get:
        {
          try {
            final response = await http.get(Uri.parse(base + url!), headers: headers);
            responseJson = responseHandle(response, methodType);
          } on SocketException {
            throw (ErrorMessages.noInternet);
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
    res = _decoder.convert(response.body);

    if(statusCode>=400){
      switch (statusCode) {

        case 500:
        case 501:
        case 502:
        case 504:
          {
            throw (ErrorMessages.serverError);
          }
        case 404:
          {
            throw (ErrorMessages.pageNotFound);
          }
        case 400:
          {
            throw (res);
          }
        default:
          {
            throw (ErrorMessages.anErrorOccurred);
          }
      }
    }
    // if status code diff than 200 I have an error message send in the body
    if (statusCode != 200 && statusCode != 202) {
      throw (res);
    }

    // no error status => i can return my response in expected format
    return res;
  }
}
