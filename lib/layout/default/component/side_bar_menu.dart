import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/menu_icon.dart';

import 'side_bar_tile.dart';

class SideBarMenu extends StatefulWidget {
  const SideBarMenu({Key? key}) : super(key: key);

  @override
  State<SideBarMenu> createState() => _SideBarMenuState();
}

class _SideBarMenuState extends State<SideBarMenu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        width: double.infinity,
        height: SizeConfig.screenHeight,
        decoration: const BoxDecoration(color: AppColors.secondaryBg),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.topCenter,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: SizedBox(
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              ...List.generate(
                sideBarMenuItems.length,
                (index) => SideBarTile(
                  icon: sideBarMenuItems[index].icon,
                  title: sideBarMenuItems[index].title,
                  pathName: sideBarMenuItems[index].route.name,
                  press: () {
                    setState(() {
                      AppRouterDelegate().setPathName(sideBarMenuItems[index].route.name);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
