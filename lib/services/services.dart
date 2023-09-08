import 'package:cloud_firestore/cloud_firestore.dart';

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
) async {
  final CollectionReference todos =
      FirebaseFirestore.instance.collection('todos');

  await todos.add({
    'task': task,
    'description': description,
    'timestamp': time,
    'category': category,
    'priority': priority,
  });
}

Future<void> deleteTodo(String todoId) async {
  try {
    await FirebaseFirestore.instance.collection('todos').doc(todoId).delete();
    print('Belge silindi: $todoId');
  } catch (e) {
    print('Belge silme hatası: $e');
  }
}
