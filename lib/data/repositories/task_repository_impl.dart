import 'package:flutter/cupertino.dart';
import 'package:task_management/data/datasources/local/database_helper.dart';
import 'package:task_management/data/datasources/remote/endpoint.dart';
import 'package:task_management/data/datasources/remote/network_service.dart';
import 'package:task_management/data/model/task_model.dart';
import 'package:task_management/domain/repositories/task_repository.dart';
import 'package:task_management/utils/enum/task_status.dart';

class TaskRepositoryImpl extends TaskRepository{
  final DatabaseHelper databaseHelper;
  final NetworkService networkService;

  TaskRepositoryImpl({required this.databaseHelper, required this.networkService});

  @override
  Future<int> insertTask(Task task) async {
    return await databaseHelper.insertTask(task);
  }

  @override
  Future<List<Task>> getTasks() async {
    return await databaseHelper.getTasks();
  }
  
  @override
  Future<List<Task>> searchTasks(String keyword) async {
    var tasks = await databaseHelper.searchTasks(keyword);
    return tasks;
  }

  @override
  Future<List<Task>> sortTasks(int sortOption) async {
    var tasks = await databaseHelper.getTasks();
    switch (sortOption) {
      case 0:
        tasks.sort((a, b) {
          // Sort by due date
          if (a.dueDate!.isAfter(b.dueDate!)) {
            return 1;
          } else if (a.dueDate!.isBefore(b.dueDate!)) {
            return -1;
          }
          return 0;
        });
        break;
      case 1:
      //sort by completed tasks
        tasks.removeWhere((e) => e.status != TaskStatus.Completed);
        break;
      case 2:
      //sort by pending tasks
        tasks.removeWhere((e) => e.status != TaskStatus.InProgress);
        break;
      case 3:
      //sort by pending tasks
        tasks.removeWhere((e) => e.status != TaskStatus.Pending);
        break;
    }
    return tasks;
  }

  @override
  Future<int> updateTask(Task task) async {
    return await databaseHelper.updateTask(task);
  }

  @override
  Future<int> deleteTask(int id) async {
    return await databaseHelper.deleteTask(id);
  }


  @override
  Future<void> syncTasks(List<Task> tasks) async {

    debugPrint("Start synchronize ${tasks.length} pending tasks");
    for (var task in tasks) {
      final response = await networkService.insertData(
          Endpoint.task,
          task.toMap()
      );

      debugPrint("Response status code : ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Task ${task.title} successfully submitted");
        var taskUpdate = task;
        taskUpdate.syncStatus = 1;
        await updateTask(taskUpdate);
      } else {
        print('Error syncing task: ${task.title}');
      }
    }
    debugPrint("Synchronization complete");

  }
}