import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/source/user_data_source.dart';

class UserScreen extends StatefulWidget {

  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    SizeConfig().init(context);
    return  FutureBuilder(
      future: userProvider.getAllUser(),
      builder: (context, snapshot) {

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
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
                  source: UserDataTableSource(context: context, provider: userProvider),
                  columns: const [
                    DataColumn2(
                      label: Center(child: Text('ID')),
                      size: ColumnSize.S,
                      fixedWidth: 80
                    ),
                    DataColumn2(
                      label: Center(child: Text('Email')),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                      label: Center(child: Text('Số điện thoại')),
                      size: ColumnSize.L,
                      fixedWidth: 150
                    ),
                    DataColumn2(
                      label: Center(child: Text('Đã khoá')),
                      size: ColumnSize.L,
                      fixedWidth: 150
                    ),
                    DataColumn2(
                      label: Center(child: Text('Đã kích hoạt')),
                      size: ColumnSize.L,
                        fixedWidth: 150
                    ),
                    DataColumn2(
                      label: Center(child: Text('Quyền')),
                      size: ColumnSize.L,
                      fixedWidth: 150
                    ),
                    DataColumn2(
                      label: Center(child: Text('')),
                      size: ColumnSize.S,
                      fixedWidth: 160
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
