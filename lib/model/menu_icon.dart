import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/advertisement/advertisement_screen.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/branch/branch_screen.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/dashboard/dashboard_screen.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/genre/genre_screen.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/movie/movie_screen.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/order/order_screen.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/promotion/promotion_screen.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/showtime/showtime_screen.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/statistic/statistic_screen.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/user/user_screen.dart';

class MenuItem {
  final String icon;
  final String title;
  final String route;
  final Widget screen;

  MenuItem({
    required this.icon,
    required this.title,
    required this.route,
    required this.screen,
  });
}

final List<MenuItem> sideBarMenuItems = [
  MenuItem(
    icon: 'assets/icons/dashboard.svg',
    title: 'Trang chủ',
    route: DashboardScreen.routeName,
    screen: const DashboardScreen(),
  ),
  MenuItem(
    icon: 'assets/icons/user.svg',
    title: 'Người dùng',
    route: UserScreen.routeName,
    screen: const UserScreen(),
  ),
  MenuItem(
    icon: 'assets/icons/movie.svg',
    title: 'Phim',
    route: MovieScreen.routeName,
    screen: const MovieScreen(),
  ),
  MenuItem(
    icon: 'assets/icons/genre.svg',
    title: 'Thể loại',
    route: GenreScreen.routeName,
    screen: const GenreScreen(),
  ),
  MenuItem(
    icon: 'assets/icons/branch.svg',
    title: 'Chi nhánh',
    route: BranchScreen.routeName,
    screen: const BranchScreen(),
  ),
  MenuItem(
    icon: 'assets/icons/showtime.svg',
    title: 'Lịch chiếu',
    route: ShowtimeScreen.routeName,
    screen: const ShowtimeScreen(),
  ),
  MenuItem(
    icon: 'assets/icons/clipboard.svg',
    title: 'Đơn hàng',
    route: OrderScreen.routeName,
    screen: const OrderScreen(),
  ),
  MenuItem(
    icon: 'assets/icons/trophy.svg',
    title: 'Khuyến mãi',
    route: PromotionScreen.routeName,
    screen: const PromotionScreen(),
  ),
  MenuItem(
    icon: 'assets/icons/advertisement.svg',
    title: 'Quảng cáo',
    route: AdvertisementScreen.routeName,
    screen: const AdvertisementScreen(),
  ),
  MenuItem(
    icon: 'assets/icons/pie-chart.svg',
    title: 'Thống kê',
    route: StatisticScreen.routeName,
    screen: const StatisticScreen(),
  ),
];
