

import 'package:task_front/services/api/general.dart';

class ApiException implements Exception {
  ApiException({this.code, this.reasonPhase, this.body});

  int? code;
  String? reasonPhase;
  ApiBody? body;

  @override
  String toString() {
    if (body != null) return body!.message.toString();

    return reasonPhase.toString();
  }
}
