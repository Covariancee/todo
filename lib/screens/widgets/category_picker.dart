import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/add_task_controller.dart';
import 'category_card.dart';

class CategoryPicker extends StatefulWidget {
  const CategoryPicker({Key? key, required this.category}) : super(key: key);

  final List category;

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
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
            TextButton(
              onPressed: () {},
              child: const Text('Add Category'),
            )
          ],
          scrollable: true,
          title: const Text(
            'Chose Category',
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
              itemCount: widget.category.length,
              itemBuilder: (BuildContext ctx, int index) {
                return CategoryCard(
                  category: widget.category[index],
                  onSelectCategory: () {
                    provider.selectedCategory = widget.category[index];
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
