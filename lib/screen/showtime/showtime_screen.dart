import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/showtime/component/showtime_form.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/source/showtime_data_source.dart';

class ShowtimeScreen extends StatefulWidget {
  const ShowtimeScreen({Key? key}) : super(key: key);

  @override
  State<ShowtimeScreen> createState() => _ShowtimeScreenState();
}

class _ShowtimeScreenState extends State<ShowtimeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final showtimeProvider = Provider.of<ShowtimeProvider>(context);

    return FutureBuilder(
      future: showtimeProvider.getShowtimes(),
      builder: (context, snapshot) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  ElevatedButton(
                    child: const Text('Thêm lịch chiếu'),
                    onPressed: () {
                      Showtime newShowtime = Showtime.empty();
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Thêm lịch chiếu'),
                          content: Container(
                            padding: const EdgeInsets.all(8),
                            child: ShowtimeForm(
                              formKey: _formKey,
                              showtime: newShowtime,
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
                                  showtimeProvider.createShowtime(newShowtime).then((value) => Navigator.of(context).pop());
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
                source: ShowtimeDataTableSource(context: context, provider: showtimeProvider),
                columns: const [
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
