import 'package:boilerplate/models/todo.model.dart';
import 'package:boilerplate/services/placeholder.service.dart';
import 'package:mobx/mobx.dart';

part 'todo_details.controller.g.dart';

// ignore: library_private_types_in_public_api
class TodoDetailsViewController = _TodoDetailsViewController
    with _$TodoDetailsViewController;

abstract class _TodoDetailsViewController with Store {
  final PlaceholderService _placeholderService = PlaceholderService();

  @observable
  late Todo todo;

  @action
  Future<void> fetchTodo(int todoId) async {
    final response = await _placeholderService.fetchTodo(todoId);

    if (response != null) {
      todo = response;
    }
  }
}
