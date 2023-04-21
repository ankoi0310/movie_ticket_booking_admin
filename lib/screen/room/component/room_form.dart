import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/seat.dart';

class RoomForm extends StatefulWidget {
  const RoomForm({
    super.key,
    required this.formKey,
    required this.room,
  });

  final GlobalKey<FormState> formKey;
  final Room room;

  @override
  State<RoomForm> createState() => _RoomFormState();
}

class _RoomFormState extends State<RoomForm> {
  late int row = 15;
  late int column = 15;

  late int laneRow;
  late int laneColumn;

  bool showSeats = false;
  late List<String> alphabet = [];

  late List<Seat> seats = [];

  String? branchSelected = "";

  @override
  Widget build(BuildContext context) {
    final BranchProvider branchProvider =
        Provider.of<BranchProvider>(context, listen: false);

    void check() {
      setState(() {
        showSeats = true;
        for (int i = 65; i <= 65 + row; i++) {
          alphabet.add(String.fromCharCode(i));
        }
        // Create Seat
        for (int i = 0; i < row; i++) {
          for (int j = 0; j < column; j++) {
            seats.add(Seat.initialize(
              code: "${alphabet[i]}${j + 1}",
              columnIndex: j,
              col: j,
              rowIndex: i,
              type: SeatType.normal,
              room: widget.room,
            ));
          }
        }
        widget.room.seats = seats;
        widget.room.totalSeat = row * column;
      });
    }

    void resetLane() {
      setState(() {
        widget.room.seats = [];
        widget.room.marginRightCols = [];
        widget.room.marginLeftCols = [];
      });
    }

    Widget _buildSeat(Seat seat) {
      return InkWell(
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: () {
          setState(() {
            if (seat.isSeat) {
              seats
                  .where((e) =>
                      e.columnIndex > seat.columnIndex &&
                      e.rowIndex == seat.rowIndex)
                  .toList()
                  .forEach((element) {
                --element.columnIndex;
                element.code =
                    "${alphabet[element.rowIndex]}${element.columnIndex}";
              });
            } else {
              Seat seatBefore;
              int b = seat.col - 1;
              Seat seatAfter;
              int a = seat.col + 1;

              print('seat ${seat.columnIndex}');

              print('a $a');
              print('b $b');
              do {
                seatBefore = seats.where((element) =>
                    element.columnIndex == b && element.rowIndex == seat.rowIndex).first;
              } while (!seatBefore.isSeat && b-- >= 0);

              do {
                seatAfter = seats.where((element) =>
                    element.columnIndex == a && element.rowIndex == seat.rowIndex).first;
              } while (!seatAfter.isSeat && a++ < column);
              print('a ${seatAfter.columnIndex}');
              print('b ${seatBefore.columnIndex}');

              int valueBefore = seatBefore.columnIndex;
              int valueAfter = seatAfter.columnIndex;
              int valueIndex = ((valueBefore + valueAfter) ~/ 2).round();
              seat.columnIndex = valueIndex;
              // print('valueIndex: $valueIndex');
              // print('valueBefore: $valueBefore');
              // print('valueAfter: $valueAfter');
              seats
                  .where((element) => element.isSeat &&
                      element.columnIndex >= valueIndex &&
                      element.rowIndex == seat.rowIndex)
                  .forEach((element) {
                print('element: ${element.columnIndex}');
                ++element.columnIndex;
                element.code =
                    "${alphabet[element.rowIndex]}${element.columnIndex}";
              });

              // seats.where((element) =>
              // element.isSeat && element.columnIndex < valueIndex &&
              //     element.rowIndex == seat.rowIndex
              // ).forEach((element) {
              //   --element.columnIndex;
              //   element.code =
              //   "${alphabet[element.rowIndex]}${element.columnIndex}";
              // });
            }
            seat.isSeat = !seat.isSeat;
          });
        },
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(seat.isSeat ? 1 : 0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.only(
            left: 3,
            right: 3,
            top: 3,
            bottom: 3,
          ),
          margin: const EdgeInsets.only(
            left: 3,
            right: 3,
            top: 3,
            bottom: 3,
          ),
          child: Center(
            child: Text(
              "${seat.isSeat ? seat.columnIndex : 'x'}",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
    }

    // Gridview
    Widget _buildSeats() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(row, (index) {
                return Container(
                  width: 30,
                  height: 30,
                  padding: const EdgeInsets.only(
                    left: 3,
                    right: 3,
                    top: 3,
                    bottom: 3,
                  ),
                  margin: const EdgeInsets.only(
                    left: 3,
                    right: 20,
                    top: 3,
                    bottom: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Center(
                      child: Text(
                    (alphabet[index]).toString(),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  )),
                );
              }),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(row, (indexRow) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(column, (indexCol) {
                      return _buildSeat(seats[indexRow * column + indexCol]);
                    }),
                  );
                })),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(row, (index) {
                return Container(
                  width: 30,
                  height: 30,
                  padding: const EdgeInsets.only(
                    left: 3,
                    right: 3,
                    top: 3,
                    bottom: 3,
                  ),
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 3,
                    top: 3,
                    bottom: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Center(
                      child: Text(
                    (alphabet[index]).toString(),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  )),
                );
              }),
              // Row(
              //   children: List.generate(row, (indexRow) {
              //     return Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: List.generate(column, (indexCol) {
              //         return _buildSeat(alphabet[indexRow], indexCol + 1);
              //       }),
              //     );
              //   }),
              // ),
            ),
          ],
        ),
      );
    }

    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: const EdgeInsets.only(right: 50),
                        child: TextFormField(
                          // initialValue: "0",
                          decoration: const InputDecoration(
                            labelText: 'Tên phòng',
                            labelStyle: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          onChanged: (value) {
                            widget.room.name = value;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: const EdgeInsets.only(right: 50),
                        child: FutureBuilder(
                            future: branchProvider.getBranches(),
                            builder: (context, snapshot) {
                              List<DropdownMenuItem> items = [
                                const DropdownMenuItem(
                                  child: Text("Chọn chi nhánh"),
                                  value: "",
                                ),
                              ];
                              items.addAll(branchProvider.branches
                                  .map((e) => DropdownMenuItem(
                                        child: Text(e.name),
                                        value: e.id,
                                      ))
                                  .toList());
                              return DropdownButton2(
                                isExpanded: true,
                                items: items,
                                value: branchSelected,
                                onChanged: (value) {
                                  setState(() {
                                    branchSelected = value!;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  // width: 300,
                                  padding: EdgeInsets.only(right: 14),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  elevation: 0,
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(Icons.arrow_forward_ios_outlined),
                                  iconSize: 14,
                                  openMenuIcon:
                                      Icon(Icons.keyboard_arrow_down, size: 14),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  // width: 300,
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  elevation: 8,
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness:
                                        MaterialStateProperty.all<double>(6),
                                    thumbVisibility:
                                        MaterialStateProperty.all<bool>(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.symmetric(horizontal: 14),
                                ),
                                underline: Container(),
                              );
                            }),
                      ),
                    ),
                    // Button check
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.only(right: 50),
                        child: TextFormField(
                          initialValue: "15",
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Số cột',
                            labelStyle: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              column =
                                  value.isEmpty ? row = 1 : int.parse(value!);
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.only(right: 50),
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          initialValue: "15",
                          decoration: const InputDecoration(
                            labelText: 'Số hàng',
                            labelStyle: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              row = value.isEmpty ? row = 1 : int.parse(value!);
                            });
                          },
                        ),
                      ),
                    ),
                    // Button check
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          child: const Text(
                            'Kiểm tra',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {
                            check();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // Button reset
                showSeats
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          child: const Text(
                            'Reset',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              resetLane();
                            });
                          },
                        ),
                      )
                    : Container(),

                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          showSeats
              ? Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  width: SizeConfig.screenWidth * 0.7,
                  child: Column(
                    children: [
                      const Text(
                        'Màn hình',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const Divider(
                        height: 20,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildSeats()
                    ],
                  ),
                )
              : Container(),
        ],
      )),
    );
  }
}
