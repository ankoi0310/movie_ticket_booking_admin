import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class RoomForm extends StatelessWidget {
  const RoomForm({
    super.key,
    required this.formKey,
    required this.room,
  });

  final GlobalKey<FormState> formKey;
  final Room room;

  @override
  Widget build(BuildContext context) {
    const row = 4;
    const column = 12;
    const columnMargin = [2];
    const rowMargin = [2];
    String selectedBranch = '0';
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            'Màn hình',
          ),
          const Divider(
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          const SizedBox(
            height: 50,
          ),
          FittedBox(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5 + rowMargin.length * 30 + row * 10,
              width: MediaQuery.of(context).size.width * 0.8 + columnMargin.length * 30 + column * 10,
              child: ListView.builder(
                itemCount: row,
                itemBuilder: (context, indexRow) {
                  return Row(
                    children: List.generate(
                      column,
                      (index) => Container(
                        margin: EdgeInsets.only(
                          right: index == column - 1
                              ? 10
                              : columnMargin.contains(index + 1)
                                  ? 30
                                  : 10,
                          bottom: indexRow == row - 1
                              ? 10
                              : rowMargin.contains(indexRow + 1)
                                  ? 30
                                  : 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        width: MediaQuery.of(context).size.width * 0.8 / column,
                        height: MediaQuery.of(context).size.height * 0.5 / row,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Thông tin phòng',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Tên phòng',
                  ),
                  onSaved: (value) {
                    room.name = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Flexible(
                      child: DropdownButton2(
                        isExpanded: true,
                        items: AppUtil.createDropdownList(
                          data: {
                            '0': 'Hà Nội',
                            '1': 'Hồ Chí Minh',
                            '2': 'Đà Nẵng',
                          },
                        ),
                        value: selectedBranch,
                        onChanged: (value) {
                          selectedBranch = value.toString();
                        },
                        buttonStyleData: getButtonStyleData(context),
                        iconStyleData: getIconStyleData(context),
                        dropdownStyleData: getDropdownStyleData(context),
                        menuItemStyleData: getMenuItemStyleData(context),
                        underline: Container(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
