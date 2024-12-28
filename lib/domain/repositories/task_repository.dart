import 'package:task_management/data/model/task_model.dart';

abstract class TaskRepository {

  Future<int> insertTask(Task task);

  Future<List<Task>> getTasks();

  Future<List<Task>> searchTasks(String keyword);

  Future<List<Task>> sortTasks(int sortOption);

  Future<int> updateTask(Task task);

  Future<int> deleteTask(int id);

  Future<void> syncTasks(List<Task> tasks);
}