import 'dart:core';

import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/general.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/invoice.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/seat.dart';

enum TicketStatus {
  booked("BOOKED"),
  cancelled("CANCELLED"),
  used("USED");

  final String value;

  const TicketStatus(this.value);

  factory TicketStatus.fromValue(String value) {
    return TicketStatus.values.firstWhere((e) => e.value == value);
  }
}

class Ticket extends General {
  Invoice? invoice;
  Seat seat;

  Ticket({
    required int id,
    required this.invoice,
    required this.seat,
    required GeneralState state,
    required DateTime createdDate,
    required DateTime modifiedDate,
    required DateTime? deletedDate,
  }) : super(
          id: id,
          state: state,
          createdDate: createdDate,
          modifiedDate: modifiedDate,
          deletedDate: deletedDate,
        );

  Ticket.empty()
      : invoice = Invoice.empty(),
        seat = Seat.empty(),
        super.empty();

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      invoice: json['invoice'] != null ? Invoice.fromJson(json['invoice']) : null,
      seat: Seat.fromJson(json['seat']),
      state: GeneralState.fromValue(json['state']),
      createdDate: json['createdDate'] != null ? DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['createdDate']) : DateTime.now(),
      modifiedDate: json['modifiedDate'] != null ? DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['modifiedDate']) : DateTime.now(),
      deletedDate: json['deletedDate'] != null ? DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['deletedDate']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'invoice': invoice != null? invoice!.toJson() : null,
        'seat': seat.toJson(),
        'state': state.value,
        'createdDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(createdDate),
        'modifiedDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(modifiedDate),
        'deletedDate': deletedDate != null ? DateFormat('dd-MM-yyyy HH:mm:ss').format(deletedDate!) : null,
      };
}
