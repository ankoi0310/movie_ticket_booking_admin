import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/room/component/room_form.dart';

class RoomDataTableSource extends DataTableSource {
  RoomDataTableSource({required this.context, required this.provider});

  final BuildContext context;
  final RoomProvider provider;

  @override
  DataRow2 getRow(int index) {
    assert(index >= 0);
    final Room room = provider.rooms[index];
    return DataRow2.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(room.id)),
        DataCell(Text(room.name)),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit),
                tooltip: 'Nhấn để chỉnh sửa',
                onPressed: () {
                  if (Responsive.isDesktop(context)) {
                    final formKey = GlobalKey<FormState>();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Chỉnh sửa thể loại'),
                        content: Container(
                          padding: const EdgeInsets.all(8),
                          child: RoomForm(
                            formKey: formKey,
                            room: room,
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: const Text('Hủy'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Lưu'),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                provider.updateRoom(room).then((value) async => {Navigator.of(context).pop()});
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                tooltip: 'Nhấn để xóa',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Xoá thể loại'),
                        content: const Text('Bạn có chắc chắn muốn xoá?'),
                        actions: <Widget>[
                          ElevatedButton(child: const Text('Hủy'), onPressed: () => Navigator.of(context).pop()),
                          ElevatedButton(
                            child: const Text('Xoá'),
                            onPressed: () {
                              provider.deleteRoom(room.id).then((value) async => Navigator.of(context).pop());
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => provider.rooms.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
