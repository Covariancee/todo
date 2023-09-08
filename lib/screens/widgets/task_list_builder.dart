// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class TaskListBuilder extends StatefulWidget {
//   TaskListBuilder({
//     Key? key,
//   }) : super(key: key);
//   late QuerySnapshot task;
//
//   @override
//   State<TaskListBuilder> createState() => _TaskListBuilderState();
// }
//
// class _TaskListBuilderState extends State<TaskListBuilder> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SizedBox(
//         height: 400,
//         child: ListView.builder(
//             itemCount: task.length,
//             itemBuilder: (BuildContext context, int index) {
//               return InkWell(
//                   onTap: () {},
//                   child: ListTile(
//                     title: Text(task[index].description),
//                   ));
//             }),
//       ),
//     );
//   }
// }
