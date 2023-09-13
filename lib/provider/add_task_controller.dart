import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/category.dart';
import '../models/task_detail.dart';
import '../services/services.dart';

class AddTaskProvider extends ChangeNotifier {
  AddTaskProvider() {
    init();
  }

  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  GlobalKey<FormState> formKeyTask = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyTime = GlobalKey<FormState>();
  List<Category> category = [];
  Category selectedCategory = Category(id: 1, title: '', color: '', icon: '');
  String selectedPriority = '0';
  DateTime selectedPDateTime = DateTime.now();
  String currentUsername = '';
  List selectedTaskDetailList = [];
  String currentId = '';

  void setCurrentUsername() async {
    currentUsername =
        await getUsernameFromUserId(FirebaseAuth.instance.currentUser!.uid);
    notifyListeners();
  }

  Future<void> init() async {
    String file = await rootBundle.loadString('assets/json/category.json');
    List<dynamic> jsonData = jsonDecode(file);
    category = jsonData
        .map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toList();
    setCurrentUsername();
  }

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

        selectedPDateTime = selectedDate;
      }
    }
  }

  Stream<List<TaskDetail>> getTaskDetail(String taskId) {
    final stream = FirebaseFirestore.instance
        .collection("todos")
        .doc(taskId)
        .collection("detail")
        .where('isDeleted', isEqualTo: false)
        .snapshots();

    return stream.map((event) => event.docs.map((doc) {
          return TaskDetail.fromSnapshot(doc);
        }).toList());
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
