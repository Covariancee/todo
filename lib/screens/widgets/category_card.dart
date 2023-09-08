import 'package:flutter/material.dart';
import 'package:xyz/services/hex_to_color.dart';

import '../../models/category.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    Key? key,
    required this.category,
    required this.onSelectCategory,
  }) : super(key: key);
  final Category category;
  final void Function() onSelectCategory;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  String selectedCategory = '';
  @override
  Widget build(BuildContext context) {
    String hexColor = widget.category.color;
    Color color = HexColor(hexColor);
    IconData? categoryIcon = getIconFromJson(widget.category.icon);

    return InkWell(
      onTap: widget.onSelectCategory,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(categoryIcon),
            ),
            Center(
              child: Text(
                widget.category.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
