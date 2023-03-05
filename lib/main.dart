import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/config/routes.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/dropdown_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/dashboard/dashboard_screen.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/style/colors.dart';
import 'package:provider/provider.dart';

void main() {
  initializeDateFormatting().then(
    (_) => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DropdownProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Starlinex - Quản lý',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: AppColors.primaryBg,
        ),
        routes: routes,
        initialRoute: DashboardScreen.routeName,
      ),
    );
  }
}
