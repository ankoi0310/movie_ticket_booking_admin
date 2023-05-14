import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/auth/app_user.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/general.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/invoice_combo.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/show_time.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/ticket.dart';

enum PaymentMethod {
  momo("MOMO"),
  vnPay("VNPAY");

  final String value;

  const PaymentMethod(this.value);

  factory PaymentMethod.fromValue(String value) {
    return PaymentMethod.values.firstWhere((e) => e.value == value);
  }
}

enum PaymentStatus {
  pending("PENDING"),
  success("SUCCESS"),
  failed("FAILED");

  final String value;

  const PaymentStatus(this.value);

  factory PaymentStatus.fromValue(String value) {
    return PaymentStatus.values.firstWhere((e) => e.value == value);
  }
}

class Invoice extends General {
  String code;
  String name;
  String email;
  int totalPrice;
  AppUser? appUser;
  ShowTime showTime;
  PaymentMethod paymentMethod;
  PaymentStatus paymentStatus;
  DateTime paymentDate;
  List<Ticket> tickets;
  List<InvoiceCombo> invoiceCombos;

  Invoice({
    required int id,
    required this.code,
    required this.name,
    required this.email,
    required this.totalPrice,
    required this.appUser,
    required this.showTime,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.paymentDate,
    required this.tickets,
    required this.invoiceCombos,
    required GeneralState state,
    required DateTime createdDate,
    required DateTime modifiedDate,
    required DateTime? deletedDate,
  }) : super(id: id, state: state, createdDate: createdDate, modifiedDate: modifiedDate, deletedDate: deletedDate);

  Invoice.empty()
      : code = '',
        name = '',
        email = '',
        totalPrice = 0,
        appUser = AppUser.empty(),
        showTime = ShowTime.empty(),
        paymentMethod = PaymentMethod.momo,
        paymentStatus = PaymentStatus.pending,
        paymentDate = DateTime.now(),
        tickets = [],
        invoiceCombos = [],
        super.empty();

  @override
  bool operator ==(other) {
    return (other is Invoice) && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      email: json['email'],
      totalPrice: json['totalPrice'],
      appUser: json['appUser'] != null ? AppUser.fromJson(json['appUser']) : AppUser.empty(),
      showTime: json['showTime'] != null ? ShowTime.fromJson(json['showTime']) : ShowTime.empty(),
      paymentMethod: PaymentMethod.fromValue(json['paymentMethod']),
      paymentStatus: PaymentStatus.fromValue(json['paymentStatus']),
      paymentDate: json['paymentDate'] != null ? DateFormat("dd-MM-yyyy").parse(json['paymentDate']) : DateTime.now(),
      tickets: json['tickets'] != null ? (json['tickets'] as List).map((e) => Ticket.fromJson(e)).toList() : [],
      invoiceCombos: json['invoiceCombos'] != null ? (json['invoiceCombos'] as List).map((e) => InvoiceCombo.fromJson(e)).toList() : [],
      state: json['state'] != null ? GeneralState.values.firstWhere((e) => e.value == json['state']) : GeneralState.active,
      createdDate: json['createdDate'] != null ? DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['createdDate']) : DateTime.now(),
      modifiedDate: json['modifiedDate'] != null ? DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['modifiedDate']) : DateTime.now(),
      deletedDate: json['deletedDate'] != null ? DateTime.parse(json['deletedDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'email': email,
      'totalPrice': totalPrice,
      'appUser': appUser!.toJson(),
      'showTime': showTime.toJson(),
      'paymentMethod': paymentMethod.value,
      'paymentStatus': paymentStatus.value,
      'paymentDate':  DateFormat('dd-MM-yyyy HH:mm:ss').format(paymentDate),
      'tickets': tickets.map((e) => e.toJson()).toList(),
      'invoiceCombos': invoiceCombos.map((e) => e.toJson()).toList(),
      'state': state.value,
      'createdDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(createdDate),
      'modifiedDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(modifiedDate),
      'deletedDate': deletedDate != null ? DateFormat('dd-MM-yyyy HH:mm:ss').format(deletedDate!) : null,
    };
  }
}
