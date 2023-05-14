import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/show_time/show_time_search.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/show_time.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/component/loading_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/showtime/components/show_time_form.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/source/showtime_data_source.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/popup_util.dart';

class ShowtimeScreen extends StatefulWidget {
  static const routeName = '/showtime';

  const ShowtimeScreen({Key? key}) : super(key: key);

  @override
  State<ShowtimeScreen> createState() => _ShowtimeScreenState();
}

class _ShowtimeScreenState extends State<ShowtimeScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final showtimeProvider = Provider.of<ShowtimeProvider>(context);
    final loadingProvider = Provider.of<LoadingProvider>(context);
    late ShowTime showtime = ShowTime.empty();

    int currentPageIndex =0;

    Future<HttpResponse> createShowtime(ShowTime newShowTime) async {
      setState(() {
        loadingProvider.setLoading(true);
      });
      HttpResponse response = await showtimeProvider.createShowtime(newShowTime);

      if (response.success) {
        setState(() {
          loadingProvider.setLoading(false);
        });
        PopupUtil.showSuccess(
            context: context,
            message: 'Thêm lịch chiếu thành công',
            width: SizeConfig.screenWidth * 0.6 * 0.6,
            onPress: () {
              setState(() {
                showtime = ShowTime.empty();
              });
              Navigator.of(context).pop();
            });
      } else {
        setState(() {
          loadingProvider.setLoading(false);
        });
        PopupUtil.showError(
            context: context,
            message: response.message,
            width: SizeConfig.screenWidth * 0.6 * 0.6,
        );
      }

      return response;
    }

    return FutureBuilder(
      future: showtimeProvider.getAllShowTime(ShowTimeSearch.empty()),
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
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Thêm lịch chiếu'),
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
                              child: const Text('Hủy'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            TextButton(
                              child: const Text('Thêm'),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  await createShowtime(showtime);
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
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
                  source: ShowtimeDataSource(context: context, provider: showtimeProvider),
                  columns: const [
                    DataColumn2(
                      label: Center(child: Text('Tên phim')),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                      label: Center(child: Text('Chi nhánh')),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Center(child: Text('Phòng')),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Center(child: Text('Giá vé')),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(
                      label: Center(child: Text('Loại phòng')),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(
                      label: Center(child: Text('Thể loại chiếu')),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Center(child: Text('Suất chiếu')),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Center(child: Text('')),
                      size: ColumnSize.S,
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
