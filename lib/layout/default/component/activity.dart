import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/constant/data.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

import 'movie_ticket_status.dart';
import 'recent_list_tile.dart';

class Activity extends StatefulWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: SizeConfig.blockSizeVertical * 5),
        // Container(
        //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), boxShadow: [
        //     BoxShadow(
        //       color: Colors.grey[400]!,
        //       blurRadius: 15.0,
        //       offset: const Offset(
        //         10.0,
        //         15.0,
        //       ),
        //     )
        //   ]),
        //   child: Image.asset('assets/images/card.png'),
        // ),
        // SizedBox(height: SizeConfig.blockSizeVertical * 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PrimaryText(text: 'Lịch sử mua vé', size: 18, fontWeight: FontWeight.w800),
            PrimaryText(
              text: DateFormat.yMMMMEEEEd('vi').format(DateTime.now()),
              size: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.secondary,
            ),
          ],
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 2),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 40,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            itemCount: ticketPurchaseHistory.length,
            itemBuilder: (context, index) => RecentListTile(
              label: ticketPurchaseHistory[index]["label"] as String,
              amount: ticketPurchaseHistory[index]["amount"] as int,
              price: ticketPurchaseHistory[index]["price"] as int,
            ),
          ),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PrimaryText(text: 'Thông tin suất chiếu', size: 18, fontWeight: FontWeight.w800),
            PrimaryText(
              text: DateFormat.yMMMMEEEEd('vi').format(DateTime.now()),
              size: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.secondary,
            ),
          ],
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 2),
        Column(
          children: List.generate(
            upcomingPayments.length,
            (index) => MovieTicketStatus(
              icon: upcomingPayments[index]["icon"]!,
              label: upcomingPayments[index]["label"]!,
              amount: upcomingPayments[index]["amount"]!,
            ),
          ),
        ),
      ],
    );
  }

  void scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }
}
