import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/room/component/add_room_form.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/source/room_data_source.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  int currentPageIndex = 0;
  Room newRoom = Room.empty();

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context);

    return FutureBuilder(
      future: roomProvider.getRooms(),
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
                      if (Responsive.isDesktop(context)) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Thêm phòng'),
                            content: Container(
                              padding: const EdgeInsets.all(8),
                              width: SizeConfig.screenWidth * 0.7,
                              child: AddRoomForm(
                                formKey: _formKey,
                                entity: newRoom,
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
                                    newRoom.name = _nameController.text;
                                    roomProvider.createRoom(newRoom).then((value) => Navigator.of(context).pop());
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
                source: RoomDataTableSource(context: context, provider: roomProvider),
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
