import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/component/loading.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/combo_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/component/loading_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/combo/component/combo_form.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/exception/bad_request_exception.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/service/firebase_storage_service.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/source/combo_data_source.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/popup_util.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/string_util.dart';

class ComboScreen extends StatefulWidget {
  const ComboScreen({Key? key}) : super(key: key);

  @override
  State<ComboScreen> createState() => _ComboScreenState();
}

class _ComboScreenState extends State<ComboScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Combo combo = Combo.empty();

  @override
  Widget build(BuildContext context) {
    final comboProvider = Provider.of<ComboProvider>(context);
    final loadingProvider = Provider.of<LoadingProvider>(context);
    final firebaseStorageService = FirebaseStorageService();

    Uint8List? dataImageBytes;
    int currentPageIndex = 0;

    void submitImage(Uint8List? image) {
      setState(() {
        dataImageBytes = image;
      });
    }

    Future<void> createCombo(Combo newCombo) async {
      setState(() {
        loadingProvider.setLoading(true);
      });
      newCombo.image = '/images/${StringUtil.convert(combo.name)}.jpg';
      await comboProvider.createCombo(newCombo).then((response) {
        if (response.success) {
          firebaseStorageService.uploadImage(combo.image, dataImageBytes!).then((value) {
            setState(() {
              loadingProvider.setLoading(false);
            });
            PopupUtil.showSuccess(
                context: context,
                message: 'Thêm sản phẩm thành công',
                width: SizeConfig.screenWidth * 0.6 * 0.6,
                onPress: () {
                  setState(() {
                    combo = Combo.empty();
                  });
                  Navigator.of(context).pop();
                });
          });
        }
      }).catchError((error) {
        setState(() {
          loadingProvider.setLoading(false);
        });
        PopupUtil.showError(
          context: context,
          width: SizeConfig.screenWidth * 0.6 * 0.6,
          message: error is BadRequestException ? error.message : 'Lỗi không xác định',
        );
      });
    }

    return FutureBuilder(
      future: comboProvider.getCombos(),
      builder: (context, snapshot) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  ElevatedButton(
                    child: const Text('Thêm combo'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Consumer<LoadingProvider>(builder: (context, provider, child) {
                          return Stack(
                            children: [
                              AlertDialog(
                                title: const Text('Thêm combo'),
                                content: Container(
                                  width: SizeConfig.screenWidth * 0.4,
                                  padding: const EdgeInsets.all(8),
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
                                    child: const Text('Hủy'),
                                    onPressed: () => Navigator.of(context).pop(),
                                  ),
                                  TextButton(
                                    child: const Text('Thêm'),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        if (combo.comboItems.where((element) => element.product!.id == 0).isNotEmpty) {
                                          PopupUtil.showError(
                                            context: context,
                                            width: SizeConfig.screenWidth * 0.6 * 0.6,
                                            message: 'Vui lòng chọn sản phẩm',
                                          );
                                          return;
                                        } else if (combo.comboItems.where((element) => element.quantity == 0).isNotEmpty) {
                                          PopupUtil.showError(
                                            context: context,
                                            width: SizeConfig.screenWidth * 0.6 * 0.6,
                                            message: 'Số lượng phải lớn hơn 0',
                                          );
                                          return;
                                        } else {
                                          await createCombo(combo);
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                              if (loadingProvider.loading) const Loading()
                            ],
                          );
                        }),
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
                  source: ComboDataSource(context: context, provider: comboProvider),
                  columns: const [
                    DataColumn2(
                      label: Center(child: Text('ID')),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(
                      label: Center(child: Text('Tên combo')),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                      label: Center(child: Text('Giá')),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                      label: Center(child: Text('Mô tả')),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                      label: Center(child: Text('')),
                      size: ColumnSize.S,
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
