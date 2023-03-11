import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/dashboard/dashboard_screen.dart';

class ChangeWidgetProvider extends ChangeNotifier {
  String currentTitle = 'Dashboard';
  Widget currentWidget = const DashboardScreen();

  void changeActiveWidget({required String title, required Widget widget}) {
    if (widget == currentWidget) {
      return;
    }

    currentTitle = title;
    currentWidget = widget;
    notifyListeners();
  }
}
