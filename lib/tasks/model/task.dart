import 'package:equatable/equatable.dart';

class Tasks {
  
  List<Task>? tasks;

  Tasks({
    this.tasks
  });

  Tasks.fromJson(Map json) {
    tasks = [];

    for (Map<String, dynamic> taskJsonData in json["tasks"]) {
      tasks!.add(Task.fromJson(taskJsonData));
    }
  }
}

class Task extends Equatable{
  
  int? id;
  String? title;
  String? description;
  int? deadlineTimestamp;
  bool? isDone;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.deadlineTimestamp,
    required this.isDone
  });

  Task.fromJson(Map json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    deadlineTimestamp = json["deadlineTimestamp"];
    isDone = json["isDone"];
  }
  
  @override
  List<Object?> get props => [];
}
