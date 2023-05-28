import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/config/responsive.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/style/colors.dart';

class SideBarTile extends StatefulWidget {

  const SideBarTile({
    super.key,
    required this.icon,
    required this.title,
    required this.press,
    required this.pathName,
  });

  final String icon;
  final String title;
  final VoidCallback press;
  final String pathName;

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
        color: isHover || AppRouterDelegate().pathName!.contains(widget.pathName)  ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
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
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
