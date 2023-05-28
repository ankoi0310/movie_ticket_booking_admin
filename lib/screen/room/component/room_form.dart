import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/branch/branch_search.dart';
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
  final TextEditingController colController = TextEditingController(
    text: '5',
  );
  final TextEditingController rowController = TextEditingController(
    text: '5',
  );

  late int row = widget.room.row;
  late int column = widget.room.col;

  bool showSeats = false;
  late List<String> alphabet = [];

  Branch? branchSelected = Branch.empty();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.room.branch.id != 0) {
      branchSelected = widget.room.branch;
      showSeats = true;

      colController.text = widget.room.col.toString();
      rowController.text = widget.room.row.toString();

      for (int i = 65; i <= 65 + row; i++) {
        alphabet.add(String.fromCharCode(i));
      }

      widget.room.seats.sort((seat, other) {
        if (seat.row < other.row) {
          return -1;
        } else if (seat.row > other.row) {
          return 1;
        } else {
          if (seat.col < other.col) {
            return -1;
          } else if (seat.col > other.col) {
            return 1;
          } else {
            return 0;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final BranchProvider branchProvider = Provider.of<BranchProvider>(context, listen: false);

    void check() {
      widget.room.seats.clear();
      setState(() {
        column = int.parse(colController.text);
        row = int.parse(rowController.text);

        for (int i = 65; i <= 65 + row; i++) {
          alphabet.add(String.fromCharCode(i));
        }
        // Create Seat
        for (int i = 0; i < row; i++) {
          for (int j = 0; j < column; j++) {
            widget.room.seats.add(Seat.initialize(
              code: "${alphabet[i]}${j + 1}",
              columnIndex: j + 1,
              col: j + 1,
              rowIndex: i,
              row: i,
              type: SeatType.normal,
            ));
          }
        }
        widget.room.row = row;
        widget.room.col = column;
        widget.room.totalSeat = row * column;
        widget.room.laneRows = [];
        widget.room.laneCols = [];

        showSeats = true;
      });
    }

    void resetLane() {
      setState(() {
        widget.room.seats.forEach((e) {
          e.isSeat = true;
          e.columnIndex = e.col;
          e.code = "${alphabet[e.rowIndex]}${e.columnIndex}";
        });
      });
    }

    bool lastSeatInRow(Seat seat) {
      if (seat.isSeat) {
        return widget.room.seats.where((e) => e.row == seat.row && e.isSeat).length == 1;
      } else if (!seat.isSeat) {
        return widget.room.seats.where((e) => e.row == seat.row && !e.isSeat).length == column;
      }
      return false;
    }


    Widget buildSeat(Seat seat) {
      return InkWell(
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: () {
          setState(() {
            if (seat.isSeat) {
              widget.room.seats.where((e) => e.col > seat.col && e.row == seat.row).toList().forEach((element) {
                --element.columnIndex;
                element.code = "${alphabet[element.rowIndex]}${element.columnIndex}";
              });

              // Kiểm tra có phải là ghế cuối cùng trong hàng không nếu có thì update row cho tất cả các ghế sau
              if (lastSeatInRow(seat)) {
                widget.room.seats.where((e) => e.row > seat.row).forEach((element) {
                  --element.rowIndex;
                  element.code = "${alphabet[element.rowIndex]}${element.columnIndex}";
                });
                widget.room.laneRows.add(seat.row);
              }
            } else {
              Seat seatBefore;
              int b = seat.col - 1;

              do {
                var list = widget.room.seats.where((element) => element.col == b && element.row == seat.row);
                if (list.isEmpty) {
                  seatBefore = Seat.empty();
                  break;
                } else {
                  seatBefore = list.first;
                }
              } while (!seatBefore.isSeat && --b > 0);

              if (!seatBefore.isSeat) {
                seat.columnIndex = 1;
                seat.code = "${alphabet[seat.rowIndex]}${seat.columnIndex}";
              } else {
                int valueBefore = seatBefore.columnIndex;
                int valueIndex = valueBefore + 1;
                seat.columnIndex = valueIndex;
                seat.code = "${alphabet[seat.rowIndex]}${seat.columnIndex}";
              }
              widget.room.seats.where((element) => element.isSeat && element.col > seat.col && element.row == seat.row).forEach((element) {
                ++element.columnIndex;
                element.code = "${alphabet[element.rowIndex]}${element.columnIndex}";
              });

              if (lastSeatInRow(seat)) {
                widget.room.seats.where((e) => e.row > seat.row).forEach((element) {
                  ++element.rowIndex;
                  element.code = "${alphabet[element.rowIndex]}${element.columnIndex}";
                });

                widget.room.laneRows.remove(seat.row);
              }
            }
            seat.isSeat = !seat.isSeat;
          });
        },
        child: Container(
          width: 35,
          height: 35,
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
              "${seat.isSeat ? seat.code : 'x'}",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ),
      );
    }

    // Gridview
    Widget buildSeats() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(row, (indexRow) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(column, (indexCol) {
                  return buildSeat(widget.room.seats[indexRow * column + indexCol]);
                }),
              );
            })),
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
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.only(right: 50),
                        child: TextFormField(
                          initialValue: widget.room.name,
                          decoration: const InputDecoration(
                            labelText: 'Tên phòng',
                            labelStyle: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Tên phòng không được để trống';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            widget.room.name = value!;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.only(right: 50),
                        child: FutureBuilder(
                            future: branchProvider.getBranches(BranchSearch()),
                            builder: (context, snapshot) {
                              if (branchProvider.branches.isNotEmpty) {
                                List<DropdownMenuItem> items = [];
                                items.add(DropdownMenuItem(value: Branch.empty(), child: Text("Chọn chi nhánh")));

                                items.addAll(branchProvider.branches
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e.name),
                                        ))
                                    .toList());

                                return DropdownButton2(
                                  isExpanded: true,
                                  items: items,
                                  value: branchSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      branchSelected = value!;
                                      widget.room.branch = branchSelected!;
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
                                    openMenuIcon: Icon(Icons.keyboard_arrow_down, size: 14),
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 200,
                                    // width: 300,
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
                                    padding: EdgeInsets.symmetric(horizontal: 14),
                                  ),
                                  underline: Container(),
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.only(right: 50),
                        child: DropdownButton2(
                          isExpanded: true,
                          items: RoomType.values
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.value),
                                  ))
                              .toList(),
                          value: widget.room.type,
                          onChanged: (value) {
                            setState(() {
                              widget.room.type = value as RoomType;
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
                            openMenuIcon: Icon(Icons.keyboard_arrow_down, size: 14),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 200,
                            // width: 300,
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
                            padding: EdgeInsets.symmetric(horizontal: 14),
                          ),
                          underline: Container(),
                        ),
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
                          controller: colController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Số cột',
                            labelStyle: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.only(right: 50),
                        child: TextFormField(
                          controller: rowController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Số hàng',
                            labelStyle: TextStyle(
                              fontSize: 16,
                            ),
                          ),
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
                            resetLane();
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
                      buildSeats(),
                    ],
                  ),
                )
              : Container(),
        ],
      )),
    );
  }
}
