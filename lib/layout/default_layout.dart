import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/component/activity.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/component/app_bar_action_items.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/config/responsive.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/layout/component/header.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/layout/component/side_bar_menu.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/style/colors.dart';

class DefaultLayout extends StatefulWidget {
  const DefaultLayout({Key? key, required this.title, required this.child}) : super(key: key);

  final String title;
  final Widget child;

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _drawerKey,
      drawer: !Responsive.isDesktop(context) ? const SizedBox(width: 100, child: SideBarMenu()) : null,
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              elevation: 0,
              backgroundColor: AppColors.white,
              leading: IconButton(
                  onPressed: () {
                    _drawerKey.currentState?.openDrawer();
                  },
                  icon: const Icon(Icons.menu, color: AppColors.black)),
              actions: const [
                AppBarActionItems(),
              ],
            )
          : const PreferredSize(
              preferredSize: Size.zero,
              child: SizedBox(),
            ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context)) const Expanded(flex: 3, child: SideBarMenu()),
            Expanded(
                flex: 11,
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Header(title: widget.title),
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical * 4),
                        Flexible(
                          flex: 9,
                          child: widget.child,
                        ),
                      ],
                    ),
                  ),
                )),
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 4,
                child: SafeArea(
                  child: Container(
                    width: double.infinity,
                    height: SizeConfig.screenHeight,
                    decoration: const BoxDecoration(color: AppColors.secondaryBg),
                    child: const SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                      child: Column(
                        children: [
                          AppBarActionItems(),
                          Activity(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
