import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xyz/provider/home_screen_provider.dart';
import 'package:xyz/screens/widgets/add_task.dart';
import 'package:xyz/screens/widgets/connection_check.dart';
import 'package:xyz/screens/widgets/custom_bottom_navigation_bar.dart';
import 'package:xyz/screens/widgets/no_task_screen.dart';
import 'package:xyz/screens/widgets/task_list_tile.dart';
import 'package:xyz/services/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ConnectionCheck(
      child: Consumer<HomeScreenProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home Screen'),
              centerTitle: true,
            ),
            body: StreamBuilder(
                stream: provider.getTask(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const NoTaskScreen();
                  } else {
                    final task = snapshot.data;
                    return SafeArea(
                      /// bu sized box ı widget yap
                      child: SizedBox(
                        height: 400,
                        child: ListView.builder(
                            itemCount: task!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Dismissible(

                                  ///dismissible çalışmıyor
                                  key: Key(task[index].description),
                                  onDismissed: (direction) {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      deleteTodo('index');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("$task deleted"),
                                        ),
                                      );
                                    }
                                  },
                                  child: TaskListTile(task: task[index]));
                            }),
                      ),
                    );
                  }
                }),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const AddTask();
                  },
                );
              },
              backgroundColor: Colors.deepPurple,
              child: const Icon(Icons.add),
            ),
            bottomNavigationBar: const CustomBottomNavigationBar(),
          );
        },
      ),
    );
  }
}
