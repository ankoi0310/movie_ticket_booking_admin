import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/routes/route_path.dart';

class RoutesInformationParser extends RouteInformationParser<RoutePath> {
  @override
  Future<RoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);

    if (uri.pathSegments.isEmpty) {
      return RoutePath.home('/');
    }

    if (uri.pathSegments.isNotEmpty) {
      return RoutePath.otherPage(routeInformation.location!.replaceFirst('/', ''));
    }

    if (uri.pathSegments.length == 1) {
      final pathName = uri.pathSegments.elementAt(0).toString();
      return RoutePath.otherPage(pathName);
    } else if (uri.pathSegments.length == 2) {
      final complexPath = '${uri.pathSegments.elementAt(0)}/${uri.pathSegments.elementAt(1)}';
      return RoutePath.otherPage(complexPath);
    }

    return RoutePath.unkown();
  }

  @override
  RouteInformation restoreRouteInformation(RoutePath configuration) {
    if (configuration.isUnknown) return const RouteInformation(location: '/error');
    if (configuration.isHomePage) return const RouteInformation(location: '/');
    if (configuration.isOtherPage) return RouteInformation(location: '/${configuration.pathName}');

    return const RouteInformation(location: null);
  }
}
