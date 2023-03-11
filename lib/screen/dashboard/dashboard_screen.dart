import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/component/activity.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/component/bar_chart.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/component/info_card.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/config/responsive.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/service/statistic_service.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/style/colors.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/style/style.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    StatisticService statisticService = StatisticService(context);
    statisticService.getStatistic();
    return Column(
      children: [
        SizedBox(
          width: SizeConfig.screenWidth,
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.spaceBetween,
            children: [
              const InfoCard(
                icon: 'icons/branch.svg',
                label: 'Chi nhánh \nHoạt Động',
                amount: '15',
              ),
              const InfoCard(
                icon: 'icons/credit-card.svg',
                label: 'Phim \nĐang Chiếu',
                amount: '12',
              ),
              const InfoCard(
                icon: 'icons/showtime.svg',
                label: 'Suất Chiếu \nTrong Ngày',
                amount: '32',
              ),
              InfoCard(
                icon: 'icons/salary.svg',
                label: 'Lợi Nhuận \nTrong Ngày',
                amount: NumberFormat.currency(locale: 'vi', symbol: 'VNĐ').format(15000000),
              ),
            ],
          ),
        ),
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
                PrimaryText(text: NumberFormat.currency(locale: 'vi', symbol: 'VNĐ').format(15000000), size: 30, fontWeight: FontWeight.w800),
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
        const SizedBox(height: 180, child: BarChartCopmponent()),
        if (!Responsive.isDesktop(context)) ...[
          SizedBox(height: SizeConfig.blockSizeVertical * 5),
          const Activity(),
        ],
      ],
    );
  }
}
