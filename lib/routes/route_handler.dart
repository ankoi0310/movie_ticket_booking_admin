import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/invoice/invoice_screen.dart';

class RouteHandler {
  static final RouteHandler _instance = RouteHandler._();

  factory RouteHandler() => _instance;

  final AuthenticationService _authenticationService = AuthenticationService.instance;

  RouteHandler._();

  /// Return [WidgetToRender, PathName]
  /// [WidgetToRender] - Render specific widget
  /// [PathName] - Redirect to [PathName] if invalid path is entered
  Future<Widget> getRouteWidget(String? routeName) async {
    bool isLoggedIn = await _authenticationService.isLoggedIn();
    if (routeName == null) {
      if (isLoggedIn) {
        return const DashboardScreen();
      } else {
        return const LoginScreen();
      }
    } else {
      final uri = Uri.parse(routeName);

      if (uri.pathSegments.isEmpty) {
        if (isLoggedIn) {
          return const DashboardScreen();
        } else {
          return const LoginScreen();
        }
      }

      if (uri.pathSegments.length == 1) {
        final pathName = uri.pathSegments.elementAt(0).toString();

        if (isLoggedIn) {
          RouteData.values.addAll(AuthRouteData.values);
        } else {
          RouteData.values.addAll(PublicRouteData.values);
        }

        final routeData = RouteData.values.firstWhere((element) => element.name == pathName, orElse: () => RouteData.notFound);
        if (routeData != RouteData.notFound) {
          if (isLoggedIn) {
            switch (routeData) {
              case PublicRouteData.login:
                return const LoginScreen();
              case AuthRouteData.dashboard:
                return const DashboardScreen();
              case AuthRouteData.user:
                return const UserScreen();
              case AuthRouteData.movie:
                return const MovieScreen();
              case AuthRouteData.genre:
                return const GenreScreen();
              case AuthRouteData.branch:
                return const BranchScreen();
              case AuthRouteData.room:
                return const RoomScreen();
              case AuthRouteData.showtime:
                return const ShowtimeScreen();
              case AuthRouteData.invoice:
                return const InvoiceScreen();
              case AuthRouteData.promotion:
                return const PromotionScreen();
              case AuthRouteData.combo:
                return const ComboScreen();
              case AuthRouteData.advertisement:
                return const AdvertisementScreen();
              case AuthRouteData.product:
                return const ProductScreen();
              case AuthRouteData.statistic:
                return const StatisticScreen();
              default:
                return const DashboardScreen();
            }
          } else {
            switch (routeData) {
              case PublicRouteData.login:
                return const LoginScreen();
              default:
                return const LoginScreen();
            }
          }
        }
        return const NotFoundScreen();
      }

      return const NotFoundScreen();
    }
  }

  /// Return [RouteTitle]
  /// [RouteTitle] - Return specific title for each route
  String getRouteTitle(String? routeName) {
    if (routeName != null) {
      final uri = Uri.parse(routeName);

      if (uri.pathSegments.isNotEmpty) {
        final pathName = uri.pathSegments.elementAt(0).toString();
        final RouteData routeData = RouteData.values.firstWhere((element) => element.name == pathName, orElse: () => RouteData.notFound);

        if (routeData != RouteData.notFound) {
          switch (routeData) {
            case AuthRouteData.dashboard:
              return 'Dashboard';
            case AuthRouteData.user:
              return 'Người dùng';
            case AuthRouteData.movie:
              return 'Phim';
            case AuthRouteData.genre:
              return 'Thể loại';
            case AuthRouteData.branch:
              return 'Chi nhánh';
            case AuthRouteData.room:
              return 'Phòng chiếu';
            case AuthRouteData.showtime:
              return 'Lịch chiếu';
            case AuthRouteData.invoice:
              return 'Hóa đơn';
            case AuthRouteData.promotion:
              return 'Khuyến mãi';
            case AuthRouteData.product:
              return 'Sản phẩm';
            case AuthRouteData.combo:
              return 'Combo sản phẩm';
            case AuthRouteData.advertisement:
              return 'Quảng cáo';
            case AuthRouteData.statistic:
              return 'Thống kê';
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
