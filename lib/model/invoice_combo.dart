import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/combo.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/general.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/invoice.dart';

class InvoiceCombo extends General {
  Combo? combo;
  Invoice? invoice;
  int quantity;

  InvoiceCombo({
    required int id,
    required this.combo,
    required this.invoice,
    required this.quantity,
    required GeneralState state,
    required DateTime createdDate,
    required DateTime modifiedDate,
    required DateTime? deletedDate,
  }) : super(id: id, state: state, createdDate: createdDate, modifiedDate: modifiedDate, deletedDate: deletedDate);

  @override
  bool operator ==(other) {
    return (other is InvoiceCombo) && other.combo!.id == combo!.id;
  }

  @override
  int get hashCode => id.hashCode;

  InvoiceCombo.empty()
      : combo = Combo.empty(),
        invoice = Invoice.empty(),
        quantity = 0,
        super.empty();

  InvoiceCombo.initial({required this.combo,required this.invoice, required this.quantity})
      : super.empty();

  factory InvoiceCombo.fromJson(Map<String, dynamic> json) {
    return InvoiceCombo(
      id: json['id'],
      combo: json['combo'] != null ? Combo.fromJson(json['combo']) : null,
      invoice: json['invoice'] != null ? Invoice.fromJson(json['invoice']) : null,
      quantity: json['quantity'],
      state: GeneralState.fromValue(json['state']),
      createdDate: DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['createdDate']),
      modifiedDate: DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['modifiedDate']),
      deletedDate: json['deletedDate'] != null ? DateTime.parse(json['deletedDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'combo': combo != null ? combo!.toJson() : null,
      'invoice': invoice,
      'quantity': quantity,
      'state': state.value,
      'createdDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(createdDate),
      'modifiedDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(modifiedDate),
      'deletedDate': deletedDate != null ? DateFormat('dd-MM-yyyy HH:mm:ss').format(deletedDate!) : null,
    };
  }
}
