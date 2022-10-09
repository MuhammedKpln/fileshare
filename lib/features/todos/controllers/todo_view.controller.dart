import 'package:boilerplate/models/todo.model.dart';
import 'package:boilerplate/services/placeholder.service.dart';
import 'package:mobx/mobx.dart';

part 'todo_view.controller.g.dart';

// ignore: library_private_types_in_public_api
/// _TodoViewController is controller for `TodosView`
class TodoViewController = _TodoViewController with _$TodoViewController;

abstract class _TodoViewController with Store {
  final PlaceholderService _placeholderService = PlaceholderService();

  @observable
  List<Todo> todos = [];

  @action
  Future<List<Todo>?> fetchTodos() async {
    final response = await _placeholderService.fetchAllTodos();

    todos = response!;
    await Future.delayed(const Duration(seconds: 3));
    return response;
  }
}
