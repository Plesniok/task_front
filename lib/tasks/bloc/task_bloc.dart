import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_front/services/api/task.dart';
import 'package:task_front/tasks/model/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskInitial()) {
    on<LoadTasks>((event, emit) async {
      try {
        Map<String, dynamic> tasksJson =
            await TaskApi.getTasks(token: event.token);
        emit(TaskInitial());
        emit(TasksLoaded(Tasks.fromJson(tasksJson)));
      } catch (e) {
        emit(TasksLoaded(Tasks(tasks: [
          Task(
              id: 0,
              title: "not done",
              description: "not done",
              deadlineTimestamp: 123,
              isDone: false)
        ])));
      }
    });

    on<RefreshTask>((event, emit) async {
      try {
        Map<String, dynamic> tasksJson =
            await TaskApi.getTasks(token: event.token);
        emit(TaskInitial());
        emit(TasksLoaded(Tasks.fromJson(tasksJson)));
      } catch (e) {
        emit(TasksLoaded(Tasks(tasks: [
          Task(
              id: 0,
              title: "not done",
              description: "not done",
              deadlineTimestamp: 123,
              isDone: false)
        ])));
      }
    });
  }
}
