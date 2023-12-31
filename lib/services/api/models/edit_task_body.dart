import 'package:equatable/equatable.dart';

class EditTaskBody extends Equatable {
  int? id;
  String? description;
  int? timestamp;

  EditTaskBody({this.id, this.description, this.timestamp});

  Map<String, dynamic> getPayload() {
    return {
      "taskId": id,
      "description": description,
      "deadlineTimestamp": timestamp
    };
  }

  @override
  List<Object?> get props => [];
}
