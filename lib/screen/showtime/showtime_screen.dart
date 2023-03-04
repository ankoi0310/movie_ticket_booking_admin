import 'package:flutter/material.dart';

class ShowtimeScreen extends StatefulWidget {
  static const routeName = '/showtime';
  const ShowtimeScreen({Key? key}) : super(key: key);

  @override
  State<ShowtimeScreen> createState() => _ShowtimeScreenState();
}

class _ShowtimeScreenState extends State<ShowtimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Showtime Screen',
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    );
  }
}
