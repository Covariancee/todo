import 'package:flutter/material.dart';

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
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 200, minWidth: 200),
      child: AlertDialog(
        title: const Text(
          'Chose Category',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            GridView.builder(
              // shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: widget.category.length,
              itemBuilder: (BuildContext ctx, int index) {
                return CategoryCard(
                  category: widget.category[index],
                  onSelectCategory: () {},
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
