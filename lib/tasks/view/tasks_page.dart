import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:task_front/services/api/user.dart';
import 'package:task_front/services/validator.dart';
import 'package:task_front/tasks/bloc/task_bloc.dart';
import 'package:task_front/tasks/view/task_list_component.dart';
import 'package:task_front/user/bloc/user_bloc.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      if (state is TasksLoaded) {
        return TasksListComponent();
      }
      return Text("no data");
    });
  }
}
