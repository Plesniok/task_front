import 'package:task_front/services/api/general.dart';
import 'package:task_front/services/api/models/add_task_body.dart';
import 'package:task_front/services/api/models/edit_task_body.dart';

class TaskApi {
  static Future<Map<String, dynamic>> getTasks({required String? token}) async {
    return Api.get(
        authority: "localhost:8080", path: "/tasks", getToken: token);
  }

  static Future<Map<String, dynamic>> addTask(
      {required AddTaskBody newTaskData, required String? token}) async {
    return Api.post(
        authority: "localhost:8080",
        path: "/task",
        token: token,
        payload: newTaskData.getPayload());
  }

  static Future<Map<String, dynamic>> editTask(
      {required EditTaskBody newTaskData, required String? token}) async {
    return Api.patch(
        authority: "localhost:8080",
        path: "/task",
        token: token,
        payload: newTaskData.getPayload());
  }

  static Future<Map<String, dynamic>> markTaskAsDone(
      {required int? taskId, required String? token}) async {
    return Api.patch(
        authority: "localhost:8080",
        path: "/task/done",
        token: token,
        payload: {
          "taskId": taskId
        });
  }
}
