import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/advertisement/advertisement_screen.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/branch/branch_screen.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/dashboard/dashboard_screen.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/genre/genre_screen.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/movie/movie_screen.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/promotion/promotion_screen.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/showtime/showtime_screen.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/statistic/statistic_screen.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/ticket/ticket_screen.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/user/user_screen.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    RedirectRoute(path: '/', redirectTo: '/dashboard'),
    AutoRoute(page: DashboardScreen, path: '/dashboard', name: 'dashboard', initial: true),
    AutoRoute(page: UserScreen, path: '/user', name: 'user'),
    AutoRoute(page: MovieScreen, path: '/movie', name: 'movie'),
    AutoRoute(page: GenreScreen, path: '/genre', name: 'genre'),
    AutoRoute(page: BranchScreen, path: '/branch', name: 'branch'),
    AutoRoute(page: ShowtimeScreen, path: '/showtime', name: 'showtime'),
    AutoRoute(page: TicketScreen, path: '/ticket', name: 'ticket'),
    AutoRoute(page: PromotionScreen, path: '/promotion', name: 'promotion'),
    AutoRoute(page: AdvertisementScreen, path: '/advertisement', name: 'advertisement'),
    AutoRoute(page: StatisticScreen, path: '/statistic', name: 'statistic'),
  ],
)
class AppRouter extends _$AppRouter {}
