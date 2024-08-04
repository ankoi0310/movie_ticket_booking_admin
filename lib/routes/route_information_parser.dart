import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class RoutesInformationParser extends RouteInformationParser<RoutePath> {
  final AuthenticationService _authenticationService = AuthenticationService.instance;

  @override
  Future<RoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    bool isLogin = await _authenticationService.isLoggedIn();
    if (uri.pathSegments.isEmpty) {
      if (isLogin) {
        return RoutePath.dashboard('/dashboard');
      } else {
        return RoutePath.login('/login');
      }
    }

    if (uri.pathSegments.isNotEmpty) {
      return RoutePath.otherPage(routeInformation.location.replaceFirst('/', ''));
    }

    if (uri.pathSegments.length == 1) {
      final pathName = uri.pathSegments.elementAt(0).toString();
      return RoutePath.otherPage(pathName);
    }
    return RoutePath.otherPage(uri.pathSegments.toString());
  }

  @override
  RouteInformation restoreRouteInformation(RoutePath configuration) {
    if (configuration.isNotfound) return const RouteInformation(location: '/error');
    if (configuration.isLoginPage) return const RouteInformation(location: '/login');
    if (configuration.isDashboardPage) return const RouteInformation(location: '/dashboard');
    if (configuration.isOtherPage) return RouteInformation(location: '/${configuration.pathName}');

    return RouteInformation(location: null);
  }
}
