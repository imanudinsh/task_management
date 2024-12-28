import 'package:task_management/data/model/task_model.dart';
import 'package:task_management/domain/repositories/task_repository.dart';
import 'package:task_management/utils/enum/task_status.dart';

class AddTaskUseCase {
  final TaskRepository taskRepository;

  AddTaskUseCase(this.taskRepository);

  Future<void> execute(Task task) async {
    if (task.title.isEmpty) {
      throw InvalidTaskException('Task title cannot be empty.');
    }

    await taskRepository.insertTask(task);
  }
}

class GetTasksUseCase {
  final TaskRepository taskRepository;

  GetTasksUseCase(this.taskRepository);

  Future<List<Task>> execute() async {
    return await taskRepository.getTasks();
  }
}

class SearchTasksUseCase {
  final TaskRepository taskRepository;

  SearchTasksUseCase(this.taskRepository);

  Future<List<Task>> execute(String keyword) async {
    return await taskRepository.searchTasks(keyword);
  }
}

class SortTasksUseCase {
  final TaskRepository taskRepository;

  SortTasksUseCase(this.taskRepository);

  Future<List<Task>> execute(int sortOption) async {
    return await taskRepository.sortTasks(sortOption);
  }
}

class UpdateTaskUseCase {
  final TaskRepository taskRepository;

  UpdateTaskUseCase(this.taskRepository);

  Future<void> execute(Task task) async {
    if (task.id == null) {
      throw InvalidTaskException('Task ID cannot be null.');
    }

    await taskRepository.updateTask(task);
  }
}

class DeleteTaskUseCase {
  final TaskRepository taskRepository;

  DeleteTaskUseCase(this.taskRepository);

  Future<void> execute(int taskId) async {
    if (taskId == null) {
      throw InvalidTaskException('Task ID cannot be null.');
    }

    await taskRepository.deleteTask(taskId);
  }
}

class UpdateTaskStatusUseCase {
  final TaskRepository taskRepository;

  UpdateTaskStatusUseCase(this.taskRepository);

  Future<void> execute(Task task, TaskStatus newStatus) async {
    if (task.id == null) {
      throw InvalidTaskException('Task ID cannot be null.');
    }

    await taskRepository.updateTask(task.copyWith(status: newStatus));
  }
}

class SyncPendingTasksUseCase {
  final TaskRepository taskRepository;

  SyncPendingTasksUseCase(this.taskRepository);

  Future<void> execute(List<Task> tasks) async {
    if (tasks.isEmpty) return;
    await taskRepository.syncTasks(tasks);
  }
}

class InvalidTaskException implements Exception {
  final String message;

  InvalidTaskException(this.message);
}