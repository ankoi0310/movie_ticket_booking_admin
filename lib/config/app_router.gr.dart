// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    Dashboard.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const DashboardScreen(),
      );
    },
    User.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const UserScreen(),
      );
    },
    Movie.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const MovieScreen(),
      );
    },
    Genre.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const GenreScreen(),
      );
    },
    Branch.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const BranchScreen(),
      );
    },
    Showtime.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const ShowtimeScreen(),
      );
    },
    Order.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const TicketScreen(),
      );
    },
    Promotion.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const PromotionScreen(),
      );
    },
    Advertisement.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const AdvertisementScreen(),
      );
    },
    Statistic.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const StatisticScreen(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/dashboard',
          fullMatch: true,
        ),
        RouteConfig(
          Dashboard.name,
          path: '/dashboard',
        ),
        RouteConfig(
          User.name,
          path: '/user',
        ),
        RouteConfig(
          Movie.name,
          path: '/movie',
        ),
        RouteConfig(
          Genre.name,
          path: '/genre',
        ),
        RouteConfig(
          Branch.name,
          path: '/branch',
        ),
        RouteConfig(
          Showtime.name,
          path: '/showtime',
        ),
        RouteConfig(
          Order.name,
          path: '/order',
        ),
        RouteConfig(
          Promotion.name,
          path: '/promotion',
        ),
        RouteConfig(
          Advertisement.name,
          path: '/advertisement',
        ),
        RouteConfig(
          Statistic.name,
          path: '/statistic',
        ),
      ];
}

/// generated route for
/// [DashboardScreen]
class Dashboard extends PageRouteInfo<void> {
  const Dashboard()
      : super(
          Dashboard.name,
          path: '/dashboard',
        );

  static const String name = 'Dashboard';
}

/// generated route for
/// [UserScreen]
class User extends PageRouteInfo<void> {
  const User()
      : super(
          User.name,
          path: '/user',
        );

  static const String name = 'User';
}

/// generated route for
/// [MovieScreen]
class Movie extends PageRouteInfo<void> {
  const Movie()
      : super(
          Movie.name,
          path: '/movie',
        );

  static const String name = 'Movie';
}

/// generated route for
/// [GenreScreen]
class Genre extends PageRouteInfo<void> {
  const Genre()
      : super(
          Genre.name,
          path: '/genre',
        );

  static const String name = 'Genre';
}

/// generated route for
/// [BranchScreen]
class Branch extends PageRouteInfo<void> {
  const Branch()
      : super(
          Branch.name,
          path: '/branch',
        );

  static const String name = 'Branch';
}

/// generated route for
/// [ShowtimeScreen]
class Showtime extends PageRouteInfo<void> {
  const Showtime()
      : super(
          Showtime.name,
          path: '/showtime',
        );

  static const String name = 'Showtime';
}

/// generated route for
/// [TicketScreen]
class Order extends PageRouteInfo<void> {
  const Order()
      : super(
          Order.name,
          path: '/order',
        );

  static const String name = 'Order';
}

/// generated route for
/// [PromotionScreen]
class Promotion extends PageRouteInfo<void> {
  const Promotion()
      : super(
          Promotion.name,
          path: '/promotion',
        );

  static const String name = 'Promotion';
}

/// generated route for
/// [AdvertisementScreen]
class Advertisement extends PageRouteInfo<void> {
  const Advertisement()
      : super(
          Advertisement.name,
          path: '/advertisement',
        );

  static const String name = 'Advertisement';
}

/// generated route for
/// [StatisticScreen]
class Statistic extends PageRouteInfo<void> {
  const Statistic()
      : super(
          Statistic.name,
          path: '/statistic',
        );

  static const String name = 'Statistic';
}
