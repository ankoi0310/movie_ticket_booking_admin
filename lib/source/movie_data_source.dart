import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/movie/component/movie_form.dart';

class MovieDataTableSource extends DataTableSource {
  MovieDataTableSource({required this.context, required this.provider});

  final BuildContext context;
  final MovieProvider provider;

  @override
  DataRow2 getRow(int index) {
    assert(index >= 0);
    final Movie movie = provider.movies[index];
    return DataRow2.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(movie.name)),
        DataCell(
          ReadMoreText(
            movie.storyLine,
            trimLines: 2,
            colorClickableText: Colors.blue,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Xem thêm',
            trimExpandedText: 'Thu gọn',
            moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        DataCell(Text(movie.imageVertical)),
        DataCell(Text(movie.genres.map((e) => e.name).join(', ').toString())),
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
                        title: const Text('Chỉnh sửa phim'),
                        content: Container(
                          padding: const EdgeInsets.all(8),
                          child: MovieForm(
                            formKey: formKey,
                            movie: movie,
                            submitImageHorizontal: (image) {},
                            submitImageVertical: (image) {},
                            loading: false,
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
                                provider.updateMovie(movie).then((value) async => {
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
                            onPressed: () {
                              provider.deleteMovie(movie.id!).then((value) async => {
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
  int get rowCount => provider.movies.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
