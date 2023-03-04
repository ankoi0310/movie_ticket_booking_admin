import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  static const String routeName = '/order';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Order Screen',
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    );
  }
}
