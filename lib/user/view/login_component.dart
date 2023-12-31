import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:task_front/services/api/user.dart';
import 'package:task_front/services/validator.dart';
import 'package:task_front/tasks/bloc/task_bloc.dart';
import 'package:task_front/tasks/view/tasks_page.dart';
import 'package:task_front/user/bloc/user_bloc.dart';
import 'package:task_front/user/page/login_page.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  Future<String?> validateAndLogIn(
      String? givenEmail, String? givenPassword) async {
    Map<String, dynamic> loginResponse =
        await UserApi.login(email: givenEmail, password: givenPassword);

    if (loginResponse["error"] != null) {
      return loginResponse["error"].body.message;
    }

    context
        .read<UserBloc>()
        .add(LoadUserAuth(givenEmail ?? "", loginResponse["newToken"] ?? ""));
    context.read<TaskBloc>().add(LoadTasks(loginResponse["newToken"] ?? ""));

    return null;
  }

  Future<String?> validateAndSignIn(
      String? givenEmail, String? givenPassword) async {
    Map<String, dynamic> loginResponse =
        await UserApi.create(email: givenEmail, password: givenPassword);

    if (loginResponse["error"] != null) {
      return loginResponse["error"].body.message;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      onLogin: (loginData) async {
        String? userValidationError =
            await validateAndLogIn(loginData.name, loginData.password);

        if (userValidationError == null) {
          await Future.delayed(const Duration(seconds: 3));

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TasksPage()),
          );
          return null;
        }
        return userValidationError;
      },
      onRecoverPassword: (loginData) {},
      onSignup: (loginData) async {
        String? userValidationError =
            await validateAndSignIn(loginData.name, loginData.password);
        if (userValidationError == null) {
          return null;
        }

        return userValidationError;
      },
      passwordValidator: Validator.isCorrectNewPassword,
      loginAfterSignUp: false,
    );
  }
}
