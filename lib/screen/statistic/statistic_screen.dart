import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/component/bar_chart.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/config/responsive.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/constant/constants.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/app_util.dart';

class StatisticScreen extends StatefulWidget {
  static const String routeName = '/statistic';

  const StatisticScreen({Key? key}) : super(key: key);

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  String selectedType = statisticType.entries.first.key;
  String selectedRange = statisticRange.entries.first.key;
  List<DropdownMenuItem<dynamic>> items = [];
  dynamic selectedDetailItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Responsive.isDesktop(context)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DropdownButton2(
                    isExpanded: true,
                    items: AppUtil.createDropdownList(data: statisticType),
                    value: selectedType,
                    onChanged: (value) {
                      chooseType(value);
                    },
                    buttonStyleData: ButtonStyleData(
                      width: Responsive.isDesktop(context) ? SizeConfig.screenWidth * 0.15 : SizeConfig.screenWidth,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(Icons.arrow_forward_ios_outlined),
                      iconSize: 14,
                      iconEnabledColor: Colors.white,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: Responsive.isDesktop(context) ? SizeConfig.screenWidth * 0.15 : SizeConfig.screenWidth,
                      decoration: const BoxDecoration(color: Colors.black),
                      elevation: 8,
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 14),
                    ),
                    underline: Container(),
                  ),
                  const SizedBox(width: 20),
                  if (items.isNotEmpty) ...[
                    DropdownButton2<dynamic>(
                      isExpanded: true,
                      items: items,
                      value: selectedDetailItem,
                      onChanged: (value) {
                        setState(() {
                          selectedDetailItem = value;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        width: Responsive.isDesktop(context) ? SizeConfig.screenWidth * 0.15 : SizeConfig.screenWidth,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(Icons.arrow_forward_ios_outlined),
                        iconSize: 14,
                        iconEnabledColor: Colors.white,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: Responsive.isDesktop(context) ? SizeConfig.screenWidth * 0.15 : SizeConfig.screenWidth,
                        decoration: const BoxDecoration(color: Colors.black),
                        elevation: 8,
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all<double>(6),
                          thumbVisibility: MaterialStateProperty.all<bool>(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 14),
                      ),
                      underline: Container(),
                    ),
                    const SizedBox(width: 20),
                  ],
                  DropdownButton2(
                    isExpanded: true,
                    items: AppUtil.createDropdownList(data: statisticRange),
                    value: selectedRange,
                    onChanged: (value) {
                      setState(() {
                        selectedRange = value.toString();
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      width: Responsive.isDesktop(context) ? SizeConfig.screenWidth * 0.15 : SizeConfig.screenWidth,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(Icons.arrow_forward_ios_outlined),
                      iconSize: 14,
                      iconEnabledColor: Colors.white,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: Responsive.isDesktop(context) ? SizeConfig.screenWidth * 0.15 : SizeConfig.screenWidth,
                      decoration: const BoxDecoration(color: Colors.black),
                      elevation: 8,
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 14),
                    ),
                    underline: Container(),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButton2(
                    isExpanded: true,
                    items: AppUtil.createDropdownList(data: statisticType),
                    value: selectedType,
                    onChanged: (value) {
                      chooseType(value);
                    },
                    buttonStyleData: ButtonStyleData(
                      width: Responsive.isDesktop(context) ? SizeConfig.screenWidth * 0.15 : SizeConfig.screenWidth,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(Icons.arrow_forward_ios_outlined),
                      iconSize: 14,
                      iconEnabledColor: Colors.white,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: Responsive.isDesktop(context) ? SizeConfig.screenWidth * 0.15 : SizeConfig.screenWidth,
                      decoration: const BoxDecoration(color: Colors.black),
                      elevation: 8,
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 14),
                    ),
                    underline: Container(),
                  ),
                  const SizedBox(height: 20),
                  if (items.isNotEmpty) ...[
                    DropdownButton2<dynamic>(
                      isExpanded: true,
                      items: items,
                      value: selectedDetailItem,
                      onChanged: (value) {
                        setState(() {
                          selectedDetailItem = value;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        width: Responsive.isDesktop(context) ? SizeConfig.screenWidth * 0.15 : SizeConfig.screenWidth,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(Icons.arrow_forward_ios_outlined),
                        iconSize: 14,
                        iconEnabledColor: Colors.white,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: Responsive.isDesktop(context) ? SizeConfig.screenWidth * 0.15 : SizeConfig.screenWidth,
                        decoration: const BoxDecoration(color: Colors.black),
                        elevation: 8,
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all<double>(6),
                          thumbVisibility: MaterialStateProperty.all<bool>(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 14),
                      ),
                      underline: Container(),
                    ),
                    const SizedBox(height: 20),
                  ],
                  DropdownButton2(
                    isExpanded: true,
                    items: AppUtil.createDropdownList(data: statisticRange),
                    value: selectedRange,
                    onChanged: (value) {
                      setState(() {
                        selectedRange = value.toString();
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      width: Responsive.isDesktop(context) ? SizeConfig.screenWidth * 0.15 : SizeConfig.screenWidth,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(Icons.arrow_forward_ios_outlined),
                      iconSize: 14,
                      iconEnabledColor: Colors.white,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: Responsive.isDesktop(context) ? SizeConfig.screenWidth * 0.15 : SizeConfig.screenWidth,
                      decoration: const BoxDecoration(color: Colors.black),
                      elevation: 8,
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 14),
                    ),
                    underline: Container(),
                  ),
                ],
              ),
        const SizedBox(height: 40),
        SizedBox(
          height: SizeConfig.screenHeight * 0.6,
          child: const BarChartCopmponent(),
        ),
      ],
    );
  }

  void chooseType(value) {
    setState(() {
      selectedType = value.toString();
    });

    switch (value.toString()) {
      case 'revenue-per-movie':
      case 'showtime-per-movie':
      case 'order-per-movie':
        // get movie list
        items = AppUtil.createDropdownDetailList(data: movies);
        selectedDetailItem = items.first.value;
        break;
      case 'revenue-per-branch':
      case 'showtime-per-branch':
      case 'order-per-branch':
        // get cinema list
        items = AppUtil.createDropdownDetailList(data: branches);
        selectedDetailItem = items.first.value;
        break;
      default:
        items = [];
        break;
    }
  }
}
