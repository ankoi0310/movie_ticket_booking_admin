import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/app.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/api_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/authentication_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/service/authentication_service.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/component/loading_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/service/hive_storage_service.dart';

import 'core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyARE8AOvdVKdvaYECInb1wvMoVnM1Qf_7M",
          authDomain: "movie-ticket-booking-383806.firebaseapp.com",
          projectId: "movie-ticket-booking-383806",
          storageBucket: "movie-ticket-booking-383806.appspot.com",
          messagingSenderId: "915458067606",
          appId: "1:915458067606:web:8e7fc8b87c32abcbaf06b7",
          measurementId: "G-NJNWB7JVLV")
  );
  usePathUrlStrategy();
  AuthenticationService.instance.init();
  bool isLoggedIn = await AuthenticationService.instance.isLoggedIn();
  initializeDateFormatting().then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ApiProvider(_)),
          // ChangeNotifierProxyProvider<ApiProvider, AuthenticationProvider>(
          //   create: (_) => AuthenticationProvider(_),
          //   update: (_, apiProvider, authenticationProvider) => authenticationProvider!.._apiProvider = apiProvider,
          // ),
          ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
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
          ChangeNotifierProvider(create: (_) => LoadingProvider()),
        ],
        child: App(isLoggedIn: isLoggedIn),
      ),
    ),
  );
}
