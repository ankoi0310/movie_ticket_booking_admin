import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/style/colors.dart';

class GenreScreen extends StatefulWidget {
  static const routeName = '/genre';
  const GenreScreen({Key? key}) : super(key: key);

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Genre Screen',
      style: TextStyle(
        color: AppColors.black,
        fontSize: SizeConfig.blockSizeVertical * 2,
      ),
    );
  }
}
