import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/component/loading.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/component/loading_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/exception/bad_request_exception.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/movie/component/movie_form.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/popup_util.dart';

class MovieDataTableSource extends DataTableSource {
  final BuildContext context;
  final MovieProvider provider;
  final LoadingProvider loadingProvider;
  MovieDataTableSource({required this.context, required this.provider}): loadingProvider = Provider.of<LoadingProvider>(context);

  Uint8List? imageVerticalBytes;
  Uint8List? imageHorizontalBytes;

  Uint8List? dataVerticalBytes;
  Uint8List? dataHorizontalBytes;

  void submitImageVertical(Uint8List? imageVBytes) {
    imageVerticalBytes = imageVBytes;
  }

  void submitImageHorizontal(Uint8List? imageHBytes) {
    imageHorizontalBytes = imageHBytes;
  }
  Future<void> updateMovie(Movie newMovie, BuildContext context) async {
      loadingProvider.setLoading(true);
    await provider
        .updateMovie(newMovie, imageVerticalBytes!, imageHorizontalBytes!)
        .then((value) async {
        loadingProvider.setLoading(false);
      PopupUtil.showSuccess(
          context: context,
          message: 'Cập nhật phim thành công',
          width: SizeConfig.screenWidth * 0.6 * 0.6,
          onPress: () {
            Navigator.of(context).pop();
          });
    }).catchError((error) {
        loadingProvider.setLoading(false);

      PopupUtil.showError(
        context: context,
        message: error is BadRequestException
            ? error.message
            : 'Lỗi không xác định',
        width: SizeConfig.screenWidth * 0.6 * 0.6,
      );
    });
  }


  @override
  DataRow2 getRow(int index) {
    assert(index >= 0);
    final Movie movie = provider.movies[index];
    return DataRow2.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Center(child: Text(movie.id.toString()))),
        DataCell(Center(child: Text(movie.name))),
        DataCell(Center(child: Text(movie.genres.map((e) => e.name).join(', ').toString()))),
        DataCell(Center(child: Text(movie.rating.toString()))),
        DataCell(Center(child: Text(movie.duration.toString()))),
        DataCell(Center(child: Text(movie.director))),
        DataCell(Center(child: Text(movie.producer))),
        DataCell(Center(child: Text(movie.language))),
        DataCell(Center(child: Text(movie.subtitle))),
        DataCell(Center(child: Text(movie.country))),
        DataCell(Center(child: Text(movie.movieState.value))),
        DataCell(Center(child: Text(DateFormat('dd/MM/yyyy').format(movie.releaseDate)))),
        // DataCell(
        //   Center(
        //     child: ReadMoreText(
        //       movie.storyLine,
        //       trimLines: 2,
        //       colorClickableText: Colors.blue,
        //       trimMode: TrimMode.Line,
        //       trimCollapsedText: 'Xem thêm',
        //       trimExpandedText: 'Thu gọn',
        //       moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // ),
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
                        builder: (context) => Consumer<LoadingProvider>(
                          builder: (context, loadingProvider, child) {
                            return Stack(
                              children: [
                                AlertDialog(
                                  title: const Text('Chỉnh sửa phim'),
                                  content: Container(
                                    padding: const EdgeInsets.all(8),
                                    width: SizeConfig.screenWidth * 0.6,
                                    child: SingleChildScrollView(
                                      child: MovieForm(
                                        formKey: formKey,
                                        movie: movie,
                                        submitImageHorizontal: submitImageHorizontal,
                                        submitImageVertical: submitImageVertical,
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
                                      onPressed: () async{
                                        if (formKey.currentState!.validate()) {
                                          formKey.currentState!.save();
                                          await updateMovie(movie, context);
                                        }
                                      },
                                      child: const Text('Lưu'),
                                    ),
                                  ],
                                ),
                                loadingProvider.loading ? const Loading() : Container(),
                              ],
                            );
                          }
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
                                provider.deleteMovie(movie.id).then((value) async => {
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
