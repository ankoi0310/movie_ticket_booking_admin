import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/config/responsive.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/menu_icon.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/dashboard/dashboard_screen.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/style/colors.dart';

class SideBarMenu extends StatelessWidget {
  const SideBarMenu({
    Key? key,
  }) : super(key: key);

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
                onTap: () {
                  Navigator.pushNamed(context, DashboardScreen.routeName);
                },
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
                  press: () {
                    Navigator.pushNamed(context, sideBarMenuItems[index].route);
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

class SideBarTile extends StatefulWidget {
  const SideBarTile({
    super.key,
    required this.icon,
    required this.title,
    required this.press,
  });

  final String icon;
  final String title;
  final VoidCallback press;

  @override
  State<SideBarTile> createState() => _SideBarTileState();
}

class _SideBarTileState extends State<SideBarTile> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: isHover ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
      ),
      child: InkWell(
        onTap: widget.press,
        onHover: (value) {
          setState(() {
            isHover = value;
          });
        },
        child: Row(
          mainAxisAlignment: Responsive.isDesktop(context) ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: SvgPicture.asset(widget.icon),
            ),
            if (Responsive.isDesktop(context)) ...[
              const SizedBox(width: 40),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
