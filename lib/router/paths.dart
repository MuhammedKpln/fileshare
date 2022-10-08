/// Route meta data
enum RouteMetaData {
  /// Home start screen
  home('home', '/'),

  /// Todos
  todos('todos', '/todos'),

  ///Todo Details
  todoDetails('todo_details', '/todo/:todoId'),

  ///Login
  login('login', '/auth/login');

  /// Route name
  final String routeName;

  /// Route path
  final String routePath;

  /// Routes Name
  //ignore:sort_constructors_first
  const RouteMetaData(this.routeName, this.routePath);
}
