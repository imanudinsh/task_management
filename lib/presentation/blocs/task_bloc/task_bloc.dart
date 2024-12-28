import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/data/model/task_model.dart';
import 'package:task_management/domain/usecases/task_use_cases.dart';
import 'package:task_management/injection.dart' as di;

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {

  final AddTaskUseCase addTaskUseCase = di.locator.get<AddTaskUseCase>();
  final GetTasksUseCase getTasksUseCase = di.locator.get<GetTasksUseCase>();
  final SortTasksUseCase sortTasksUseCase = di.locator.get<SortTasksUseCase>();
  final SearchTasksUseCase searchTasksUseCase = di.locator.get<SearchTasksUseCase>();
  final UpdateTaskUseCase updateTaskUseCase = di.locator.get<UpdateTaskUseCase>();
  final DeleteTaskUseCase deleteTaskUseCase = di.locator.get<DeleteTaskUseCase>();
  final UpdateTaskStatusUseCase updateTaskStatusUseCase = di.locator.get<UpdateTaskStatusUseCase>();
  final SyncPendingTasksUseCase syncPendingTasksUseCase = di.locator.get<SyncPendingTasksUseCase>();


  TaskBloc()
      : super(TaskInitial()) {

    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await getTasksUseCase.execute();
        emit(TaskLoaded(tasks));
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });
    on<SearchTask>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await searchTasksUseCase.execute(event.keyword);
        emit(TaskLoaded(tasks));
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });
    on<AddTask>((event, emit) async {
      try {
        await addTaskUseCase.execute(event.task);
        emit(AddTaskSuccess());
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });
    on<UpdateTask>((event, emit) async {
      try {
        await updateTaskUseCase.execute(event.task);
        emit(UpdateTaskSuccess()); // Reload tasks after updating
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });
    on<DeleteTask>((event, emit) async {
      try {
        await deleteTaskUseCase.execute(event.taskId);
        add(LoadTasks()); // Reload tasks after deleting
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });
    // on<UpdateTaskStatus>((event, emit) async {
    //   try {
    //     final updatedTask = event.task.copyWith(status: event.newStatus);
    //     await _taskRepository.updateTask(updatedTask);
    //     add(LoadTasks()); // Reload tasks after updating status
    //   } catch (e) {
    //     emit(TaskError(e.toString()));
    //   }
    // });
    on<SortTask>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await sortTasksUseCase.execute(event.sortOption);
        emit(TaskLoaded(tasks));
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });

    on<SyncPendingTasks>((event, emit) async {
      try {
        final tasks = await getTasksUseCase.execute();
        var pendingTasks = tasks.where((e)=> e.syncStatus == 0).toList();
        if(pendingTasks.isNotEmpty) await syncPendingTasksUseCase.execute(pendingTasks);
      } catch (e) {
        // emit(TaskError(e.toString()));
      }
    });
  }
}