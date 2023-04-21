import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/component/loading_provider.dart';

import 'component/activity.dart';
import 'component/app_bar_action_items.dart';
import 'component/header.dart';
import 'component/side_bar_menu.dart';

class DefaultLayout extends StatefulWidget {
  const DefaultLayout({Key? key, required this.routeName}) : super(key: key);

  final String routeName;

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final RouteHandler _routeHandler = RouteHandler.instance;

  @override
  Widget build(BuildContext context) {
    final loadingProvider = Provider.of<LoadingProvider>(context);

    showLoading() {
      showDialog(
        context: context,
        builder: (context) => Positioned.fill(
          top: 0,
          left: 0,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      key: _drawerKey,
      drawer: !Responsive.isDesktop(context)
          ? const SizedBox(width: 100, child: SideBarMenu())
          : null,
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
            if (Responsive.isDesktop(context))
              const Expanded(flex: 3, child: SideBarMenu()),
            Expanded(
                flex: 11,
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Header(title: _routeHandler.getRouteTitle(widget.routeName)),
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical * 4),
                        Flexible(
                          flex: 9,
                          child: FutureBuilder(
                            future: _routeHandler.getRouteWidget(widget.routeName),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data as Widget;
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
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
                    decoration:
                        const BoxDecoration(color: AppColors.secondaryBg),
                    child: const SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          vertical: 30, horizontal: 30),
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
