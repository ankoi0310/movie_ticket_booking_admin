import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class BranchForm extends StatefulWidget {
  const BranchForm({
    super.key,
    required this.formKey,
    required this.branch,
  });

  final GlobalKey<FormState> formKey;
  final Branch branch;

  @override
  State<BranchForm> createState() => _BranchFormState();
}

class _BranchFormState extends State<BranchForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: widget.branch.name,
            decoration: const InputDecoration(labelText: 'Tên chi nhánh'),
            onSaved: (value) {
              widget.branch.name = value!;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            initialValue: widget.branch.address,
            decoration: const InputDecoration(labelText: 'Địa chỉ'),
            onSaved: (value) {
              widget.branch.address = value!;
            },
          ),
          SizedBox(
            height: (20),
          ),

          Text('Trạng thái phim: '),
          SizedBox(
            height: (10),
          ),
          DropdownButton2(
            isExpanded: true,
            value: widget.branch.branchStatus.value,
            onChanged: (value) {
              setState(() {
                widget.branch.branchStatus = BranchStatus.fromValue(value!);
              });
            },
            buttonStyleData: ButtonStyleData(
              padding: EdgeInsets.symmetric(
                horizontal: (20),
              ),
              width: SizeConfig.screenWidth * 0.2,
              height: (40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
            ),
            iconStyleData: IconStyleData(
              icon: Icon(Icons.keyboard_arrow_up_rounded),
              iconSize: (28),
              iconEnabledColor: Colors.black,
              iconDisabledColor: Colors.grey,
              openMenuIcon: Icon(Icons.keyboard_arrow_down_rounded),
            ),
            dropdownStyleData: DropdownStyleData(
              elevation: 1,
              maxHeight: 250,
              width: SizeConfig.screenWidth * 0.2,
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(10),
                thickness: MaterialStateProperty.all(5),
                thumbColor: MaterialStateProperty.all(Colors.grey),
                trackColor: MaterialStateProperty.all(Colors.grey),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            menuItemStyleData: MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.symmetric(
                horizontal: 28,
              ),
            ),
            underline: Container(),
            items: BranchStatus.values
                .map((e) => DropdownMenuItem(
                      value: e.value,
                      child: Text(e.value),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
