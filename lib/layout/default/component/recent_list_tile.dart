import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/style/colors.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/style/style.dart';

class RecentListTile extends StatelessWidget {
  final String label;
  final int amount;
  final int price;

  const RecentListTile({
    Key? key,
    required this.label,
    required this.amount,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 0, right: 20),
      visualDensity: VisualDensity.standard,
      title: Container(
        width: 50,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryText(
              text: label,
              size: 15,
              fontWeight: FontWeight.w500,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const PrimaryText(
                  text: 'Số lượng:',
                  size: 14,
                  fontWeight: FontWeight.w400,
                ),
                PrimaryText(
                  text: '$amount vé',
                  size: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondary,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const PrimaryText(
                  text: 'Thành tiền:',
                  size: 14,
                  fontWeight: FontWeight.w500,
                ),
                PrimaryText(
                  text: NumberFormat.currency(locale: 'vi', symbol: 'VNĐ').format(price),
                  size: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.redAccent,
                ),
              ],
            ),
          ],
        ),
      ),
      enabled: false,
    );
  }
}
