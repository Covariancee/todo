import 'package:flutter/material.dart';

import '../../services/hex_to_color.dart';

class PriorityCard extends StatefulWidget {
  const PriorityCard({
    Key? key,
    required this.onSelectPriority,
    required this.priorty,
  }) : super(key: key);

  final void Function() onSelectPriority;
  final int priorty;

  @override
  State<PriorityCard> createState() => _PriorityCardState();
}

class _PriorityCardState extends State<PriorityCard> {
  @override
  void initState() {
    super.initState();
    priorityText = getPriorityFromNumber(widget.priorty);
  }

  String priorityText = "";
  @override
  Widget build(BuildContext context) {
    IconData? categoryIcon = Icons.outlined_flag_outlined;

    return InkWell(
      onTap: widget.onSelectPriority,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Center(
              child: Text(
                priorityText,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(categoryIcon),
            ),
          ],
        ),
      ),
    );
  }
}
