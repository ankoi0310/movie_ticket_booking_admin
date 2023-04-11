import 'package:flutter/material.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Ticket Screen',
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    );
  }
}
