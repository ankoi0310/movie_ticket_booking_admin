import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/exception/bad_request_exception.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/room/component/room_form.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/popup_util.dart';

class RoomDataTableSource extends DataTableSource {
  RoomDataTableSource({required this.context, required this.provider});

  final BuildContext context;
  final RoomProvider provider;

  Future<void> update(Room newRoom) async {
    await provider.updateRoom(newRoom).then((response) async => {
      if(response.success) {
        PopupUtil.showSuccess(
          context: context,
          width: SizeConfig.screenWidth * 0.6 * 0.6,
          message: 'Cập nhật phòng thành công',
          onPress: () {
            Navigator.of(context).pop();
          },
        ),
      } else {
        PopupUtil.showError(
          context: context,
          width: SizeConfig.screenWidth * 0.6 * 0.6,
          message: response.message,
        ),
      }
    }).catchError((error) {
      PopupUtil.showError(
        context: context,
        width: SizeConfig.screenWidth * 0.6 * 0.6,
        message: error is BadRequestException ? error.message : 'Lỗi không xác định',
      );
    });

  }
  Future<void> delete(int id) async {
    await provider.deleteRoom(id).then((response) async => {
      if(response.success) {
        PopupUtil.showSuccess(
          context: context,
          width: SizeConfig.screenWidth * 0.6 * 0.6,
          message: 'Xoá phòng thành công',
          onPress: () {
            Navigator.of(context).pop();
          },
        ),
      } else {
        PopupUtil.showError(
          context: context,
          width: SizeConfig.screenWidth * 0.6 * 0.6,
          message: response.message,
        ),
      }
    }).catchError((error) {
      PopupUtil.showError(
        context: context,
        width: SizeConfig.screenWidth * 0.6 * 0.6,
        message: error is BadRequestException ? error.message : 'Lỗi không xác định',
      );
    });

  }

  @override
  DataRow2 getRow(int index) {
    assert(index >= 0);
    final Room room = provider.rooms[index];
    return DataRow2.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Center(child: Text(room.id.toString()))),
        DataCell(Center(child: Text(room.branch.name))),
        DataCell(Center(child: Text(room.name))),
        DataCell(Center(child: Text(room.totalSeat.toString()))),
        DataCell(Center(child: Text(room.row.toString()))),
        DataCell(Center(child: Text(room.col.toString()))),
        DataCell(Center(child: Text(room.roomState.value))),
        DataCell(Center(child: Text(room.type.value))),
        DataCell(
          Center(
            child: Row(
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
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  await update(room);
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
                              onPressed: () async {
                                await delete(room.id);
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
