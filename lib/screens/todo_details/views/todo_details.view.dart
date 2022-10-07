import 'package:boilerplate/screens/todo_details/controllers/todo_details.controller.dart';
import 'package:flutter/material.dart';

/// It's a `StatelessWidget` that displays a `Scaffold` with an `AppBar` and a `FutureBuilder` that
/// displays a `CircularProgressIndicator` while the `TodoDetailsViewController` is fetching the `Todo`
/// and displays the `Todo`'s title when it's done
class TodoDetailsView extends StatelessWidget {
  /// It's a required parameter that is passed to the `TodoDetailsView` when it's created.
  const TodoDetailsView({super.key, required this.todoId});

  /// It's a required parameter that is passed to the `TodoDetailsView` when it's created.
  final int todoId;

  @override
  Widget build(BuildContext context) {
    final controller = TodoDetailsViewController();

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: controller.fetchTodo(todoId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text('No data exists');
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              return Center(child: Text(controller.todo.title));
          }
        },
      ),
    );
  }
}
