import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/room.dart';

class UpdateRoomForm extends StatelessWidget {
  const UpdateRoomForm({
    super.key,
    required this.formKey,
    required this.room,
  });

  final GlobalKey<FormState> formKey;
  final Room room;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: room.name,
            decoration: const InputDecoration(
              labelText: 'Tên thể loại',
            ),
            onSaved: (value) {
              room.name = value!;
            },
          ),
        ],
      ),
    );
  }
}
