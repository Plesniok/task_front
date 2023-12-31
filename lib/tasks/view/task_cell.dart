import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:intl/intl.dart';
import 'package:task_front/services/api/user.dart';
import 'package:task_front/services/validator.dart';
import 'package:task_front/tasks/bloc/task_bloc.dart';
import 'package:task_front/tasks/hadlers/edit_task_button.dart';
import 'package:task_front/tasks/model/task.dart';
import 'package:task_front/user/bloc/user_bloc.dart';

class TaskCell extends StatefulWidget {
  Task taskData;
  String token;

  TaskCell({super.key, required this.taskData, required this.token});

  @override
  _TaskCellState createState() => _TaskCellState();
}

class _TaskCellState extends State<TaskCell> {
  String? formatTimestamp(int? timestamp) {
    if (timestamp == null) return null;

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    String formattedDateTime = DateFormat('yyyy-MM-dd').format(dateTime);

    return formattedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EditTaskButton(
                taskData: widget.taskData,
                token: widget.token
              );
            },
          );
        },
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).colorScheme.inversePrimary),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.taskData.title ?? "-",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formatTimestamp(widget.taskData.deadlineTimestamp) ?? "-",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.taskData.description ?? "-",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
