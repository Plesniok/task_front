part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {
  String? token;
  
  LoadTasks(this.token);

  @override
  List<Object> get props => [];
}

class RefreshTask extends TaskEvent {
  String? token;
  
  RefreshTask(this.token);

  @override
  List<Object> get props => [];
}
