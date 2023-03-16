import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/service/hive_storage_service.dart';

class AppBarActionItems extends StatelessWidget {
  const AppBarActionItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: SvgPicture.asset('icons/calendar.svg', width: 20),
          onPressed: () {},
        ),
        const SizedBox(width: 10),
        IconButton(icon: SvgPicture.asset('icons/ring.svg', width: 20.0), onPressed: () {}),
        const SizedBox(width: 15),
        Row(children: [
          InkWell(
            onTap: () async {
              await HiveDataStorageService.logOutUser();
              AppRouterDelegate().setPathName(RouteData.login.name, loggedIn: false);
            },
            child: const CircleAvatar(
              radius: 17,
              backgroundImage: NetworkImage(
                'https://cdn.shopify.com/s/files/1/0045/5104/9304/t/27/assets/AC_ECOM_SITE_2020_REFRESH_1_INDEX_M2_THUMBS-V2-1.jpg?v=8913815134086573859',
              ),
            ),
          ),
          const Icon(Icons.arrow_drop_down_outlined, color: AppColors.black)
        ]),
      ],
    );
  }
}
