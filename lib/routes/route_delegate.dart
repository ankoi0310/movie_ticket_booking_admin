import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class AppRouterDelegate extends RouterDelegate<RoutePath> with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  static final AppRouterDelegate _instance = AppRouterDelegate._();

  bool? isLoggedIn = true;
  String? pathName;
  bool isError = false;

  factory AppRouterDelegate({bool? isLoggedIn}) {
    _instance.isLoggedIn = isLoggedIn;
    return _instance;
  }

  AppRouterDelegate._();

  TransitionDelegate transitionDelegate = CustomTransitionDelegate();

  late List<Page> _stack = [];

  @override
  GlobalKey<NavigatorState> get navigatorKey => CustomNavigationKey.navigatorKey;

  @override
  RoutePath get currentConfiguration {
    if (isError) return RoutePath.unkown();

    if (pathName == null) return RoutePath.home('dashboard');

    return RoutePath.otherPage(pathName);
  }

  List<Page> get _appStack => [
        MaterialPage(
          key: const ValueKey('dashboard'),
          child: DefaultLayout(
            routeName: pathName ?? RouteData.dashboard.name,
          ),
        )
      ];

  /// Auth route
  List<Page> get _authStack => [
        const MaterialPage(
          key: ValueKey('login'),
          child: LoginScreen(),
        ),
      ];

  /// UnKnown Stack
  List<Page> get _unknownStack => [
        const MaterialPage(
          key: ValueKey('unknown'),
          child: UnknownScreen(),
        )
      ];

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == true) {
      _stack = _appStack;
    } else if (isLoggedIn == false) {
      _stack = _authStack;
    } else {
      _stack = _unknownStack;
    }

    return Navigator(
      key: navigatorKey,
      transitionDelegate: transitionDelegate,
      pages: _stack,
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        pathName = null;

        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RoutePath configuration) async {
    if (configuration.isUnknown) {
      pathName = null;
      isError = true;
      return;
    }

    if (configuration.isOtherPage) {
      if (configuration.pathName != null) {
        pathName = configuration.pathName;
        isError = false;
        return;
      } else {
        isError = true;
        return;
      }
    } else {
      pathName = null;
    }
  }

  void setPathName(String path, {bool loggedIn = true}) {
    pathName = path;
    isLoggedIn = loggedIn;
    setNewRoutePath(RoutePath.otherPage(pathName));
    notifyListeners();
  }
}
