/// Route meta data
enum RouteMetaData {
  /// Home start screen
  home('home', '/'),

  ///Login
  login('login', '/auth/login'),

  ///Settings
  settings('settings', '/settings'),

  /// Send file
  sendFile('send_file', '/send_file');

  /// Route name
  final String routeName;

  /// Route path
  final String routePath;

  /// Routes Name
  //ignore:sort_constructors_first
  const RouteMetaData(this.routeName, this.routePath);
}
