import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/branch/branch_search.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/movie/movie_search.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/room/room_search.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/show_time.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/string_util.dart';

class ShowtimeForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final ShowTime showtime;

  const ShowtimeForm({Key? key, required this.formKey, required this.showtime}) : super(key: key);

  @override
  State<ShowtimeForm> createState() => _ShowtimeFormState();
}

class _ShowtimeFormState extends State<ShowtimeForm> {
  DateTime dateSelected = DateTime.now();
  TimeOfDay timeSelected = const TimeOfDay(hour: 0, minute: 0);

  Branch? branchSelected = Branch.empty();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.showtime.room!.branch.id != 0) {
      branchSelected = widget.showtime.room!.branch;
      timeSelected = TimeOfDay(hour: widget.showtime.startTime!.hour, minute: widget.showtime.startTime!.minute);
      dateSelected = widget.showtime.startTime!;
    } else {
      widget.showtime.startTime = DateTime.utc(
        dateSelected.year,
        dateSelected.month,
        dateSelected.day,
        timeSelected.hour,
        timeSelected.minute,
      );
      widget.showtime.endTime = widget.showtime.startTime!.add(Duration(minutes: widget.showtime.movie!.duration));
    }
  }


  @override
  Widget build(BuildContext context) {
    final datePickerController = TextEditingController(text: DateFormat('dd-MM-yyyy').format(dateSelected));
    final timePickerController = TextEditingController(text: timeSelected.format(context));

    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    final branchProvider = Provider.of<BranchProvider>(context, listen: false);
    final roomProvider = Provider.of<RoomProvider>(context, listen: false);


    return Form(
      key: widget.formKey,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.start,
        runSpacing: 30,
        spacing: 30,
        children: [
          Container(
            width: SizeConfig.screenWidth * 0.3 * 0.6,
            child: FutureBuilder(
                future: branchProvider.getBranches(BranchSearch(hasRoom: true)),
                builder: (context, snapshot) {
                  if (branchProvider.branches.isNotEmpty) {
                    List<DropdownMenuItem> items = [];
                    items.add(DropdownMenuItem(
                      value: Branch.empty(),
                      child: Text("Chọn rạp"),
                    ));
                    items.addAll(branchProvider.branches
                        .map((e) =>
                        DropdownMenuItem(
                          value: e,
                          child: Text(e.name),
                        ))
                        .toList());
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Chi nhánh: '),
                        SizedBox(
                          height: (10),
                        ),
                        DropdownButton2(
                          isExpanded: true,
                          items: items,
                          value: branchSelected,
                          onChanged: (value) {
                            setState(() {
                              branchSelected = value!;
                              widget.showtime.room = Room.empty();
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            width: SizeConfig.screenWidth * 0.3 * 0.6,
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            elevation: 0,
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(Icons.arrow_forward_ios_outlined),
                            iconSize: 14,
                            openMenuIcon: Icon(Icons.keyboard_arrow_down, size: 14),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            width: SizeConfig.screenWidth * 0.3 * 0.6,
                            decoration: const BoxDecoration(color: Colors.white),
                            elevation: 8,
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility: MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 14),
                          ),
                          underline: Container(),
                        ),
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
          Container(
            width: SizeConfig.screenWidth * 0.3 * 0.6,
            child: FutureBuilder(
                future: roomProvider.getRooms(RoomSearch(
                  branch: branchSelected,
                )),
                builder: (context, snapshot) {
                  if (snapshot.hasData && roomProvider.rooms.isNotEmpty && branchSelected != null) {
                    List<DropdownMenuItem> items = [];
                    items.add(DropdownMenuItem(
                      value: Room.empty(),
                      child: Text("Chọn phòng"),
                    ));
                    items.addAll(roomProvider.rooms
                        .map((e) =>
                        DropdownMenuItem(
                          value: e,
                          child: Text(e.name),
                        ))
                        .toList());

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phòng chiếu: '),
                        SizedBox(
                          height: (10),
                        ),
                        DropdownButton2(
                          isExpanded: true,
                          items: items,
                          value: widget.showtime.room,
                          onChanged: (value) {
                            setState(() {
                              widget.showtime.room = value!;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            width: SizeConfig.screenWidth * 0.3 * 0.6,
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            elevation: 0,
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(Icons.arrow_forward_ios_outlined),
                            iconSize: 14,
                            openMenuIcon: Icon(Icons.keyboard_arrow_down, size: 14),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 200,
                            width: SizeConfig.screenWidth * 0.3 * 0.6,
                            decoration: const BoxDecoration(color: Colors.white),
                            elevation: 8,
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility: MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 18),
                          ),
                          underline: Container(),
                        ),
                      ],
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text('Phòng chiếu: '),
                      SizedBox(
                        height: (10),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Center(child: Text('Không có phòng chiếu nào')),
                      ),
                    ],
                  );
                }),
          ),
          Container(
            width: SizeConfig.screenWidth * 0.3 * 0.6,
            child: FutureBuilder(
                future: movieProvider.getMovies(MovieSearch()),
                builder: (context, snapshot) {
                  if (snapshot.hasData && movieProvider.movies.isNotEmpty) {
                    List<DropdownMenuItem> items = [];
                    items.add(DropdownMenuItem(
                      value: Movie.empty(),
                      child: Text("Chọn phim"),
                    ));
                    items.addAll(movieProvider.movies
                        .map((e) =>
                        DropdownMenuItem(
                          value: e,
                          child: Text(e.name),
                        ))
                        .toList());


                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phim: '),
                        SizedBox(
                          height: (10),
                        ),
                        DropdownButton2(
                          isExpanded: true,
                          items: items,
                          value: widget.showtime.movie,
                          onChanged: (value) {
                            setState(() {
                              widget.showtime.movie = value!;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            width: SizeConfig.screenWidth * 0.3 * 0.6,
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            elevation: 0,
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(Icons.arrow_forward_ios_outlined),
                            iconSize: 14,
                            openMenuIcon: Icon(Icons.keyboard_arrow_down, size: 14),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 200,
                            width: SizeConfig.screenWidth * 0.3 * 0.6,
                            decoration: const BoxDecoration(color: Colors.white),
                            elevation: 8,
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility: MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 18),
                          ),
                          underline: Container(),
                        ),
                      ],
                    );
                  }
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }),
          ),
          Container(),
          Container(
            width: SizeConfig.screenWidth * 0.3 * 0.6,
            child: TextFormField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              initialValue: widget.showtime.price.toString(),
              decoration: const InputDecoration(
                labelText: 'Giá vé',
              ),
              onSaved: (value) {
                widget.showtime.price = int.parse(value!);
              },
            ),
          ),
          Container(
              width: SizeConfig.screenWidth * 0.3 * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ngày phát hành: '),
                  SizedBox(
                    height: (10),
                  ),
                  TextFormField(
                    controller: datePickerController,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      height: 1.5,
                    ),
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Chọn ngày tháng năm",
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        height: 1.5,
                      ),
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                        size: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: dateSelected,
                        currentDate: dateSelected,
                        firstDate: DateTime.utc(DateTime
                            .now()
                            .year, DateTime
                            .now()
                            .month, DateTime
                            .now()
                            .day - 1),
                        lastDate: DateTime.utc(DateTime
                            .now()
                            .year, DateTime
                            .now()
                            .month, DateTime
                            .now()
                            .day + 7),
                      ).then((value) {
                        setState(() {
                          dateSelected = value!;
                          widget.showtime.startTime = DateTime.utc(
                            dateSelected.year,
                            dateSelected.month,
                            dateSelected.day,
                            timeSelected.hour,
                            timeSelected.minute,
                          );
                          widget.showtime.endTime = widget.showtime.startTime!.add(Duration(minutes: widget.showtime.movie!.duration));
                        });
                        datePickerController.text = DateFormat('dd-MM-yyyy').format(value ?? DateTime.now());
                      });
                    },
                  ),
                ],
              )),
          Container(
              width: SizeConfig.screenWidth * 0.3 * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Giờ chiếu: '),
                  SizedBox(
                    height: (10),
                  ),
                  TextFormField(
                    controller: timePickerController,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      height: 1.5,
                    ),
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Chọn ngày tháng năm",
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        height: 1.5,
                      ),
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                        size: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: timeSelected,
                        hourLabelText: 'Giờ',
                        minuteLabelText: 'Phút',
                        initialEntryMode: TimePickerEntryMode.input,
                        builder: (context, child) {
                          return MediaQuery(
                            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                            child: child!,
                          );
                        },
                      ).then((value) {
                        setState(() {
                          timeSelected = value!;
                          widget.showtime.startTime = DateTime.utc(
                            dateSelected.year,
                            dateSelected.month,
                            dateSelected.day,
                            timeSelected.hour,
                            timeSelected.minute,
                          );
                          widget.showtime.endTime = widget.showtime.startTime!.add(Duration(minutes: widget.showtime.movie!.duration));
                        });
                        timePickerController.text = value!.format(context);
                      });
                    },
                  ),
                ],
              )),
          Container(
              width: SizeConfig.screenWidth * 0.3 * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Thể loại chiếu: '),
                  SizedBox(
                    height: (10),
                  ),
                  widget.showtime.movie!.id != 0? DropdownButton2(
                    isExpanded: true,
                    items: widget.showtime.movie!.movieFormats.map((e) =>
                        DropdownMenuItem(
                          value: e,
                          child: Text(StringUtil.changeMovieFormat(e)),
                        )).toList(),
                    value: widget.showtime.movie!.movieFormats.contains(widget.showtime.movieFormat) ? widget.showtime.movieFormat: widget.showtime.movie!.movieFormats[0],
                    onChanged: (value) {
                      setState(() {
                        widget.showtime.movieFormat = value as MovieFormat;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      width: SizeConfig.screenWidth * 0.3 * 0.6,
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      elevation: 0,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(Icons.arrow_forward_ios_outlined),
                      iconSize: 14,
                      openMenuIcon: Icon(Icons.keyboard_arrow_down, size: 14),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      width: SizeConfig.screenWidth * 0.3 * 0.6,
                      decoration: const BoxDecoration(color: Colors.white),
                      elevation: 8,
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 14),
                    ),
                    underline: Container(),
                  ): Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(child: Text('Vui lòng chọn phim trước')),
                  )
                ],
              )
          ),

        ],
      ),
    );
  }
}
