import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/component/info_card.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class GeneralStatistic extends StatelessWidget {
  const GeneralStatistic({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
