import 'package:task_front/services/api/general.dart';

class UserApi {
  static Future<Map<String, dynamic>> login(
      {required String? email, required String? password}) async {
    return Api.get(
      authority: "localhost:8080",
      path: "/login",
      queryPayloadMap: {
        "email": email,
        "password": password
      }
    );
  }

  static Future<Map<String, dynamic>> create(
      {required String? email, required String? password}) async {
    return Api.post(
      authority: "localhost:8080",
      path: "/user/self",
      payload: {
        "email": email,
        "password": password,
        "role": "user"
      }
    );
  }
}
