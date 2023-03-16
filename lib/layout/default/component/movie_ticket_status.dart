import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/style/colors.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/style/style.dart';

class MovieTicketStatus extends StatelessWidget {
  final String icon;
  final String label;
  final String amount;

  const MovieTicketStatus({Key? key, required this.icon, required this.label, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 0, right: 20),
      visualDensity: VisualDensity.standard,
      leading: Container(
        width: 50,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SvgPicture.asset(icon, width: 20),
      ),
      title: PrimaryText(text: label, size: 14, fontWeight: FontWeight.w500),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const PrimaryText(
            text: 'Successfully',
            size: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.secondary,
          ),
          PrimaryText(text: amount, size: 16, fontWeight: FontWeight.w600),
        ],
      ),
      onTap: () {
        print('tap');
      },
      selected: true,
    );
  }
}
