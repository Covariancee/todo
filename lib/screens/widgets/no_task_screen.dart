import 'package:flutter/material.dart';

class NoTaskScreen extends StatelessWidget {
  const NoTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('What do you want to do ?'), Text('tab add your tasks')],
    ));
  }
}
