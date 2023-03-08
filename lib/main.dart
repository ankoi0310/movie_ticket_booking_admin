import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/config/app_router.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/advertisement_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/branch_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/genre_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/movie_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/promotion_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/showtime_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/statistic_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/ticket_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/user_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/style/colors.dart';
import 'package:provider/provider.dart';

void main() {
  initializeDateFormatting().then(
    (_) => runApp(const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => MovieProvider()),
        ChangeNotifierProvider(create: (_) => GenreProvider()),
        ChangeNotifierProvider(create: (_) => BranchProvider()),
        ChangeNotifierProvider(create: (_) => ShowtimeProvider()),
        ChangeNotifierProvider(create: (_) => TicketProvider()),
        ChangeNotifierProvider(create: (_) => PromotionProvider()),
        ChangeNotifierProvider(create: (_) => AdvertisementProvider()),
        ChangeNotifierProvider(create: (_) => StatisticProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Starlinex - Quản lý',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: AppColors.primaryBg,
        ),
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
      ),
    );
  }
}
