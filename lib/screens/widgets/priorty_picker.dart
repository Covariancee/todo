import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xyz/screens/widgets/priorty_card.dart';

import '../../provider/add_task_controller.dart';

class PriorityPicker extends StatefulWidget {
  const PriorityPicker({
    Key? key,
  }) : super(key: key);

  @override
  State<PriorityPicker> createState() => _PriorityPickerState();
}

class _PriorityPickerState extends State<PriorityPicker> {
  final List priority = [1, 2, 3, 4, 5, 6];
  @override
  Widget build(BuildContext ctx) {
    return Consumer<AddTaskProvider>(
      builder: (context, provider, child) {
        return AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
          scrollable: true,
          title: const Text(
            'Task priority',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: 600,
            height: 280,
            child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30),
              itemCount: priority.length,
              itemBuilder: (BuildContext ctx, int index) {
                return PriorityCard(
                  priorty: priority[index],
                  onSelectPriority: () {
                    provider.selectedPriority = priority[index].toString();
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
