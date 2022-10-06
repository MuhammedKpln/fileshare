import 'package:boilerplate/providers/todo.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodosView extends ConsumerWidget {
  const TodosView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getTodos = ref.watch(placeholderProvider.notifier);
    final todos = ref.watch(placeholderProvider);

    return Scaffold(
      appBar: AppBar(),
      body: todos.when(
        data: (data) {
          return ListView.builder(
            itemBuilder: (context, index) {
              if (data == null) return const Text('no data exists');
              final todo = data[index];

              return ListTile(
                leading: Text(index.toString()),
                title: Text(todo.title),
              );
            },
          );
        },
        error: (_, __) => const Text('Oh no could not fetch the data!'),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
