import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

DropdownStyleData getDropdownStyleData(BuildContext context) {
  return DropdownStyleData(
    maxHeight: 200,
    width: Responsive.isDesktop(context) ? SizeConfig.screenWidth * 0.15 : SizeConfig.screenWidth,
    decoration: const BoxDecoration(color: Colors.black),
    elevation: 8,
    scrollbarTheme: ScrollbarThemeData(
      radius: const Radius.circular(40),
      thickness: MaterialStateProperty.all<double>(6),
      thumbVisibility: MaterialStateProperty.all<bool>(true),
    ),
  );
}

MenuItemStyleData getMenuItemStyleData(BuildContext context) {
  return const MenuItemStyleData(
    height: 40,
    padding: EdgeInsets.symmetric(horizontal: 14),
  );
}

ButtonStyleData getButtonStyleData(BuildContext context) {
  return ButtonStyleData(
    width: Responsive.isDesktop(context) ? SizeConfig.screenWidth * 0.15 : SizeConfig.screenWidth,
    padding: const EdgeInsets.symmetric(horizontal: 14),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.5),
    ),
    elevation: 2,
  );
}

IconStyleData getIconStyleData(BuildContext context) {
  return const IconStyleData(
    icon: Icon(Icons.arrow_forward_ios_outlined),
    iconSize: 14,
    iconEnabledColor: Colors.white,
    iconDisabledColor: Colors.grey,
  );
}
