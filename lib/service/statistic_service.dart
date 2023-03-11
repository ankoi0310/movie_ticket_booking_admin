import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/statistic_provider.dart';
import 'package:provider/provider.dart';

class StatisticService {
  late StatisticProvider _statisticProvider;

  StatisticService(BuildContext context) {
    _statisticProvider = Provider.of<StatisticProvider>(context, listen: false);
  }

  Future<void> getStatistic() async {}
}
