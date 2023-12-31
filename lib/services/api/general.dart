import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_front/services/api/exception.dart';

class ApiBody {
  String? message;
  int? code;

  ApiBody.fromJson(String jsonString) {
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    message = jsonMap["message"];
    code = jsonMap["status"];
  }
}

class Api {
  static Future<Map<String, dynamic>> get(
      {required String authority,
      required String path,
      Map<String, dynamic>? queryPayloadMap,
      String? getToken,
      String? getRefreshToken}) async {
    var client = http.Client();
    Map<String, dynamic> data = {};
    try {
      String? token = getToken;
      String? refreshToken = getRefreshToken;

      Map<String, dynamic> queryParameters =
          (queryPayloadMap != null) ? queryPayloadMap : {};
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Access-Control-Allow-Origin": "*"
      };
      headers = (refreshToken != null)
          ? {...headers, "x-access-reftoken": refreshToken}
          : headers;
      headers =
          (token != null) ? {...headers, "x-access-token": token} : headers;
      final response = await http.get(
        Uri.http(
          authority,
          '$path',
          queryParameters,
        ),
        headers: headers,
      );
      if (response.statusCode == 200) {
        data = json.decode(response.body);
      } else {
        throw ApiException(
          code: response.statusCode,
          reasonPhase: response.reasonPhrase,
          body: ApiBody.fromJson(response.body),
        );
      }
      return data;
    } catch (e) {
      return {'error': e};
    } finally {
      client.close();
    }
  }

  static Future<Map<String, dynamic>> post(
      {required String authority,
      required String path,
      Map<String, dynamic>? payload,
      String? token,
      String? refreshToken}) async {
    var client = http.Client();
    Map<String, dynamic> data = {};

    try {
      Map<String, dynamic> queryParameters = (payload != null) ? payload : {};

      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: 'application/json'
      };
      headers = (refreshToken != null)
          ? {...headers, "x-access-reftoken": refreshToken}
          : headers;
      headers =
          (token != null) ? {...headers, "x-access-token": token} : headers;

      final response = await http.post(
        Uri.http(authority, '$path'),
        headers: headers,
        body: json.encode(queryParameters),
      );
      if (response.statusCode < 300) {
        data = json.decode(response.body);
      } else {
        throw ApiException(
          code: response.statusCode,
          reasonPhase: response.reasonPhrase,
          body: ApiBody.fromJson(response.body),
        );
      }
      return data;
    } catch (e) {
      return {'error': e};
    } finally {
      client.close();
    }
  }

  static Future<Map<String, dynamic>> put(
      {required String authority,
      required String path,
      Map<String, dynamic>? payload,
      String? token,
      String? refreshToken}) async {
    var client = http.Client();
    Map<String, dynamic> data = {};
    try {
      Map<String, dynamic> requestBody = (payload != null) ? payload : {};

      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: 'application/json'
      };
      headers = (refreshToken != null)
          ? {...headers, "x-access-reftoken": refreshToken}
          : headers;
      headers =
          (token != null) ? {...headers, "x-access-token": token} : headers;

      final response = await http.put(Uri.http(authority, '$path'),
          body: jsonEncode(requestBody), headers: headers);
      if (response.statusCode == 200) {
        data = json.decode(response.body);
      } else {
        throw ApiException(
          code: response.statusCode,
          reasonPhase: response.reasonPhrase,
          body: ApiBody.fromJson(response.body),
        );
      }
      return data;
    } catch (e) {
      return {'error': e};
    } finally {
      client.close();
    }
  }

  static Future<Map<String, dynamic>> patch(
      {required String authority,
      required String path,
      Map<String, dynamic>? payload,
      String? refreshToken,
      String? token}) async {
    var client = http.Client();
    Map<String, dynamic> data = {};
    try {
      Map<String, dynamic> queryParameters = (payload != null) ? payload : {};

      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: 'application/json'
      };
      headers = (refreshToken != null)
          ? {...headers, "x-access-reftoken": refreshToken}
          : headers;
      headers =
          (token != null) ? {...headers, "x-access-token": token} : headers;

      final response = await http.patch(Uri.http(authority, '$path'),
          body: jsonEncode(queryParameters), headers: headers);
      if (response.statusCode == 200) {
        data = json.decode(response.body);
      } else {
        throw ApiException(
          code: response.statusCode,
          reasonPhase: response.reasonPhrase,
          body: ApiBody.fromJson(response.body),
        );
      }
      return data;
    } catch (e) {
      return {'error': e};
    } finally {
      client.close();
    }
  }

  static Future<Map<String, dynamic>> delete(
      {required String authority,
      required String path,
      Map<String, dynamic>? payload,
      String? token,
      String? refreshToken}) async {
    var client = http.Client();
    Map<String, dynamic> data = {};
    try {
      Map<String, dynamic> requestBody = (payload != null) ? payload : {};

      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: 'application/json'
      };
      headers = (refreshToken != null)
          ? {...headers, "x-access-reftoken": refreshToken}
          : headers;
      headers =
          (token != null) ? {...headers, "x-access-token": token} : headers;

      final response = await http.delete(Uri.http(authority, '$path'),
          body: jsonEncode(requestBody), headers: headers);
      if (response.statusCode == 200) {
        data = json.decode(response.body);
      } else {
        throw ApiException(
          code: response.statusCode,
          reasonPhase: response.reasonPhrase,
          body: ApiBody.fromJson(response.body),
        );
      }
      return data;
    } catch (e) {
      return {'error': e};
    } finally {
      client.close();
    }
  }
}
