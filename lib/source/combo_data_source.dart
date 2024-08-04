import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/component/loading.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/combo_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/component/loading_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/combo/component/combo_form.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/service/firebase_storage_service.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/popup_util.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/string_util.dart';

class ComboDataSource extends DataTableSource {
  final BuildContext context;
  final ComboProvider provider;
  final loadingProvider;

  ComboDataSource({required this.context, required this.provider}) : loadingProvider = Provider.of<LoadingProvider>(context);

  final firebaseStorageService = FirebaseStorageService();

  Uint8List? image;

  void submitImage(Uint8List? imageHBytes) {
    image = imageHBytes;
  }

  Future<void> updateCombo(Combo newCombo) async {
    loadingProvider.setLoading(true);
    newCombo.image = '/images/${StringUtil.convert(newCombo.name)}.jpg';

    HttpResponse response = await provider.updateCombo(newCombo);

    if (response.success) {
      await firebaseStorageService.uploadImage(newCombo.image, image!);

      loadingProvider.setLoading(false);

      PopupUtil.showSuccess(
        context: context,
        message: 'Cập nhật sản phẩm thành công',
        width: SizeConfig.screenWidth * 0.6 * 0.6,
        onPress: () {
          Navigator.of(context).pop();
        },
      );
    } else {
      loadingProvider.setLoading(false);
      PopupUtil.showError(
        context: context,
        message: response.message,
        width: SizeConfig.screenWidth * 0.6 * 0.6,
      );
    }
  }

  @override
  DataRow2 getRow(int index) {
    assert(index >= 0);
    final Combo combo = provider.combos[index];
    return DataRow2.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Center(child: Text(combo.id.toString()))),
        DataCell(Center(child: Text(combo.name))),
        DataCell(Center(child: Text(combo.price.toString()))),
        DataCell(Center(child: Text(combo.comboItems.map((e) => "${e.quantity}x${e.product!.name}").join(', ').toString()))),
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
                        builder: (context) => Consumer<LoadingProvider>(
                          builder: (context, loadingProvider, child) {
                            return Stack(
                              children: [
                                AlertDialog(
                                  title: const Text('Chỉnh sửa phim'),
                                  content: Container(
                                    padding: const EdgeInsets.all(8),
                                    width: SizeConfig.screenWidth * 0.4,
                                    child: SingleChildScrollView(
                                      child: ComboForm(
                                        formKey: formKey,
                                        combo: combo,
                                        submitImage: submitImage,
                                      ),
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
                                          await updateCombo(combo);
                                          //  provider.updateCombo(combo).then((value) async => {
                                          //        Navigator.of(context).pop(),
                                          //      });
                                        }
                                      },
                                      child: const Text('Lưu'),
                                    ),
                                  ],
                                ),
                                loadingProvider.loading ? const Loading(): Container(),
                              ],
                            );
                          }
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
                          title: const Text('Xoá phim'),
                          content: const Text('Bạn có chắc chắn muốn xoá?'),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('Hủy'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              child: Text('Xoá'),
                              onPressed: () {
                                provider.deleteCombo(combo.id).then((value) async => {
                                      Navigator.of(context).pop(),
                                    });
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
  int get rowCount => provider.combos.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
