import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class AddTicketForm extends StatelessWidget {
  const AddTicketForm({
    super.key,
    required this.formKey,
    required this.ticket,
  });

  final GlobalKey<FormState> formKey;
  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [],
      ),
    );
  }
}
