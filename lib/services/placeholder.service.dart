import 'package:boilerplate/models/todo.model.dart';
import 'package:boilerplate/services/_base.service.dart';

/// This class is a service that fetches all todos from the API.
class PlaceholderService extends BaseService {
  /// "Fetch all todos from the API and return them as a list of Todo objects."
  ///
  /// The first thing we do is create a request to the API.
  /// We use the `api` object that we create earlier.
  ///
  /// We use the `get` method to make a GET request to the API.
  /// The `get` method takes a path as
  /// a parameter. We use the `path` property of the `ApiEndpoints.Todos` object
  ///
  /// Returns:
  ///   A Future<List<Todo>?>
  Future<List<Todo>?> fetchAllTodos() async {
    final request = await api.get<List<dynamic>>(
      ApiEndpoints.Todos.path,
    );

    final responseBody = request.data;

    return responseBody
        ?.map((e) => Todo.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Todo?> fetchTodo(int todoId) async {
    final request = await api.get<dynamic>(
      '${ApiEndpoints.Todos.path}/$todoId',
    );

    return Todo.fromJson(request.data as Map<String, dynamic>);
  }
}
