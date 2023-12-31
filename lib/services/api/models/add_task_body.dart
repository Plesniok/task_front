import 'package:equatable/equatable.dart';

class AddTaskBody extends Equatable{
  String? title;
  String? description;
  int? timestamp;

  AddTaskBody({this.title, this.description, this.timestamp});

  Map<String, dynamic> getPayload(){
    return {
      "title": title,
      "description": description,
      "deadlineTimestamp": timestamp
    };
  }

  @override
  List<Object?> get props => [];
}