import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/style/colors.dart';

class BranchScreen extends StatefulWidget {
  static const routeName = '/branch';
  const BranchScreen({Key? key}) : super(key: key);

  @override
  State<BranchScreen> createState() => _BranchScreenState();
}

class _BranchScreenState extends State<BranchScreen> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Branch Screen',
      style: TextStyle(
        color: AppColors.black,
        fontSize: SizeConfig.blockSizeVertical * 2,
      ),
    );
  }
}
