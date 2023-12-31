part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();
  
  @override
  List<Object> get props => [];
}

class TasksLoaded extends TaskState {
  Tasks? tasks;

  TasksLoaded(
    this.tasks
  );
}

class TaskInitial extends TaskState {
  const TaskInitial();
}
