import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xyz/screens/task_screen.dart';
import 'package:xyz/services/hex_to_color.dart';

import '../../models/task.dart';

class TaskListTile extends StatefulWidget {
  const TaskListTile({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  IconData? icon;
  late Color color;

  @override
  void initState() {
    super.initState();
    icon = getIconFromJson(widget.task.icon);
    color = HexColor(widget.task.color);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.all(Radius.circular(16))),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => TaskScreen(
                      task: widget.task,
                    )));
          },
          child: ListTile(
            leading: Text(widget.task.priority),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon),
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
        ),
      ),
    );
  }
}
