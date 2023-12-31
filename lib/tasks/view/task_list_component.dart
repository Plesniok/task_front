import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:task_front/services/api/user.dart';
import 'package:task_front/services/validator.dart';
import 'package:task_front/tasks/bloc/task_bloc.dart';
import 'package:task_front/tasks/view/task_cell.dart';
import 'package:task_front/user/bloc/user_bloc.dart';

class TasksListComponent extends StatefulWidget {
  @override
  _TasksListComponentState createState() => _TasksListComponentState();
}

class _TasksListComponentState extends State<TasksListComponent> {
  Timer? refreshTasksTimer;

  @override
  void initState() {
    refreshTasksTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {
        context
            .read<TaskBloc>()
            .add(RefreshTask(context.read<UserBloc>().state.token));
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (refreshTasksTimer != null) refreshTasksTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      if (state is TasksLoaded) {
        return state.tasks != null
            ? Center(
                child: ListView(children: [
                  Column(
                    children: state.tasks!.tasks!
                        .map((taskData) => !(taskData.isDone ?? true)
                            ? TaskCell(
                                taskData: taskData,
                                token:
                                    context.read<UserBloc>().state.token ?? "",
                              )
                            : Container())
                        .toList(),
                  ),
                ]),
              )
            : Text("Error loading tasks");
      }
      return Text("no data");
    });
  }
}
