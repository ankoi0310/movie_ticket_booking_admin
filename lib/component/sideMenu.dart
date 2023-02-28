import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/style/colors.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                alignment: Alignment.topCenter,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: 35,
                  height: 20,
                  child: SvgPicture.asset('assets/icons/mac-action.svg'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40.0),
                child: IconButton(
                  color: AppColors.iconGray,
                  icon: SvgPicture.asset(
                    'assets/icons/home.svg',
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {},
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40.0),
                child: IconButton(
                  color: AppColors.iconGray,
                  icon: SvgPicture.asset(
                    'assets/icons/pie-chart.svg',
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {},
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40.0),
                child: IconButton(
                  color: AppColors.iconGray,
                  icon: SvgPicture.asset(
                    'assets/icons/clipboard.svg',
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {},
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40.0),
                child: IconButton(
                  color: AppColors.iconGray,
                  icon: SvgPicture.asset(
                    'assets/icons/credit-card.svg',
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {},
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40.0),
                child: IconButton(
                  color: AppColors.iconGray,
                  icon: SvgPicture.asset(
                    'assets/icons/trophy.svg',
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {},
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40.0),
                child: IconButton(
                  color: AppColors.iconGray,
                  icon: SvgPicture.asset(
                    'assets/icons/invoice.svg',
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
