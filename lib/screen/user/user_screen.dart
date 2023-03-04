import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  static const routeName = '/user';
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'User Screen',
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    );
  }
}
