import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/component/bar_chart.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/branch/branch_search.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/movie/movie_search.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/handler/http_response.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({Key? key}) : super(key: key);

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  late final StatisticProvider _statisticProvider =
      Provider.of<StatisticProvider>(context, listen: false);
  late final BranchProvider _branchProvider =
      Provider.of<BranchProvider>(context, listen: false);
  late final MovieProvider _movieProvider =
      Provider.of<MovieProvider>(context, listen: false);
  String selectedValue = statisticValue.entries.first.key;
  String selectedTimeline = statisticTimeline.entries.first.key;
  List<DropdownMenuItem<dynamic>> items = [];
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Responsive.isDesktop(context)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DropdownButton2(
                    isExpanded: true,
                    items: AppUtil.createDropdownList(data: statisticValue),
                    value: selectedValue,
                    onChanged: (value) async {
                      await chooseType(value);
                    },
                    buttonStyleData: ButtonStyleData(
                      width: Responsive.isDesktop(context)
                          ? SizeConfig.screenWidth * 0.15
                          : SizeConfig.screenWidth,
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
                      width: Responsive.isDesktop(context)
                          ? SizeConfig.screenWidth * 0.15
                          : SizeConfig.screenWidth,
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
                      value: selectedItem,
                      onChanged: (value) {
                        setState(() {
                          selectedItem = value;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        width: Responsive.isDesktop(context)
                            ? SizeConfig.screenWidth * 0.15
                            : SizeConfig.screenWidth,
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
                        width: Responsive.isDesktop(context)
                            ? SizeConfig.screenWidth * 0.15
                            : SizeConfig.screenWidth,
                        decoration: const BoxDecoration(color: Colors.black),
                        elevation: 8,
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all<double>(6),
                          thumbVisibility:
                              MaterialStateProperty.all<bool>(true),
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
                    items: AppUtil.createDropdownList(data: statisticTimeline),
                    value: selectedTimeline,
                    onChanged: (value) {
                      setState(() {
                        selectedTimeline = value!;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      width: Responsive.isDesktop(context)
                          ? SizeConfig.screenWidth * 0.15
                          : SizeConfig.screenWidth,
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
                      width: Responsive.isDesktop(context)
                          ? SizeConfig.screenWidth * 0.15
                          : SizeConfig.screenWidth,
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
                    items: AppUtil.createDropdownList(data: statisticValue),
                    value: selectedValue,
                    onChanged: (value) async {
                      await chooseType(value);
                    },
                    buttonStyleData: ButtonStyleData(
                      width: Responsive.isDesktop(context)
                          ? SizeConfig.screenWidth * 0.15
                          : SizeConfig.screenWidth,
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
                      width: Responsive.isDesktop(context)
                          ? SizeConfig.screenWidth * 0.15
                          : SizeConfig.screenWidth,
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
                      value: selectedItem,
                      onChanged: (value) {
                        setState(() {
                          selectedItem = value;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        width: Responsive.isDesktop(context)
                            ? SizeConfig.screenWidth * 0.15
                            : SizeConfig.screenWidth,
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
                        width: Responsive.isDesktop(context)
                            ? SizeConfig.screenWidth * 0.15
                            : SizeConfig.screenWidth,
                        decoration: const BoxDecoration(color: Colors.black),
                        elevation: 8,
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all<double>(6),
                          thumbVisibility:
                              MaterialStateProperty.all<bool>(true),
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
                    items: AppUtil.createDropdownList(data: statisticTimeline),
                    value: selectedTimeline,
                    onChanged: (value) {
                      setState(() {
                        selectedTimeline = value.toString();
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      width: Responsive.isDesktop(context)
                          ? SizeConfig.screenWidth * 0.15
                          : SizeConfig.screenWidth,
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
                      width: Responsive.isDesktop(context)
                          ? SizeConfig.screenWidth * 0.15
                          : SizeConfig.screenWidth,
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
        FutureBuilder(
          future: _statisticProvider.getStatistic(
            StatisticFilter(
              value: selectedValue,
              timeline: selectedTimeline,
              branchId: selectedItem,
              movieId: selectedItem,
            ),
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              HttpResponse response = snapshot.data as HttpResponse;
              return SizedBox(
                height: SizeConfig.screenHeight * 0.6,
                child: BarChartCopmponent(
                  data: Map.from(response.data),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ],
    );
  }

  Future<void> chooseType(value) async {
    setState(() {
      selectedValue = value.toString();
    });

    switch (value.toString()) {
      case 'BRANCH':
        _branchProvider.getBranches(BranchSearch()).then((response) {
          if (response.success) {
            Map<int, String> branches = {
              for (var e in _branchProvider.branches) e.id: e.name
            };
            setState(() {
              items = AppUtil.createDropdownDetailList(data: branches);
              selectedItem = items.first.value;
            });
          }
        });
        break;
      case 'MOVIE':
        _movieProvider.getMovies(MovieSearch()).then((response) {
          if (response.success) {
            Map<int, String> movies = {
              for (var e in _movieProvider.movies) e.id: e.name
            };
            setState(() {
              items = AppUtil.createDropdownDetailList(data: movies);
              selectedItem = items.first.value;
            });
          }
        });
        break;
      default:
        setState(() {
          items = [];
        });
        break;
    }
  }
}
