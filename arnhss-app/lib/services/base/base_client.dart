import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:http/http.dart' as http;

class BaseClient {
  static const int timeOutDuration = 30;
  //  GET
  Future<dynamic> get(String baseUrl, String api) async {
    final Uri uri = Uri.parse(baseUrl + api);

    try {
      var response = await http.get(uri).timeout(
            const Duration(seconds: timeOutDuration),
          );
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException(
        "No internet Connection ",
        uri.toString(),
      );
    } on TimeoutException {
      throw ApiNotRespondingException(
        "API not responded in time ",
        uri.toString(),
      );
    } catch (e) {
      FetchDataException(e.toString(), uri.toString());
    }
  }

  //  POST
  Future<dynamic> post(
      String baseUrl, String api, Map<String, String> payloadObj) async {
    final Uri uri = Uri.parse(baseUrl + api);
    final paylod = json.encode(payloadObj);
    // print(paylod);

    try {
      var response = await http.post(
        uri,
        body: paylod,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(
        const Duration(seconds: timeOutDuration),
      );
      // print(response.statusCode);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException(
        "Something went wrong!!",
        uri.toString(),
      );
    } on TimeoutException {
      throw ApiNotRespondingException(
        "API not responded in time ",
        uri.toString(),
      );
    } catch (e) {
      FetchDataException(e.toString(), uri.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    var responseJson = utf8.decode(response.bodyBytes);
    return jsonDecode(responseJson);

    // switch (response.statusCode) {
    //   case 200:
    //     return responseJson;
    //   case 400:
    //     print("somthing");
    //     throw BadRequestException(
    //       responseJson,
    //       response.request?.url.toString(),
    //     );
    //   case 403:
    //     throw UnAuthorizedException(
    //       responseJson,
    //       response.request?.url.toString(),
    //     );
    //   case 404:
    //   case 500:
    //     print(responseJson);
    //     throw ApiNotRespodingException(
    //       responseJson,
    //       response.request?.url.toString(),
    //     );
    //   default:
    //     throw FetchDataException(
    //       "Error occured with code: ${response.statusCode}",
    //       response.request?.url.toString(),
    //     );
    // }
  }
}
