import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/config/responsive.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/genre.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/genre_provider.dart';

class GenreDataTableSource extends DataTableSource {
  GenreDataTableSource({required this.context, required this.provider});

  final BuildContext context;
  final GenreProvider provider;

  @override
  DataRow2 getRow(int index) {
    assert(index >= 0);
    final Genre genre = provider.genres[index];
    return DataRow2.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(genre.id as String)),
        DataCell(Text(genre.name)),
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
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  initialValue: genre.name,
                                  decoration: const InputDecoration(
                                    labelText: 'Tên thể loại',
                                  ),
                                  onSaved: (value) {
                                    genre.name = value!;
                                  },
                                ),
                              ],
                            ),
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
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                provider.updateGenre(genre).then((value) async => {
                                      Navigator.of(context).pop(),
                                    });
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
                        title: const Text('Xoá thể loại'),
                        content: const Text('Bạn có chắc chắn muốn xoá?'),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text('Hủy'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          ElevatedButton(
                            child: const Text('Xoá'),
                            onPressed: () {
                              provider.deleteGenre(genre.id).then((value) async => {
                                    Navigator.of(context).pop(),
                                  });
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
  int get rowCount => provider.genres.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
