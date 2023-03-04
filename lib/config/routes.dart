import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/layout/default_layout.dart';
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

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  DashboardScreen.routeName: (BuildContext context) => const DashboardScreen(),
  UserScreen.routeName: (BuildContext context) => const DefaultLayout(title: 'User', widget: UserScreen()),
  MovieScreen.routeName: (BuildContext context) => const DefaultLayout(title: 'Movie', widget: MovieScreen()),
  GenreScreen.routeName: (BuildContext context) => const DefaultLayout(title: 'Genre', widget: GenreScreen()),
  BranchScreen.routeName: (BuildContext context) => const DefaultLayout(title: 'Branch', widget: BranchScreen()),
  ShowtimeScreen.routeName: (BuildContext context) => const DefaultLayout(title: 'Showtime', widget: ShowtimeScreen()),
  OrderScreen.routeName: (BuildContext context) => const DefaultLayout(title: 'Order', widget: OrderScreen()),
  PromotionScreen.routeName: (BuildContext context) => const DefaultLayout(title: 'Promotion', widget: PromotionScreen()),
  AdvertisementScreen.routeName: (BuildContext context) => const DefaultLayout(title: 'Advertisement', widget: AdvertisementScreen()),
  StatisticScreen.routeName: (BuildContext context) => const DefaultLayout(title: 'Statistic', widget: StatisticScreen()),
};
