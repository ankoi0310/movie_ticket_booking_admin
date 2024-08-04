import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/show_time.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/exception/bad_request_exception.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/showtime/components/show_time_form.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/popup_util.dart';

class ShowtimeDataSource extends DataTableSource {
  final BuildContext context;
  final ShowtimeProvider provider;

  ShowtimeDataSource({required this.context, required this.provider});

  Future<void> update(ShowTime newShowtime) async {
    await provider
        .updateShowtime(newShowtime)
        .then((response) async => {
              if (response.success)
                {
                  PopupUtil.showSuccess(
                    context: context,
                    width: SizeConfig.screenWidth * 0.6 * 0.6,
                    message: 'Cập nhật lịch chiếu thành công',
                    onPress: () {
                      Navigator.of(context).pop();
                    },
                  ),
                }
              else
                {
                  PopupUtil.showError(
                    context: context,
                    width: SizeConfig.screenWidth * 0.6 * 0.6,
                    message: response.message,
                  ),
                }
            })
        .catchError((error) {
      PopupUtil.showError(
        context: context,
        width: SizeConfig.screenWidth * 0.6 * 0.6,
        message: error is BadRequestException ? error.message : 'Lỗi không xác định',
      );
    });
  }

  Future<void> delete(int id) async {
    await provider
        .deleteShowtime(id)
        .then((response) async => {
              if (response.success)
                {
                  PopupUtil.showSuccess(
                    context: context,
                    width: SizeConfig.screenWidth * 0.6 * 0.6,
                    message: 'Xoá lịch chiếu thành công',
                    onPress: () {
                      Navigator.of(context).pop();
                    },
                  ),
                }
              else
                {
                  PopupUtil.showError(
                    context: context,
                    width: SizeConfig.screenWidth * 0.6 * 0.6,
                    message: response.message,
                  ),
                }
            })
        .catchError((error) {
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
    final ShowTime showtime = provider.showTimes[index];
    return DataRow2.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Center(child: Text(showtime.movie!.name))),
        DataCell(Center(child: Text(showtime.room!.branch.name))),
        DataCell(Center(child: Text(showtime.room!.name))),
        DataCell(Center(child: Text(showtime.price.toString()))),
        DataCell(Center(child: Text(showtime.room!.type.value))),
        DataCell(Center(child: Text(showtime.movieFormat.value))),
        DataCell(Center(child: Text(DateFormat("dd-MM-yyyy HH:mm").format(showtime.startTime!)))),
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
                          title: const Text('Chỉnh sửa lịch chiếu'),
                          content: Container(
                            width: SizeConfig.screenWidth * 0.6,
                            padding: const EdgeInsets.all(8),
                            child: ShowtimeForm(
                              formKey: formKey,
                              showtime: showtime,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Hủy'),
                            ),
                            TextButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  await update(showtime);
                                }
                              },
                              child: const Text('Lưu'),
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
                          title: const Text('Xoá phim'),
                          content: const Text('Bạn có chắc chắn muốn xoá?'),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('Hủy'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              child: Text('Xoá'),
                              onPressed: () async {
                                await delete(showtime.id);
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
  int get rowCount => provider.showTimes.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
