import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class AdvertisementScreen extends StatefulWidget {
  const AdvertisementScreen({Key? key}) : super(key: key);

  @override
  State<AdvertisementScreen> createState() => _AdvertisementScreenState();
}

class _AdvertisementScreenState extends State<AdvertisementScreen> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Advertisement Screen',
      style: TextStyle(
        color: AppColors.black,
        fontSize: SizeConfig.blockSizeVertical * 2,
      ),
    );
  }
}
