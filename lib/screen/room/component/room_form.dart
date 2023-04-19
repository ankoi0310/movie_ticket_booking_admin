import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/component/hover_builder.dart';
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
  late int row;
  late int column;

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

    void createLane(int lane, int indexColumn, int indexRow) {
      switch (lane) {
        // Right
        case 0:
          {
            setState(() {
              widget.room.marginRightCols.add(indexColumn);
            });
            break;
          }
        // Left
        case 1:
          {
            setState(() {
              widget.room.marginLeftCols.add(indexColumn);
            });
          }
      }
    }

    void check() {
      setState(() {
        showSeats = true;
        for (int i = 65; i <= 65 + row; i++) {
          alphabet.add(String.fromCharCode(i));
        }
        // Create Seat
        for (int i = 0; i < row; i++) {
          for (int j = 0; j < column; j++) {
            seats.add(Seat.withoutId(
                position: "${alphabet[i]}${j + 1}",
                columnIndex: j + 1,
                rowIndex: i + 1,
                state: "Còn trống",
                createdAt: "",
                updatedAt: ""));
          }
        }
        widget.room.seats = seats;
        widget.room.totalSeat = row * column;
      });
    }

    void resetLane() {
      setState(() {
        widget.room.marginRightCols = [];
        widget.room.marginLeftCols = [];
      });
    }

    Widget _buildSeat(String alphabet, int index) {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(
          left: widget.room.marginLeftCols.contains(index) ? 50 : 3,
          right: widget.room.marginRightCols.contains(index) ? 50 : 3,
          top: 3,
          bottom: 3,
        ),
        child: Center(
          child: Text(
            "$alphabet$index",
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    // Gridview
    Widget _buildSeats() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(row + 1, (indexRow) {
              if (indexRow == 0) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(column, (indexCol) {
                    return Container(
                      width: 60,
                      height: 30,
                      margin: EdgeInsets.only(
                        left: widget.room.marginLeftCols.contains(indexCol + 1)
                            ? 50
                            : 3,
                        right:
                            widget.room.marginRightCols.contains(indexCol + 1)
                                ? 50
                                : 3,
                        top: 3,
                        bottom: 3,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          !widget.room.marginLeftCols.contains(indexCol + 1)
                              ? Container(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        createLane(
                                            1, indexCol + 1, indexRow + 1);
                                      });
                                    },
                                    child: Container(
                                      child: const Icon(
                                        Icons.chevron_left,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          Center(
                            child: Text(
                              "${indexCol + 1}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          !widget.room.marginRightCols.contains(indexCol + 1)
                              ? Container(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        createLane(0, indexCol + 1, indexRow);
                                      });
                                    },
                                    child: Container(
                                      child: const Icon(
                                        Icons.chevron_right,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  }),
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(column, (indexCol) {
                  return _buildSeat(alphabet[indexRow - 1], indexCol + 1);
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
                          initialValue: "1",
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
                              column = value.isEmpty ? row = 1 :int.parse(value!);
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
                          initialValue: "1",
                          decoration: const InputDecoration(
                            labelText: 'Số hàng',
                            labelStyle: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              row = value.isEmpty ? row = 1 :int.parse(value!);
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
