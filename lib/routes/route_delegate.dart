import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/layout/full_width/full_width_layout.dart';

class AppRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  static final AppRouterDelegate _instance = AppRouterDelegate._();

  bool? isLoggedIn;
  String? pathName = "";
  bool isError = false;

  final AuthenticationService _authenticationService =
      AuthenticationService.instance;

  factory AppRouterDelegate({bool? isLoggedIn}) {
    _instance.isLoggedIn = isLoggedIn;

    RouteData.values.addAll(PublicRouteData.values);
    if (isLoggedIn == true) {
      RouteData.values.addAll(AuthRouteData.values);
    }
    return _instance;
  }

  AppRouterDelegate._();

  static AppRouterDelegate get instance => _instance;

  TransitionDelegate transitionDelegate = CustomTransitionDelegate();

  late List<Page> _stack = [];

  @override
  GlobalKey<NavigatorState> get navigatorKey =>
      CustomNavigationKey.navigatorKey;

  @override
  RoutePath get currentConfiguration {
    if (isError) return RoutePath.notFound(pathName);

    if (pathName == null) {
      if (isLoggedIn == true) {
        return RoutePath.dashboard(AuthRouteData.dashboard.name);
      } else {
        return RoutePath.login(PublicRouteData.login.name);
      }
    }
    return RoutePath.otherPage(pathName!);
  }

  List<Page> get _appStack => [
        MaterialPage(
          key: const ValueKey('auth'),
          child: FullWidthLayout(routeName: pathName!),
        )
      ];

  /// Auth route
  List<Page> get _authStack => [
        MaterialPage(
          key: const ValueKey('auth'),
          child: isLoggedIn == true
              ? DefaultLayout(routeName: pathName!)
              : FullWidthLayout(routeName: pathName!),
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
    _stack = AuthRouteData.values.map((e) => e.name).contains(pathName) &&
            isLoggedIn == true
        ? _authStack
        : _appStack;
    _stack = isError ? _notFoundStack : _stack;

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
    isLoggedIn = await _authenticationService.isLoggedIn();
    pathName = configuration.pathName;

    RouteData.values.addAll(PublicRouteData.values);
    if (isLoggedIn == true) {
      RouteData.values.addAll(AuthRouteData.values);
    }

    if (configuration.isNotfound) {
      pathName = configuration.pathName;
      isError = true;
    } else if (configuration.isOtherPage) {
      if (configuration.pathName != null) {
        if (isLoggedIn == true &&
            configuration.pathName == PublicRouteData.login.name) {
          pathName = AuthRouteData.dashboard.name;
        }
      } else {
        pathName = configuration.pathName;
      }
      isError = false;
    } else {
      if (isLoggedIn == true) {
        pathName = AuthRouteData.dashboard.name;
      } else {
        pathName = PublicRouteData.login.name;
      }
      isError = false;
    }
    notifyListeners();
  }

  Future<void> setPathName(String path) async {
    pathName = path;
    isLoggedIn = await _authenticationService.isLoggedIn();

    if (pathName == null) {
      if (isLoggedIn == true) {
        await setNewRoutePath(
            RoutePath.dashboard(AuthRouteData.dashboard.name));
      } else {
        await setNewRoutePath(RoutePath.login(PublicRouteData.login.name));
      }
    }
    if (!RouteData.values.map((e) => e.name).contains(pathName)) {
      isError = true;
      await setNewRoutePath(RoutePath.notFound(pathName!));
    } else {
      await setNewRoutePath(RoutePath.otherPage(pathName!));
    }
    notifyListeners();
  }
}

class RouteData {
  final String name;

  static const notFound = RouteData._('notFound');
  static const internalServerError = RouteData._('internal-server-error');

  const RouteData._(this.name);

  static Set<RouteData> values = {
    notFound,
    internalServerError,
  };
}

class AuthRouteData extends RouteData {
  static const dashboard = AuthRouteData._('dashboard');
  static const user = AuthRouteData._('user');
  static const movie = AuthRouteData._('movie');
  static const genre = AuthRouteData._('genre');
  static const branch = AuthRouteData._('branch');
  static const room = AuthRouteData._('room');
  static const showtime = AuthRouteData._('showtime');
  static const product = AuthRouteData._('product');
  static const combo = AuthRouteData._('combo');
  static const invoice = AuthRouteData._('invoice');
  static const statistic = AuthRouteData._('statistic');
  static const advertisement = AuthRouteData._('advertisement');
  static const promotion = AuthRouteData._('promotion');

  const AuthRouteData._(String name) : super._(name);

  static Set<AuthRouteData> values = {
    dashboard,
    user,
    movie,
    genre,
    branch,
    room,
    showtime,
    product,
    combo,
    invoice,
    statistic,
    advertisement,
    promotion,
  };
}

class PublicRouteData extends RouteData {
  static const login = PublicRouteData._('login');

  const PublicRouteData._(String name) : super._(name);

  static Set<PublicRouteData> values = {
    login,
  };
}
