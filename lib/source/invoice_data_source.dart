import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/invoice.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/invoice_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/string_util.dart';

class InvoiceDataTableSource extends DataTableSource {
  final BuildContext context;
  final InvoiceProvider provider;

  InvoiceDataTableSource({required this.context, required this.provider});

  @override
  DataRow2 getRow(int index) {
    assert(index >= 0);
    final Invoice invoice = provider.invoices[index];
    return DataRow2.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Center(child: Text(invoice.id.toString()))),
        DataCell(Center(child: Text(invoice.code))),
        DataCell(Center(child: Text(invoice.name))),
        DataCell(Center(child: Text(invoice.email))),
        DataCell(Center(child: Text(invoice.appUser != null ? 'Có' : 'Không'))),
        DataCell(Center(child: Text(invoice.totalPrice.toString()))),
        DataCell(Center(child: Text(StringUtil.changePaymentStatus(invoice.paymentStatus).toUpperCase()))),
        DataCell(
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.remove_red_eye_rounded,
                    color: Colors.blue,
                  ),
                  tooltip: 'Xem chi tiết',
                  onPressed: () {
                    if (Responsive.isDesktop(context)) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Thông tin hoá đơn'),
                          content: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              width: SizeConfig.screenWidth * 0.5,
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 18
                              ),
                              child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                direction: Axis.horizontal,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Container(
                                    width: SizeConfig.screenWidth * 0.5 * 0.45,
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Mã hoá đơn: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(invoice.code),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.5 * 0.45,
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Họ tên khách hàng: ',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(invoice.name),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.5 * 0.45,
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Thành tiền: ',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("${NumberFormat.currency(locale: 'vi').format(invoice.totalPrice)}"),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.5 * 0.45,
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Trạng thái: ',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(StringUtil.changePaymentStatus(invoice.paymentStatus).toUpperCase()),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.5 * 0.45,
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Email: ',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(invoice.email),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.5 * 0.45,
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Phương thức thanh toán: ',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(invoice.paymentMethod.value),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.5 * 0.45,
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Ngày thanh toán: ',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(DateFormat('dd/MM/yyyy HH:mm:ss').format(invoice.paymentDate)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.5 * 0.45,
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Liên kết tài khoản: ',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(invoice.appUser != null ? 'Có' : 'Không'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.5,
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Chi tiết vé',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.5 * 0.45,
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Phim: ',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(invoice.showTime.movie!.name),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.5 * 0.45,
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Thể loại chiếu: ',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(StringUtil.changeMovieFormat(invoice.showTime.movieFormat)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.5 * 0.45,
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Chi nhánh: ',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(invoice.showTime.room!.branch.name),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.5 * 0.45,
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Phòng: ',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(invoice.showTime.room!.name),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.5 * 0.45,
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Loại: ',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(invoice.showTime.room!.type.value),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.5 * 0.45,
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Thời gian chiếu: ',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(DateFormat('dd/MM/yyyy HH:mm:ss').format(invoice.showTime.startTime!)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.5,
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Danh sách vé đã mua',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    width: SizeConfig.screenWidth * 0.5,
                                    child: Table(
                                      border: TableBorder.all(color: Colors.black),
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              'Ghế ngồi',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              'Giá vé',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              'Loại ghế',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                            ),
                                          ),
                                        ]),
                                        ...invoice.tickets.map((ticket) {
                                          return TableRow(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                child: Text(
                                                  ticket.seat.code,
                                                  style: const TextStyle(fontSize: 16),
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                child: Text(
                                                  NumberFormat.currency(locale: 'vi').format(invoice.showTime.price),
                                                  style: const TextStyle(fontSize: 16),
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                child: Text(
                                                  StringUtil.changeSeatType(ticket.seat.seatType),
                                                  style: const TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.5,
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Danh sách combo đã mua',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    width: SizeConfig.screenWidth * 0.5,
                                    child: Table(
                                      border: TableBorder.all(color: Colors.black),
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              'Combo',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              'Số lượng',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              'Tổng giá',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                            ),
                                          ),
                                        ]),
                                        ...invoice.invoiceCombos.map((invoiceCombo) {
                                          return TableRow(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                child: Text(
                                                  invoiceCombo.combo!.name,
                                                  style: const TextStyle(fontSize: 16),
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                child: Text(
                                                  invoiceCombo.quantity.toString(),
                                                  style: const TextStyle(fontSize: 16),
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                child: Text(
                                                  NumberFormat.currency(locale: 'vi').format(invoiceCombo.quantity * invoiceCombo.combo!.price),
                                                  style: const TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => provider.invoices.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
