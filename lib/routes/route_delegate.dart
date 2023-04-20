import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/layout/full_width/full_width_layout.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/service/authentication_service.dart';

class AppRouterDelegate extends RouterDelegate<RoutePath> with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  static final AppRouterDelegate _instance = AppRouterDelegate._();

  bool? isLoggedIn;
  String? pathName;
  bool isError = false;

  factory AppRouterDelegate({bool? isLoggedIn}) {
    _instance.isLoggedIn = isLoggedIn;
    return _instance;
  }

  AppRouterDelegate._();

  static AppRouterDelegate get instance => _instance;

  TransitionDelegate transitionDelegate = CustomTransitionDelegate();

  final AuthenticationService _authentacationService = AuthenticationService.instance;
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
        MaterialPage(
          key: const ValueKey('auth'),
          child: FullWidthLayout(
            routeName: RouteData.login.name,
          ),
        ),
      ];

  /// UnKnown Stack
  List<Page> get _notFoundStack => [
        const MaterialPage(
          key: ValueKey('notFound'),
          child: NotFoundScreen(),
        )
      ];

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == true) {
      _stack = _appStack;
    } else if (isLoggedIn == false) {
      _stack = _authStack;
    } else {
      _stack = _notFoundStack;
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
    bool isLoggedIn = await _authentacationService.isLoggedIn();
    pathName = configuration.pathName;

    if (configuration.isOtherPage) {
      if (configuration.pathName != null) {
        if (isLoggedIn == true) {
          /// If logged in
          if (configuration.pathName == RouteData.login.name) {
            pathName = RouteData.dashboard.name;
            isError = false;
          } else {
            pathName = configuration.pathName != RouteData.login.name ? configuration.pathName : RouteData.dashboard.name;
            isError = false;
          }
        } else {
          pathName = RouteData.login.name;

          isError = false;
        }
      } else {
        pathName = configuration.pathName;
        isError = false;
      }
    } else {
      pathName = "/";
    }
    notifyListeners();
  }

  void setPathName(String path, {bool loggedIn = true}) {
    pathName = path;
    isLoggedIn = loggedIn;
    setNewRoutePath(RoutePath.otherPage(pathName));
    notifyListeners();
  }
}
