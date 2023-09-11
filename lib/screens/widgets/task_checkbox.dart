import 'package:flutter/material.dart';
import 'package:xyz/models/task_detail.dart';

class TaskCheckbox extends StatefulWidget {
  const TaskCheckbox({Key? key, required this.taskDetail}) : super(key: key);
  final TaskDetail taskDetail;

  @override
  State<TaskCheckbox> createState() => _TaskCheckboxState();
}

class _TaskCheckboxState extends State<TaskCheckbox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: CheckboxListTile(
          value: false,
          onChanged: (newValue) {},
          title: Text(widget.taskDetail.taskDetail)),
    );
  }
}
