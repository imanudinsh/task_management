part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final Task task;

  const AddTask(this.task);

  @override
  List<Object> get props => [task];
}

class UpdateTask extends TaskEvent {
  final Task task;

  const UpdateTask(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  final int taskId;

  const DeleteTask(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class SearchTask extends TaskEvent {
  final String keyword;

  SearchTask({required this.keyword});
}

class SortTask extends TaskEvent {
  final int sortOption;

  SortTask({required this.sortOption});
}

class SyncPendingTasks extends TaskEvent {}
