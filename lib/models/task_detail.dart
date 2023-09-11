import 'package:cloud_firestore/cloud_firestore.dart';

class TaskDetail {
  String taskDetail;
  String description;
  DateTime timestamp;
  bool taskStatus;
  String id;

  TaskDetail(
      {required this.taskDetail,
      required this.description,
      required this.timestamp,
      required this.taskStatus,
      required this.id});

  factory TaskDetail.fromJson(Map<String, dynamic> json) {
    return TaskDetail(
      description: json['description'] ?? '',
      taskDetail: json['taskDetail'] ?? '',
      timestamp: DateTime.parse(json['timestamp'] ?? ''),
      taskStatus: json['taskStatus'] ?? '',
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskDetail': taskDetail,
      'description': description,
      'timestamp': timestamp.toUtc().toIso8601String(),
      'taskStatus': taskStatus,
    };
  }

  factory TaskDetail.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    return TaskDetail(
      description: data?['description'] ?? '',
      taskDetail: data?['taskDetail'] ?? '',
      timestamp: data?['timestamp'] != null
          ? (data!['timestamp'] as Timestamp).toDate()
          : DateTime.now(),
      taskStatus: data?['taskStatus'] ?? false,
      id: data?['id'],
    );
  }
}
