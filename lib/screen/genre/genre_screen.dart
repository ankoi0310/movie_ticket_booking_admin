import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/config/responsive.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/layout/default_layout.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/genre_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/source/genre_data_source.dart';
import 'package:provider/provider.dart';

class GenreScreen extends StatefulWidget {
  static const routeName = '/genre';
  const GenreScreen({Key? key}) : super(key: key);

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final genreProvider = Provider.of<GenreProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    genreProvider.getGenres();
    return FutureBuilder(
        future: genreProvider.getGenres(),
        builder: (context, snapshot) {
          return DefaultLayout(
            title: 'Thể loại',
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (Responsive.isDesktop(context)) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Thêm thể loại'),
                                content: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          controller: _nameController,
                                          decoration: const InputDecoration(
                                            labelText: 'Tên thể loại',
                                          ),
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
                                      if (_formKey.currentState!.validate()) {
                                        genreProvider.createGenre(name: _nameController.text).then((value) => {
                                              // genreProvider.getGenres(),
                                              Navigator.of(context).pop()
                                            });
                                      }
                                    },
                                    child: const Text('Thêm'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: const Text('Thêm thể loại'),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
                SizedBox(
                  width: width,
                  height: height * 0.7,
                  child: PaginatedDataTable2(
                    empty: const Center(child: Text('Không có dữ liệu')),
                    border: TableBorder.all(color: Colors.grey, width: 1),
                    rowsPerPage: _rowsPerPage,
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
            ),
          );
        });
  }
}
