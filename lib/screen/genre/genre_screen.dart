import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/genre/genre_search.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/exception/bad_request_exception.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/genre/component/genre_form.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/source/genre_data_source.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/popup_util.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({Key? key}) : super(key: key);

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int currentPageIndex = 0;
  Genre genre = Genre.empty();

  @override
  Widget build(BuildContext context) {
    final genreProvider = Provider.of<GenreProvider>(context);

    Future<void> createGenre(Genre newGenre) async {
      genreProvider.createGenre(newGenre).then((response) {
        if (response.success) {
          PopupUtil.showSuccess(
            context: context,
            width: SizeConfig.screenWidth * 0.6 * 0.6,
            message: 'Thêm thể loại thành công',
            onPress: () {
              genre = Genre.empty();
              Navigator.of(context).pop();
            },
          );
        } else {
          PopupUtil.showError(
            context: context,
            width: SizeConfig.screenWidth * 0.6 * 0.6,
            message: response.message,
          );
        }
      }).catchError((error) {
        PopupUtil.showError(
          context: context,
          width: SizeConfig.screenWidth * 0.6 * 0.6,
          message: error is BadRequestException ? error.message : 'Lỗi không xác định',
        );
      });
    }

    return FutureBuilder(
      future: genreProvider.getGenres(GenreSearch()),
      builder: (context, snapshot) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  ElevatedButton(
                    child: const Text('Thêm thể loại'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Thêm thể loại'),
                          content: Container(
                            padding: const EdgeInsets.all(8),
                            child: GenreForm(
                              formKey: _formKey,
                              genre: genre,
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: const Text('Hủy'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            TextButton(
                              child: const Text('Thêm'),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  await createGenre(genre);
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              width: SizeConfig.screenWidth,
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
                source: GenreDataTableSource(context: context, provider: genreProvider),
                columns: const [
                  DataColumn2(
                    label: Center(child: Text('ID')),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Center(child: Text('Tên thể loại')),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Center(child: Text('')),
                    size: ColumnSize.S,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
