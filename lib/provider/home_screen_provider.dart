import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xyz/models/task.dart';

class HomeScreenProvider extends ChangeNotifier {
  String id = '';
  Stream<List<Task>> getTask() {
    final stream = FirebaseFirestore.instance.collection('todos').snapshots();

    return stream.map((event) => event.docs.map((doc) {
          return Task.fromSnapshot(doc);
        }).toList());
  }
}
