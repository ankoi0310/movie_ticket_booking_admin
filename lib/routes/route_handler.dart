import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/product/product_screen.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/service/hive_storage_service.dart';

enum RouteData {
  login,
  notFound,
  dashboard,
  user,
  movie,
  genre,
  branch,
  room,
  showtime,
  product,
  ticket,
  promotion,
  advertisement,
  combo,
  statistic,
}

class RouteHandler {
  static final RouteHandler _instance = RouteHandler._();

  factory RouteHandler() => _instance;

  RouteHandler._();

  /// Return [WidgetToRender, PathName]
  /// [WidgetToRender] - Render specific widget
  /// [PathName] - Redirect to [PathName] if invalid path is entered
  Future<Widget> getRouteWidget(String? routeName) async {
    RouteData routeData;

    if (routeName != null) {
      final uri = Uri.parse(routeName);

      if (uri.pathSegments.isNotEmpty) {
        final pathName = uri.pathSegments.elementAt(0).toString();
        routeData = RouteData.values.firstWhere((element) => element.name == pathName, orElse: () => RouteData.notFound);

        if (routeData != RouteData.notFound) {
          bool isLoggedIn = await HiveDataStorageService.getUser();
          if (isLoggedIn) {
            switch (routeData) {
              case RouteData.login:
                return const LoginScreen();
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
              case RouteData.room:
                return const RoomScreen();
              case RouteData.showtime:
                return const ShowtimeScreen();
              case RouteData.ticket:
                return const TicketScreen();
              case RouteData.promotion:
                return const PromotionScreen();
              case RouteData.combo:
                return const ComboScreen();
              case RouteData.advertisement:
                return const AdvertisementScreen();
              case RouteData.product:
                return const ProductScreen();
              case RouteData.statistic:
                return const StatisticScreen();
              default:
                return const DashboardScreen();
            }
          } else {
            return const LoginScreen();
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
            case RouteData.dashboard:
              return 'Dashboard';
            case RouteData.user:
              return 'Người dùng';
            case RouteData.movie:
              return 'Phim';
            case RouteData.genre:
              return 'Thể loại';
            case RouteData.branch:
              return 'Chi nhánh';
            case RouteData.room:
              return 'Phòng chiếu';
            case RouteData.showtime:
              return 'Lịch chiếu';
            case RouteData.ticket:
              return 'Vé phim';
            case RouteData.promotion:
              return 'Khuyến mãi';
            case RouteData.product:
              return 'Sản phẩm';
            case RouteData.combo:
              return 'Combo sản phẩm';
            case RouteData.advertisement:
              return 'Quảng cáo';
            case RouteData.statistic:
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
