import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

enum RouteData {
  login,
  notFound,
  dashboard,
  user,
  movie,
  genre,
  branch,
  showtime,
  ticket,
  promotion,
  advertisement,
  statistic,
}

class RouteHandler {
  static final RouteHandler _instance = RouteHandler._();

  factory RouteHandler() => _instance;

  RouteHandler._();

  /// Return [WidgetToRender, PathName]
  /// [WidgetToRender] - Render specific widget
  /// [PathName] - Redirect to [PathName] if invalid path is entered
  Widget getRouteWidget(String? routeName) {
    RouteData routeData;

    if (routeName != null) {
      final uri = Uri.parse(routeName);

      if (uri.pathSegments.isNotEmpty) {
        final pathName = uri.pathSegments.elementAt(0).toString();
        routeData = RouteData.values.firstWhere((element) => element.name == pathName, orElse: () => RouteData.notFound);

        if (routeData != RouteData.notFound) {
          switch (routeData) {
            case RouteData.login:
              return const LoginScreen();
            case RouteData.notFound:
              return const NotFoundScreen();
            case RouteData.dashboard:
              return const DashboardScreen();
            case RouteData.user:
              return const UserScreen();
            case RouteData.movie:
              return const MovieScreen();
            case RouteData.genre:
              return const GenreScreen();
            case RouteData.branch:
              return const BranchScreen();
            case RouteData.showtime:
              return const ShowtimeScreen();
            case RouteData.ticket:
              return const TicketScreen();
            case RouteData.promotion:
              return const PromotionScreen();
            case RouteData.advertisement:
              return const AdvertisementScreen();
            case RouteData.statistic:
              return const StatisticScreen();
            default:
              return const DashboardScreen();
          }
        } else {
          return const NotFoundScreen();
        }
      } else {
        return const DashboardScreen();
      }
    } else {
      return const NotFoundScreen();
    }
  }

  /// Return [RouteTitle]
  /// [RouteTitle] - Return specific title for each route
  String getRouteTitle(String? routeName) {
    RouteData routeData;

    if (routeName != null) {
      final uri = Uri.parse(routeName);

      if (uri.pathSegments.isNotEmpty) {
        final pathName = uri.pathSegments.elementAt(0).toString();
        routeData = RouteData.values.firstWhere((element) => element.name == pathName, orElse: () => RouteData.notFound);

        if (routeData != RouteData.notFound) {
          switch (routeData) {
            case RouteData.login:
              return 'Login';
            case RouteData.notFound:
              return 'Not Found';
            case RouteData.dashboard:
              return 'Dashboard';
            case RouteData.user:
              return 'User';
            case RouteData.movie:
              return 'Movie';
            case RouteData.genre:
              return 'Genre';
            case RouteData.branch:
              return 'Branch';
            case RouteData.showtime:
              return 'Showtime';
            case RouteData.ticket:
              return 'Ticket';
            case RouteData.promotion:
              return 'Promotion';
            case RouteData.advertisement:
              return 'Advertisement';
            case RouteData.statistic:
              return 'Statistic';
            default:
              return 'Dashboard';
          }
        } else {
          return 'Not Found';
        }
      } else {
        return 'Dashboard';
      }
    } else {
      return 'Not Found';
    }
  }
}
