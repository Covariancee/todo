import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:xyz/provider/add_task_controller.dart';
import 'package:xyz/screens/widgets/category_picker.dart';
import 'package:xyz/screens/widgets/priorty_picker.dart';
import 'package:xyz/services/services.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddTaskProvider>(builder: (context, provider, child) {
      return SizedBox(
        height: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: provider.formKeyTask,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Add Task',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Task'),
                    ),
                    validator: taskValidator,
                    controller: provider.taskController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 20),
                TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Description'),
                    ),
                    validator: taskValidator,
                    controller: provider.descriptionController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            provider.selectDateTime(context);
                          },
                          icon: const Icon(Icons.timer_outlined),
                        ),
                        IconButton(
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CategoryPicker(
                                      category: provider.category);
                                });
                          },
                          icon: const Icon(Icons.discount_outlined),
                        ),
                        IconButton(
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const PriorityPicker();
                                });
                          },
                          icon: const Icon(Icons.flag_outlined),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        provider.currentId = Uuid().v4();
                        addTodo(
                          provider.taskController.text,
                          provider.descriptionController.text,
                          provider.selectedPDateTime,
                          provider.selectedCategory.title,
                          provider.selectedPriority,
                          provider.selectedCategory.color,
                          provider.selectedCategory.icon,
                          provider.currentUsername,
                          provider.currentId,
                          false,
                        );

                        ///bunu fonksiyon haline getir burada çağır
                        provider.taskController.text = '';
                        provider.descriptionController.text = '';
                        provider.selectedPDateTime = DateTime.now();

                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.send_outlined),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
