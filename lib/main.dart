import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:task_front/tasks/bloc/task_bloc.dart';
import 'package:task_front/tasks/hadlers/add_task_floating_button.dart';
import 'package:task_front/user/bloc/user_bloc.dart';
import 'package:task_front/user/page/login_page.dart';

void main() async {
  await dotenv.load(fileName: "lib/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Front',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(
            create: (BuildContext context) => UserBloc(),
          ),
          BlocProvider<TaskBloc>(
            create: (BuildContext context) => TaskBloc(),
          ),
        ],
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // context.read<UserBloc>().add(CheckUserStorage());
    // UserState contextUserState = context.read<UserBloc>().state;
    // if (contextUserState.token != null)
    //   context.read<TaskBloc>().add(LoadTasks(contextUserState.token));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
              actions: [
                state.token != null
                    ? BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          return IconButton(
                            icon: Icon(Icons.exit_to_app),
                            onPressed: () {
                              context.read<UserBloc>().add(Logout());
                            },
                          );
                        },
                      )
                    : Container(),
              ],
            ),
            body: const LoginPage(),
            floatingActionButton: state.token != null
                ? FloatingActionButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddTaskFloatingButton(
                            token: state.token,
                          );
                        },
                      );
                    },
                    tooltip: "Add new task",
                    child: const Icon(Icons.add),
                  )
                : null);
      },
    );
  }
}
