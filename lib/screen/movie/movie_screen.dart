import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/component/loading.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/movie/movie_search.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/component/loading_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/exception/bad_request_exception.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/movie/component/movie_form.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/source/movie_data_source.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/popup_util.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int currentPageIndex = 0;

  late Movie movie = Movie.empty();

  Uint8List? imageVerticalBytes;
  Uint8List? imageHorizontalBytes;

  Uint8List? dataVerticalBytes;
  Uint8List? dataHorizontalBytes;

  bool isCreatingMovie = false;

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    final loadingProvider = Provider.of<LoadingProvider>(context);

    void submitImageVertical(Uint8List? imageVBytes) {
      setState(() {
        imageVerticalBytes = imageVBytes;
      });
    }

    void submitImageHorizontal(Uint8List? imageHBytes) {
      setState(() {
        imageHorizontalBytes = imageHBytes;
      });
    }

    Future<void> createMovie(Movie movie, BuildContext context) async {
      setState(() {
        loadingProvider.setLoading(true);
      });
      await movieProvider
          .createMovie(movie, imageVerticalBytes!, imageHorizontalBytes!)
          .then((value) async {
        setState(() {
          loadingProvider.setLoading(false);
        });
        PopupUtil.showSuccess(
            context: context,
            message: 'Thêm phim thành công',
            width: SizeConfig.screenWidth * 0.6 * 0.6,
            onPress: () {
              setState(() {
                this.movie = Movie.empty();
              });
              Navigator.of(context).pop();
            });
      }).catchError((error) {
        setState(() {
          loadingProvider.setLoading(false);
        });

        PopupUtil.showError(
          context: context,
          message: error is BadRequestException
              ? error.message
              : 'Lỗi không xác định',
          width: SizeConfig.screenWidth * 0.6 * 0.6,
        );
      });
    }

    return FutureBuilder(
      future: movieProvider.getMovies(MovieSearch.empty()),
      builder: (context, snapshot) {
        return Column(
          children: [
            // if (snapshot.connectionState == ConnectionState.waiting)
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  ElevatedButton(
                    child: const Text('Thêm phim'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Consumer<LoadingProvider>(
                          builder: (context, provider, child) => Stack(
                            children: [
                              AlertDialog(
                                title: const Text('Thêm phim'),
                                content: Container(
                                  padding: const EdgeInsets.all(8),
                                  width: SizeConfig.screenWidth * 0.6,
                                  child: SingleChildScrollView(
                                    child: MovieForm(
                                      formKey: _formKey,
                                      movie: movie,
                                      submitImageVertical: submitImageVertical,
                                      submitImageHorizontal:
                                          submitImageHorizontal,
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('Hủy'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                  TextButton(
                                    child: const Text('Thêm'),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState?.save();
                                        await createMovie(movie, context);
                                      }
                                    },
                                  ),
                                ],
                              ),
                              if (provider.loading) const Loading()
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: SizeConfig.screenWidth * 1.6,
                height: SizeConfig.screenHeight * 0.7,
                child: PaginatedDataTable2(
                  empty: const Center(child: Text('Không có dữ liệu')),
                  border: TableBorder.all(color: Colors.grey, width: 1),
                  rowsPerPage: DatatableConfig.defaultRowsPerPage,
                  fit: FlexFit.tight,
                  onPageChanged: (index) {
                    setState(() {
                      currentPageIndex = index;
                    });
                  },
                  source: MovieDataTableSource(
                      context: context, provider: movieProvider),
                  columns: const [
                    DataColumn2(
                      label: Center(child: Text('ID')),
                      size: ColumnSize.S,
                      fixedWidth: 60
                    ),
                    DataColumn2(
                      label: Center(child: Text('Tên phim')),
                      size: ColumnSize.L,
                        fixedWidth: 310
                    ),
                    DataColumn2(
                      label: Center(child: Text('Thể loại')),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                      label: Center(child: Text('Đánh giá')),
                      size: ColumnSize.M,
                        fixedWidth: 150
                    ),
                    DataColumn2(
                      label: Center(child: Text('Thời lượng')),
                      size: ColumnSize.M,
                        fixedWidth: 150
                    ),
                    DataColumn2(
                      label: Center(child: Text('Đạo diễn')),
                      size: ColumnSize.M,
                        fixedWidth: 160
                    ),
                    DataColumn2(
                      label: Center(child: Text('Nhà sản xuất')),
                      size: ColumnSize.M,
                        fixedWidth: 160
                    ),
                    DataColumn2(
                      label: Center(child: Text('Ngôn ngữ')),
                      size: ColumnSize.M,
                        fixedWidth: 160
                    ),
                    DataColumn2(
                      label: Center(child: Text('Phụ đề')),
                      size: ColumnSize.M,
                        fixedWidth: 160
                    ),
                    DataColumn2(
                      label: Center(child: Text('Quốc gia')),
                      size: ColumnSize.M,
                        fixedWidth: 160
                    ),
                    DataColumn2(
                      label: Center(child: Text('Trạng thái')),
                      size: ColumnSize.M,
                        fixedWidth: 180
                    ),
                    DataColumn2(
                      label: Center(child: Text('Ngày phát hành')),
                      size: ColumnSize.L,
                        fixedWidth: 160
                    ),
                    DataColumn2(
                      label: Center(child: Text('')),
                      size: ColumnSize.S,
                        fixedWidth: 110
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
