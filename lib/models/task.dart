import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String category;
  String description;
  String priority;
  String task;
  DateTime timestamp;
  String color;
  String icon;
  String owner;
  String id;

  Task({
    required this.category,
    required this.description,
    required this.priority,
    required this.task,
    required this.timestamp,
    required this.color,
    required this.icon,
    required this.owner,
    required this.id,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      priority: json['priority'] ?? '',
      task: json['task'] ?? '',
      timestamp: DateTime.parse(json['timestamp'] ?? ''),
      color: 'color',
      icon: 'icon',
      owner: 'owner',
      id: 'id',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'description': description,
      'priority': priority,
      'task': task,
      'timestamp': timestamp.toUtc().toIso8601String(),
    };
  }

  factory Task.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    return Task(
      category: data?['category'],
      description: data?['description'],
      priority: data?['priority'],
      task: data?['task'],
      timestamp: data?['timestamp'] != null
          ? (data!['timestamp'] as Timestamp).toDate()
          : DateTime.now(),
      color: data?['color'],
      icon: data?['icon'],
      owner: data?['owner'],
      id: data?['id'],
    );
  }
}
