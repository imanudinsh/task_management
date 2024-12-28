import 'package:task_management/utils/enum/task_status.dart';

class TaskEntity {
  int? id;
  String title;
  String description;
  TaskStatus status;
  DateTime createdDate;
  DateTime? dueDate;
  int syncStatus;

  TaskEntity({
    this.id,
    required this.title,
    required this.description,
    this.status = TaskStatus.Pending,
    required this.createdDate,
    this.dueDate,
    this.syncStatus = 0,
  });
}