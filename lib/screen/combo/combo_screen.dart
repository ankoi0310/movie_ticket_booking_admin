import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/combo_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/component/loading_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/combo/component/combo_form.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/service/firebase_storage_service.dart';
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


    void submitImage(Uint8List? image) {
      setState(() {
        image = dataImageBytes;
      });
    }

    Future<HttpResponse> createCombo(Combo newCombo) async {
      setState(() {
        loadingProvider.setLoading(true);
      });
      newCombo.image = '/images/${StringUtil.convert(combo.name)}.jpg';
      HttpResponse response = await comboProvider.createCombo(newCombo);

      if (response.success) {
        // await firebaseStorageService.uploadImage(combo.image, dataImageBytes!);

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
      } else {
        setState(() {
          loadingProvider.setLoading(false);
        });
        PopupUtil.showError(
          context: context,
          message: response.message,
          width: SizeConfig.screenWidth * 0.6 * 0.6,
        );
      }

      return response;
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
                        builder: (context) =>
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
                                      await createCombo(combo);
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
            // SizedBox(
            //   width: SizeConfig.screenWidth,
            //   height: SizeConfig.screenHeight * 0.7,
            //   child: PaginatedDataTable2(
            //     empty: const Center(child: Text('Không có dữ liệu')),
            //     border: TableBorder.all(color: Colors.grey, width: 1),
            //     rowsPerPage: DatatableConfig.defaultRowsPerPage,
            //     fit: FlexFit.tight,
            //     onPageChanged: (index) {
            //       setState(() {
            //         // currentPageIndex = index;
            //       });
            //     },
            //     // source: GenreDataTableSource(context: context, provider: genreProvider),
            //     columns: const [
            //       DataColumn2(
            //         label: Center(child: Text('ID')),
            //         size: ColumnSize.S,
            //       ),
            //       DataColumn2(
            //         label: Center(child: Text('Tên thể loại')),
            //         size: ColumnSize.L,
            //       ),
            //       DataColumn2(
            //         label: Center(child: Text('')),
            //         size: ColumnSize.S,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
