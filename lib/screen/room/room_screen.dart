import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/room/room_search.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/component/loading_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/exception/bad_request_exception.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/room/component/room_form.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/source/room_data_source.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/popup_util.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final _formKey = GlobalKey<FormState>();
  int currentPageIndex = 0;
  late Room room = Room.empty();

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context);
    final loadingProvider = Provider.of<LoadingProvider>(context);

    Future<void> createRoom(Room newRoom) async {
      setState(() {
        loadingProvider.setLoading(true);
      });
      await roomProvider.createRoom(newRoom).then((value) {
        setState(() {
          loadingProvider.setLoading(false);
        });
        PopupUtil.showSuccess(
          context: context,
          width: SizeConfig.screenWidth * 0.6 * 0.6,
          message: 'Thêm phòng thành công',
          onPress: () {
            room = Room.empty();
            Navigator.of(context).pop();
          },
        );
      }).catchError((error) {
        setState(() {
          loadingProvider.setLoading(false);
        });
        PopupUtil.showError(
          context: context,
          width: SizeConfig.screenWidth * 0.6 * 0.6,
          message: error is BadRequestException ? error.message : 'Lỗi không xác định',
        );
      });
    }

    return FutureBuilder(
      future: roomProvider.getRooms(RoomSearch.empty()),
      builder: (context, snapshot) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  ElevatedButton(
                    child: const Text('Thêm phòng'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Thêm phòng'),
                          content: Container(
                            padding: const EdgeInsets.all(8),
                            width: SizeConfig.screenWidth * 0.7,
                            child: RoomForm(
                              formKey: _formKey,
                              room: room,
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
                                  print(room.laneCols);
                                  print(room.laneRows);
                                  _formKey.currentState!.save();
                                  await createRoom(room);
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
                  source: RoomDataTableSource(context: context, provider: roomProvider),
                  columns: const [
                    DataColumn2(
                      label: Center(child: Text('ID')),
                      size: ColumnSize.S,
                      numeric: true,
                    ),
                    DataColumn2(
                      label: Center(child: Text('Chi nhánh')),
                      size: ColumnSize.S,
                      fixedWidth: 200,
                    ),
                    DataColumn2(
                      label: Center(child: Text('Tên phòng')),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                      label: Center(child: Text('Số ghế')),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Center(child: Text('Số hàng')),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Center(child: Text('Số cột')),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Center(child: Text('Trạng thái')),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Center(child: Text('Loại')),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Center(child: Text('')),
                      size: ColumnSize.M,
                      fixedWidth: 120,
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
