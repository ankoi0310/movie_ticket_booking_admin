import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/branch/component/branch_form.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/source/branch_data_source.dart';

class BranchScreen extends StatefulWidget {
  const BranchScreen({Key? key}) : super(key: key);

  @override
  State<BranchScreen> createState() => _BranchScreenState();
}

class _BranchScreenState extends State<BranchScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final branchProvider = Provider.of<BranchProvider>(context);

    return FutureBuilder(
      future: branchProvider.getBranches(),
      builder: (context, snapshot) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  ElevatedButton(
                    child: const Text('Thêm chi nhánh'),
                    onPressed: () {
                      Branch newBranch = Branch.empty();
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Thêm chi nhánh'),
                          content: Container(
                            padding: const EdgeInsets.all(8),
                            child: BranchForm(
                              formKey: _formKey,
                              branch: newBranch,
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: const Text('Hủy'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            TextButton(
                              child: const Text('Thêm'),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  branchProvider.createBranch(newBranch).then((value) => Navigator.of(context).pop());
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
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
                source: BranchDataTableSource(context: context, provider: branchProvider),
                columns: const [
                  DataColumn2(
                    label: Center(child: Text('ID')),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Center(child: Text('Tên chi nhánh')),
                    size: ColumnSize.L,
                    fixedWidth: 250,
                  ),
                  DataColumn2(
                    label: Center(child: Text('Địa chỉ')),
                    size: ColumnSize.L,
                    fixedWidth: 350,
                  ),
                  DataColumn2(
                    label: Center(child: Text('')),
                    size: ColumnSize.S,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
