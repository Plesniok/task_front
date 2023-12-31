import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_front/tasks/view/tasks_page.dart';
import 'package:task_front/user/bloc/user_bloc.dart';
import 'package:task_front/user/view/login_component.dart';
import 'package:flutter_login/flutter_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state.token != null) {
            return TasksPage();
          }
          return LoginWidget();
        },
      ),
    );
  }
}
