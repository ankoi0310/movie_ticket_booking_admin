import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/component/bar_chart.dart';

class StatisticScreen extends StatefulWidget {
  static const String routeName = '/statistic';
  const StatisticScreen({Key? key}) : super(key: key);

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DropdownButton(
          items: const [
            DropdownMenuItem(
              child: Text('1'),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text('2'),
              value: 2,
            ),
            DropdownMenuItem(
              child: Text('3'),
              value: 3,
            ),
          ],
          onChanged: (value) {},
        ),
        SizedBox(
          height: 300,
          child: BarChartCopmponent(),
        ),
      ],
    );
  }
}
