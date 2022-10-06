import 'package:boilerplate/models/todo.model.dart';
import 'package:boilerplate/services/placeholder.service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Creating a provider that will be used to access the state of the `PlaceholderProvider`
final placeholderProvider = StateNotifierProvider.autoDispose<
    PlaceholderProvider, AsyncValue<List<Todo>?>>((ref) {
  return PlaceholderProvider(ref);
});

/// `UserNotifier` is a `StateNotifier` that holds a list of `Todo`s
class PlaceholderProvider extends StateNotifier<AsyncValue<List<Todo>?>> {
  /// Initializing the state of the provider.
  PlaceholderProvider(this._ref) : super(const AsyncValue.data(<Todo>[])) {
    _placeholderService = _ref.watch(placeholderService);
  }

  final AutoDisposeStateNotifierProviderRef _ref;
  late final PlaceholderService _placeholderService;

  /// `getUsers` is a function that fetches all todos from the placeholder
  /// service and sets the state to the result of the fetch
  Future<void> getUsers() async {
    state = const AsyncValue.loading();
    final res = await AsyncValue.guard(
      () async => _placeholderService.fetchAllTodos(),
    );
    state = AsyncValue.data(res.asData!.value);
  }
}
