import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/component/loading_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/product_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/exception/bad_request_exception.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/product/component/product_form.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/source/product_data_source.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/popup_util.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Product product = Product.empty();

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final loadingProvider = Provider.of<LoadingProvider>(context);

    int currentPageIndex = 0;

    Future<void> createProduct(Product newProduct) async {
      setState(() {
        loadingProvider.setLoading(true);
      });
      await productProvider.createProduct(newProduct).then((response) {
        if (response.success) {
          PopupUtil.showSuccess(
            context: context,
            width: SizeConfig.screenWidth * 0.6 * 0.6,
            message: 'Thêm sản phẩm thành công',
            onPress: () {
              product = Product.empty();
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
      future: productProvider.getProducts(),
      builder: (context, snapshot) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  ElevatedButton(
                    child: const Text('Thêm sản phẩm'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Thêm sản phẩm'),
                          content: Container(
                            width: SizeConfig.screenWidth * 0.6,
                            padding: const EdgeInsets.all(8),
                            child: ProductForm(
                              formKey: formKey,
                              product: product,
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
                                  await createProduct(product);
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
                source: ProductDataSource(context: context, provider: productProvider),
                columns: const [
                  DataColumn2(
                    label: Center(child: Text('Tên sản phẩm')),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Center(child: Text('Giá')),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Center(child: Text('Tồn kho')),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Center(child: Text('Loại')),
                    size: ColumnSize.S,
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
