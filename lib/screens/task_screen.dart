import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:xyz/provider/add_task_controller.dart';
import 'package:xyz/screens/widgets/no_task_screen.dart';
import 'package:xyz/screens/widgets/task_checkbox.dart';

import '../models/task.dart';
import '../services/services.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  String detailID = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<AddTaskProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          floatingActionButton: TextButton(
            onPressed: () {
              detailID = const Uuid().v4();
              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                  detailID = const Uuid().v4();
                                  if (provider
                                      .detailController.text.isNotEmpty) {
                                    addDetail(
                                      provider.detailController.text,
                                      provider.descriptionController.text,
                                      widget.task.timestamp,
                                      false,
                                      widget.task.id,
                                      detailID,
                                      false,
                                    );
                                    provider.detailController.text = '';
                                  }
                                },
                                child: const Text('add more')),
                            TextButton(
                                onPressed: () {
                                  if (provider
                                      .detailController.text.isNotEmpty) {
                                    addDetail(
                                        provider.detailController.text,
                                        provider.descriptionController.text,
                                        widget.task.timestamp,
                                        false,
                                        widget.task.id,
                                        detailID,
                                        false);
                                  }
                                  Navigator.pop(context);
                                },
                                child: const Text('add'))
                          ],
                          title: const Text('add to list'),
                          content: TextFormField(
                              validator: taskValidator,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: provider.detailController)));
            },
            child: const Text('add'),
          ),
          appBar: AppBar(
            title: Text(widget.task.task),
          ),
          body: Center(
            child: Column(
              children: [
                Text(widget.task.description),
                SizedBox(
                  height: 400,
                  child: StreamBuilder(
                      stream: provider.getTaskDetail(widget.task.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const NoTaskScreen();
                        } else {
                          final taskDetail = snapshot.data;
                          return SafeArea(
                            child: SizedBox(
                              height: 400,
                              child: ListView.builder(
                                  itemCount: taskDetail!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Dismissible(
                                        key: Key(taskDetail[index].id),
                                        onDismissed: (direction) {
                                          if (direction ==
                                              DismissDirection.endToStart) {
                                            softDeleteTodoDetail(widget.task.id,
                                                taskDetail[index].id);
                                          }
                                        },
                                        child: TaskCheckbox(
                                            task: widget.task,
                                            taskDetail: taskDetail[index]));
                                  }),
                            ),
                          );
                        }
                      }),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
