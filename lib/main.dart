import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/app.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/service/hive_storage_service.dart';

import 'core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  bool isUserLoggedIn = await HiveDataStorageService.getUser();
  initializeDateFormatting().then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => MovieProvider()),
          ChangeNotifierProvider(create: (_) => GenreProvider()),
          ChangeNotifierProvider(create: (_) => BranchProvider()),
          ChangeNotifierProvider(create: (_) => RoomProvider()),
          ChangeNotifierProvider(create: (_) => ShowtimeProvider()),
          ChangeNotifierProvider(create: (_) => TicketProvider()),
          ChangeNotifierProvider(create: (_) => PromotionProvider()),
          ChangeNotifierProvider(create: (_) => AdvertisementProvider()),
          ChangeNotifierProvider(create: (_) => StatisticProvider()),
        ],
        child: App(isLoggedIn: isUserLoggedIn),
      ),
    ),
  );
}
