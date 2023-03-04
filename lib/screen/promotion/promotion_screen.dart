import 'package:flutter/material.dart';

class PromotionScreen extends StatefulWidget {
  static const routeName = '/promotion';
  const PromotionScreen({Key? key}) : super(key: key);

  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Promotion Screen',
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    );
  }
}
