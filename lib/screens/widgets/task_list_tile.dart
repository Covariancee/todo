import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/task.dart';

class TaskListTile extends StatefulWidget {
  const TaskListTile({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Okay'))
            ],
            title: Text(widget.task.task),
            content: Text(widget.task.description),
          ),
        );
      },
      child: ListTile(
        leading: Text(widget.task.priority),
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.task.task),
                ],
              ),
              SizedBox(
                width: 80,
                child: Text(
                    style: const TextStyle(fontSize: 12),
                    DateFormat('dd/MM/yyyy HH:mm')
                        .format(widget.task.timestamp)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
