import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/invoice_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/source/invoice_data_source.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final invoiceProvider = Provider.of<InvoiceProvider>(context);
    SizeConfig().init(context);
    return FutureBuilder(
      future: invoiceProvider.getInvoices(),
      builder: (context, snapshot) {
        return Column(
          children: [
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
                  source: InvoiceDataTableSource(context: context, provider: invoiceProvider),
                  columns: const [
                    DataColumn2(
                        label: Center(child: Text('ID')),
                        size: ColumnSize.S,
                        fixedWidth: 80
                    ),
                    DataColumn2(
                        label: Center(child: Text('Mã')),
                        size: ColumnSize.S,
                        fixedWidth: 200
                    ),
                    DataColumn2(
                        label: Center(child: Text('Tên khách hàng')),
                        size: ColumnSize.S,
                        fixedWidth: 150
                    ),
                    DataColumn2(
                      label: Center(child: Text('Email')),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                        label: Center(child: Text('Tài khoản')),
                        size: ColumnSize.L,
                        fixedWidth: 100
                    ),
                    DataColumn2(
                        label: Center(child: Text('Tổng tiền')),
                        size: ColumnSize.L,
                        fixedWidth: 150
                    ),
                    DataColumn2(
                        label: Center(child: Text('Trạng thái')),
                        size: ColumnSize.L,
                        fixedWidth: 180
                    ),
                    DataColumn2(
                        label: Center(child: Text('')),
                        size: ColumnSize.S,
                        fixedWidth: 140
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
