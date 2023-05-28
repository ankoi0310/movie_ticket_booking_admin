import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/component/bar_chart.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/layout/default/component/activity.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/dashboard/component/general_statistic.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final StatisticProvider _statisticProvider =
      Provider.of<StatisticProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const GeneralStatistic(),
        SizedBox(height: SizeConfig.blockSizeVertical * 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PrimaryText(
                  text: 'Lợi nhuận',
                  size: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondary,
                ),
                PrimaryText(
                    text: NumberFormat.currency(locale: 'vi', symbol: 'VNĐ')
                        .format(15000000),
                    size: 30,
                    fontWeight: FontWeight.w800),
              ],
            ),
            const PrimaryText(
              text: '30 ngày qua',
              size: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.secondary,
            ),
          ],
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 3),
        FutureBuilder(
            future: _statisticProvider.getStatistic(StatisticFilter(
              value: StatisticValue.revenue,
              timeline: StatisticTimeline.day,
            )),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                HttpResponse response = snapshot.data as HttpResponse;
                return SizedBox(
                  height: 180,
                  child: BarChartCopmponent(data: response.data),
                );
              }

              return const Center(child: CircularProgressIndicator());
            }),
        if (!Responsive.isDesktop(context)) ...[
          SizedBox(height: SizeConfig.blockSizeVertical * 5),
          const Activity(),
        ],
      ],
    );
  }
}
