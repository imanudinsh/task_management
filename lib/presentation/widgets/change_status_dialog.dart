import 'package:flutter/material.dart';
import 'package:task_management/data/model/task_model.dart';
import 'package:task_management/presentation/widgets/text_view.dart';
import 'package:task_management/utils/color_palette.dart';
import 'package:task_management/utils/enum/task_status.dart';

class ChangeStatusDialog extends StatefulWidget {
  final Task task;
  final Function(TaskStatus) onStatusChanged;

  const ChangeStatusDialog({
    Key? key,
    required this.task,
    required this.onStatusChanged,
  }) : super(key: key);

  @override
  State<ChangeStatusDialog> createState() => _ChangeStatusDialogState();
}

class _ChangeStatusDialogState extends State<ChangeStatusDialog> {
  TaskStatus? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.task.status;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Status', style: TextStyle(color: ColorPalette.text, fontSize: 18, fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: TaskStatus.values.map((status) {
          return RadioListTile<TaskStatus>(
            title: Text(status.name),
            value: status,
            groupValue: _selectedStatus,
            contentPadding: const EdgeInsets.symmetric(horizontal:0, vertical: 0),
            activeColor: ColorPalette.colorPrimary,
            onChanged: (TaskStatus? value) {
              setState(() {
                _selectedStatus = value;
              });
            },
          );
        }).toList(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel', style: TextStyle(color: ColorPalette.textPassive, fontWeight: FontWeight.normal)),
        ),
        TextButton(
          onPressed: () {
            widget.onStatusChanged(_selectedStatus!);
            Navigator.of(context).pop();
          },
          child: const Text('Update', style: TextStyle(color: ColorPalette.colorPrimary, fontWeight: FontWeight.normal)),
        ),
      ],
    );
  }
}