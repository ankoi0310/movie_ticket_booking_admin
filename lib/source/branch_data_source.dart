import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/branch/component/branch_form.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/exception/bad_request_exception.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/popup_util.dart';

class BranchDataTableSource extends DataTableSource {
  BranchDataTableSource({required this.context, required this.provider});

  final BuildContext context;
  final BranchProvider provider;

  Future<void> update(Branch newBranch) async {
    await provider.updateBranch(newBranch).then((response) async => {
      if(response.success) {
        PopupUtil.showSuccess(
          context: context,
          width: SizeConfig.screenWidth * 0.6 * 0.6,
          message: 'Cập nhật chi nhánh thành công',
          onPress: () {
            Navigator.of(context).pop();
          },
        ),
      } else {
        PopupUtil.showError(
          context: context,
          width: SizeConfig.screenWidth * 0.6 * 0.6,
          message: response.message,
        ),
      }
    }).catchError((error) {
      PopupUtil.showError(
        context: context,
        width: SizeConfig.screenWidth * 0.6 * 0.6,
        message: error is BadRequestException ? error.message : 'Lỗi không xác định',
      );
    });

  }
  Future<void> delete(int id) async {
    await provider.deleteBranch(id).then((response) async => {
      if(response.success) {
        PopupUtil.showSuccess(
          context: context,
          width: SizeConfig.screenWidth * 0.6 * 0.6,
          message: 'Xoá chi nhánh thành công',
          onPress: () {
            Navigator.of(context).pop();
          },
        ),
      } else {
        PopupUtil.showError(
          context: context,
          width: SizeConfig.screenWidth * 0.6 * 0.6,
          message: response.message,
        ),
      }
    }).catchError((error) {
      PopupUtil.showError(
        context: context,
        width: SizeConfig.screenWidth * 0.6 * 0.6,
        message: error is BadRequestException ? error.message : 'Lỗi không xác định',
      );
    });

  }

  @override
  DataRow2 getRow(int index) {
    assert(index >= 0);
    final Branch branch = provider.branches[index];
    return DataRow2.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Center(child: Text(branch.id.toString()))),
        DataCell(Center(child: Text(branch.name))),
        DataCell(Center(child: Text(branch.address))),
        DataCell(Center(child: Text(branch.branchStatus.value))),
        DataCell(
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.edit),
                  tooltip: 'Nhấn để chỉnh sửa',
                  onPressed: () {
                    if (Responsive.isDesktop(context)) {
                      final formKey = GlobalKey<FormState>();
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Chỉnh sửa chi nhánh'),
                          content: Container(
                            padding: const EdgeInsets.all(8),
                            child: BranchForm(
                              formKey: formKey,
                              branch: branch,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Hủy'),
                            ),
                            TextButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  await update(branch);
                                }
                              },
                              child: const Text('Lưu'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: 'Nhấn để xóa',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Xoá thể loại'),
                          content: const Text('Bạn có chắc chắn muốn xoá?'),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('Hủy'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              child: const Text('Xoá'),
                              onPressed: () async {
                                await delete(branch.id);
                              },
                            ),
                          ],
                        );
                      },
                    );
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
  int get rowCount => provider.branches.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
