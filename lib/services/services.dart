import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task_detail.dart';

Future<String> getUsernameFromUserId(String userId) async {
  DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();

  if (userSnapshot.exists) {
    Map<String, dynamic>? userData =
        userSnapshot.data() as Map<String, dynamic>?;
    if (userData != null && userData.containsKey('username')) {
      return userData['username'];
    } else {
      return 'Username Not Found';
    }
  } else {
    return 'Unknown User';
  }
}

Future<void> addTodo(
  String task,
  String description,
  DateTime time,
  String category,
  String priority,
  String color,
  String icon,
  String owner,
  String id,
  bool isDeleted,
) async {
  final DocumentReference todoDocument =
      FirebaseFirestore.instance.collection('todos').doc(id);

  await todoDocument.set({
    'task': task,
    'description': description,
    'timestamp': time,
    'category': category,
    'priority': priority,
    'color': color,
    'icon': icon,
    'owner': owner,
    'id': id,
    'isDeleted': isDeleted
  });
}

Future<void> softDeleteTodo(String todoId) async {
  try {
    await FirebaseFirestore.instance
        .collection('todos')
        .doc(todoId)
        .update({'isDeleted': true});
    print('Task Marked as Deleted: $todoId');
  } catch (e) {
    print('Failed to mark task as deleted: $e');
  }
}

Future<void> deleteTodo(String todoId) async {
  try {
    await FirebaseFirestore.instance.collection('todos').doc(todoId).delete();
    print('Task Deleted: $todoId');
  } catch (e) {
    print('Failed to task delete: $e');
  }
}

Future<void> deleteTodoDetail(String todosId, String detailId) async {
  try {
    await FirebaseFirestore.instance
        .collection('todos')
        .doc(todosId)
        .collection('detail')
        .doc(detailId)
        .delete();
    print('Task detail Deleted: $detailId');
  } catch (e) {
    print('Failed to task detail delete: $e');
  }
}

Future<void> softDeleteTodoDetail(String todosId, String detailId) async {
  try {
    await FirebaseFirestore.instance
        .collection('todos')
        .doc(todosId)
        .collection('detail')
        .doc(detailId)
        .update({'isDeleted': true});
    print('Task detail Deleted: $detailId');
  } catch (e) {
    print('Failed to task detail delete: $e');
  }
}

Future<void> addDetail(
  String taskDetail,
  String description,
  DateTime time,
  bool status,
  String todoId,
  String detailId,
  bool isDeleted,
) async {
  final DocumentReference detailDocument = FirebaseFirestore.instance
      .collection('todos')
      .doc(todoId)
      .collection('detail')
      .doc(detailId);

  await detailDocument.set({
    'taskDetail': taskDetail,
    'description': description,
    'timestamp': time,
    'status': status,
    'id': detailId,
    'isDeleted': isDeleted
  });
}

Future<String> getTaskDetailFromTaskId(String taskId) async {
  DocumentSnapshot taskSnapshot =
      await FirebaseFirestore.instance.collection('todos').doc(taskId).get();

  if (taskSnapshot.exists) {
    Map<String, dynamic>? taskData =
        taskSnapshot.data() as Map<String, dynamic>?;
    if (taskData != null && taskData.containsKey('detail')) {
      return taskData['detail'];
    } else {
      return 'Task Not Found';
    }
  } else {
    return 'Unknown Task';
  }
}

Stream<List<TaskDetail>> getTaskDetail(String taskId) {
  final stream = FirebaseFirestore.instance
      .collection("todos")
      .where("Detail", isEqualTo: taskId)
      .snapshots();

  return stream.map((event) => event.docs.map((doc) {
        return TaskDetail.fromSnapshot(doc);
      }).toList());
}

Future<void> updateTaskDetailStatus(
    String taskId, String detailId, bool status) async {
  await FirebaseFirestore.instance
      .collection('todos')
      .doc(taskId)
      .collection('detail')
      .doc(detailId)
      .update({'status': status});
}
