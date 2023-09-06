import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/category.dart';

class AddTaskProvider extends ChangeNotifier {
  AddTaskProvider() {
    init();
  }

  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKeyTask = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyTime = GlobalKey<FormState>();
  List<Category> category = [];

  Future<void> init() async {
    String file = await rootBundle.loadString('assets/json/category.json');
    List<dynamic> jsonData = jsonDecode(file);
    category = jsonData
        .map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toList();
    print(category);
  }
}

dynamic taskValidator = (value) {
  if (value == null || value.isEmpty) {
    return 'cannot be empty';
  }
  if (value.length <= 1) {
    return 'must be longer than 2';
  }
  if (value.length >= 17) {
    return 'too long';
  }
  {
    return null;
  }
};
Future<void> selectDateTime(BuildContext context) async {
  var selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(DateTime.now().year + 1),
  );

  if (selectedDate != null) {
    var selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      print("Seçilen Tarih ve Saat: $selectedDate");
    }
  }
}
