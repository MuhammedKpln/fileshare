import 'package:boilerplate/features/todos/controllers/todo_view.controller.dart';
import 'package:boilerplate/router/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

/// `TodosView` that displays a list of `Todo`s
class TodosView extends StatelessWidget {
  const TodosView({super.key});

  @override
  Widget build(BuildContext context) {
    final todosViewController = TodoViewController();

    navigateToDetails(int todoId) {
      context.pushNamed(
        RouteMetaData.todoDetails.routeName,
        params: {'todoId': todoId.toString()},
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: todosViewController.fetchTodos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text('No data exists');
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              return Observer(
                builder: (context) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final data = todosViewController.todos;

                      if (data.isEmpty) {
                        return const Text('no data exists');
                      }
                      final todo = data[index];

                      return ListTile(
                        leading: Text(index.toString()),
                        title: Text(todo.title),
                        onTap: () => navigateToDetails(todo.id),
                      );
                    },
                    itemCount: todosViewController.todos.length,
                  );
                },
              );
          }
        },
      ),
    );
  }
}
