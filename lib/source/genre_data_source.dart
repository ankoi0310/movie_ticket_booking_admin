import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/exception/bad_request_exception.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/genre/component/genre_form.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/popup_util.dart';

class GenreDataTableSource extends DataTableSource {
  GenreDataTableSource({required this.context, required this.provider});

  final BuildContext context;
  final GenreProvider provider;

  Future<void> update(Genre newGenre) async {
    await provider
        .updateGenre(newGenre)
        .then((response) async => {
              if (response.success)
                {
                  PopupUtil.showSuccess(
                    context: context,
                    width: SizeConfig.screenWidth * 0.6 * 0.6,
                    message: 'Cập nhật thể loại thành công',
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
        .deleteGenre(id)
        .then((response) async => {
              if (response.success)
                {
                  PopupUtil.showSuccess(
                    context: context,
                    width: SizeConfig.screenWidth * 0.6 * 0.6,
                    message: 'Xoá thể loại thành công',
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
    final Genre genre = provider.genres[index];
    return DataRow2.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Center(child: Text(genre.id.toString()))),
        DataCell(Center(child: Text(genre.name))),
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
                            child: GenreForm(
                              formKey: formKey,
                              genre: genre,
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
                                  await update(genre);
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
                                await delete(genre.id);
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
  int get rowCount => provider.genres.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
