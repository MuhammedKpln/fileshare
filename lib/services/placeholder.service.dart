import 'package:boilerplate/models/todo.model.dart';
import 'package:boilerplate/services/_base.service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// It's creating a provider for the PlaceholderService.
final placeholderService = Provider<PlaceholderService>((ref) {
  return PlaceholderService();
});

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
    try {
      final request = await api.get<List<Todo>>(ApiEndpoints.Todos.path);

      return request.data;
    } catch (err) {
      rethrow;
    }
  }
}
