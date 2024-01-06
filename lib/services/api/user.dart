import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:task_front/services/api/general.dart';

class UserApi {
  static Future<Map<String, dynamic>> login(
      {required String? email, required String? password}) async {
    return Api.get(
        authority: dotenv.get("URI_HOSTNAME"),
        path: "/login",
        queryPayloadMap: {"email": email, "password": password});
  }

  static Future<Map<String, dynamic>> create(
      {required String? email, required String? password}) async {
    return Api.post(
        authority: dotenv.get("URI_HOSTNAME"),
        path: "/user/self",
        payload: {"email": email, "password": password, "role": "user"});
  }
}
