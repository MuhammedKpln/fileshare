/// Route meta data
enum RouteMetaData {
  /// Home start screen
  home('home', '/'),

  ///Login
  login('login', '/auth/login'),

  ///Settings
  settings('settings', '/settings');

  /// Route name
  final String routeName;

  /// Route path
  final String routePath;

  /// Routes Name
  //ignore:sort_constructors_first
  const RouteMetaData(this.routeName, this.routePath);
}
