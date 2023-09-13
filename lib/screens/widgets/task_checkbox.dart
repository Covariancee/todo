import 'package:flutter/material.dart';
import 'package:xyz/models/task_detail.dart';
import 'package:xyz/services/services.dart';

import '../../models/task.dart';

class TaskCheckbox extends StatefulWidget {
  const TaskCheckbox({Key? key, required this.taskDetail, required this.task})
      : super(key: key);
  final TaskDetail taskDetail;
  final Task task;

  @override
  State<TaskCheckbox> createState() => _TaskCheckboxState();
}

class _TaskCheckboxState extends State<TaskCheckbox> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.taskDetail.taskStatus;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        value: isChecked,
        onChanged: (newValue) {
          setState(() {
            isChecked = newValue!;
            updateTaskDetailStatus(
                widget.task.id, widget.taskDetail.id, newValue);
          });
        },
        title: Text(widget.taskDetail.taskDetail));
  }
}
