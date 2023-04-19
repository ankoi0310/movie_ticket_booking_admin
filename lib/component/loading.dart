import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/config/size_config.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      color: Colors.black.withOpacity(0.5),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
