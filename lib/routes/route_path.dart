class RoutePath {
  final String? pathName;
  final bool isNotfound;

  RoutePath.login(this.pathName) : isNotfound = false;

  RoutePath.dashboard(this.pathName) : isNotfound = false;

  RoutePath.otherPage(this.pathName) : isNotfound = false;

  RoutePath.notFound(this.pathName) : isNotfound = true;

  bool get isLoginPage => pathName == '/login';
  bool get isDashboardPage => pathName == '/dashboard';

  bool get isOtherPage => pathName != null;
}
