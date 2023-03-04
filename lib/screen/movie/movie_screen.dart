import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/config/size_config.dart';

class MovieScreen extends StatefulWidget {
  static const routeName = '/movie';
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Add'),
              ),
              const SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Edit'),
              ),
              const SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Delete'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.7,
          child: DataTable2(
            columnSpacing: 12,
            horizontalMargin: 12,
            columns: [
              DataColumn2(
                label: Text('Name'),
                size: ColumnSize.L,
              ),
              DataColumn(
                label: Text('Age'),
              ),
              DataColumn(
                label: Text('Role'),
              ),
            ],
            rows: List<DataRow>.generate(
              8,
              (index) => DataRow(
                cells: [
                  DataCell(Text('John')),
                  DataCell(Text('19')),
                  DataCell(Text('Student')),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
