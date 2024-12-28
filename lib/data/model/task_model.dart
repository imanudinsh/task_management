import 'package:task_management/utils/enum/task_status.dart';

class Task {
  int? id;
  String title;
  String description;
  TaskStatus status;
  DateTime createdDate;
  DateTime? dueDate;
  int syncStatus;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.status = TaskStatus.Pending,
    required this.createdDate,
    this.dueDate,
    this.syncStatus = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status.index,
      'createdDate': createdDate.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'syncStatus': syncStatus,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      status: TaskStatus.values[map['status']],
      createdDate: DateTime.parse(map['createdDate'] as String),
      dueDate: map['dueDate'] != null
          ? DateTime.parse(map['dueDate'] as String)
          : null,
      syncStatus: map['syncStatus'] ?? 0,
    );
  }

  Task copyWith({
    int? id,
    String? title,
    String? description,
    TaskStatus? status,
    DateTime? createdDate,
    DateTime? dueDate,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      createdDate: createdDate ?? this.createdDate,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}