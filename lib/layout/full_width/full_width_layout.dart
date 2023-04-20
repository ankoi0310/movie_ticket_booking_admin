import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class FullWidthLayout extends StatefulWidget {
  const FullWidthLayout({Key? key, required this.routeName}) : super(key: key);

  final String routeName;

  @override
  State<FullWidthLayout> createState() => _FullWidthLayoutState();
}

class _FullWidthLayoutState extends State<FullWidthLayout> {
  final RouteHandler _routeHandler = RouteHandler.instance;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: FutureBuilder(
          future: _routeHandler.getRouteWidget(widget.routeName),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data as Widget;
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
