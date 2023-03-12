import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/genre/component/add_genre_form.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/source/genre_data_source.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({Key? key}) : super(key: key);

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final genreProvider = Provider.of<GenreProvider>(context);

    return FutureBuilder(
      future: genreProvider.getGenres(),
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
                      if (Responsive.isDesktop(context)) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Thêm thể loại'),
                            content: Container(
                              padding: const EdgeInsets.all(8),
                              child: AddGenreForm(
                                formKey: _formKey,
                                nameController: _nameController,
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('Hủy'),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              TextButton(
                                child: const Text('Thêm'),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    genreProvider.createGenre(name: _nameController.text).then((value) => Navigator.of(context).pop());
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      }
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
