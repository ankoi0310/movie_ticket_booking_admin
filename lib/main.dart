import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/app.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/combo_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/component/loading_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/invoice_provider.dart';

import 'core.dart';

void main() async {
  initializeDateFormatting().then((_) => runZonedGuarded(() async {
        WidgetsFlutterBinding.ensureInitialized();

        await Firebase.initializeApp(
            options: const FirebaseOptions(
          apiKey: "AIzaSyARE8AOvdVKdvaYECInb1wvMoVnM1Qf_7M",
          authDomain: "movie-ticket-booking-383806.firebaseapp.com",
          projectId: "movie-ticket-booking-383806",
          storageBucket: "movie-ticket-booking-383806.appspot.com",
          messagingSenderId: "915458067606",
          appId: "1:915458067606:web:8e7fc8b87c32abcbaf06b7",
          measurementId: "G-NJNWB7JVLV",
        ));
        usePathUrlStrategy();

        bool isUserLoggedIn = await AuthenticationService.instance.isLoggedIn();

        runApp(
          MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => UserProvider()),
              ChangeNotifierProvider(create: (_) => MovieProvider()),
              ChangeNotifierProvider(create: (_) => GenreProvider()),
              ChangeNotifierProvider(create: (_) => BranchProvider()),
              ChangeNotifierProvider(create: (_) => RoomProvider()),
              ChangeNotifierProvider(create: (_) => ShowtimeProvider()),
              ChangeNotifierProvider(create: (_) => InvoiceProvider()),
              ChangeNotifierProvider(create: (_) => PromotionProvider()),
              ChangeNotifierProvider(create: (_) => AdvertisementProvider()),
              ChangeNotifierProvider(create: (_) => StatisticProvider()),
              ChangeNotifierProvider(create: (_) => LoadingProvider()),
              ChangeNotifierProvider(create: (_) => ProductProvider()),
              ChangeNotifierProvider(create: (_) => ComboProvider()),
              ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
            ],
            child: App(isLoggedIn: isUserLoggedIn),
          ),
        );
      }, (error, stackTrace) {
        print('Error: $error');
        // BadRequestException badRequestException = error as BadRequestException;
        // print('Error: ${badRequestException.message}');
      }));
}
