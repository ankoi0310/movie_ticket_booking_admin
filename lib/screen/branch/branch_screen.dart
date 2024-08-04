import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/branch/branch_search.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/branch/component/branch_form.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/exception/bad_request_exception.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/source/branch_data_source.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/popup_util.dart';

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
    Branch branch = Branch.empty();

    Future<void> createBranch(Branch newBranch) async {
      branchProvider.createBranch(newBranch).then((response) {
        if(response.success) {
          PopupUtil.showSuccess(
            context: context,
            width: SizeConfig.screenWidth * 0.6 * 0.6,
            message: 'Thêm chi nhánh thành công',
            onPress: () {
              branch = Branch.empty();
              Navigator.of(context).pop();
            },
          );
        } else {
          PopupUtil.showError(
            context: context,
            width: SizeConfig.screenWidth * 0.6 * 0.6,
            message: response.message,
          );
        }
      }).catchError((error) {
        PopupUtil.showError(
          context: context,
          width: SizeConfig.screenWidth * 0.6 * 0.6,
          message: error is BadRequestException ? error.message : 'Lỗi không xác định',
        );
      });
    }

    return FutureBuilder(
      future: branchProvider.getBranches(BranchSearch()),
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

                      showDialog(
                        context: context,
                        builder: (context) =>
                            AlertDialog(
                              title: const Text('Thêm chi nhánh'),
                              content: Container(
                                padding: const EdgeInsets.all(8),
                                width: SizeConfig.screenWidth * 0.3,
                                child: BranchForm(
                                  formKey: _formKey,
                                  branch: branch,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('Hủy'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                TextButton(
                                  child: const Text('Thêm'),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      await createBranch(branch);
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
                  source: BranchDataTableSource(context: context, provider: branchProvider),
                  columns: const [
                    DataColumn2(
                      label: Center(child: Text('ID')),
                      size: ColumnSize.S,
                      fixedWidth: 60,
                    ),
                    DataColumn2(
                      label: Center(child: Text('Tên chi nhánh')),
                      size: ColumnSize.L,
                      fixedWidth: 250,
                    ),
                    DataColumn2(
                      label: Center(child: Text('Địa chỉ')),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                      label: Center(child: Text('Trạng thái')),
                      size: ColumnSize.S,
                      fixedWidth: 120,
                    ),
                    DataColumn2(
                      label: Center(child: Text('')),
                      size: ColumnSize.S,
                      fixedWidth: 120,
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
