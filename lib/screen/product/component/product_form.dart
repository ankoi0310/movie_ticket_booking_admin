import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/string_util.dart';

class ProductForm extends StatefulWidget {
  final GlobalKey formKey;
  final Product product;
  const ProductForm({Key? key, required this.formKey, required this.product}) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {

  @override
  Widget build(BuildContext context) {

    return Form(
      key: widget.formKey,
      child:  Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.start,
        runSpacing: 30,
        spacing: 30,
        children: [
          Container(
            width: SizeConfig.screenWidth * 0.3 * 0.6,
            child: TextFormField(
              initialValue: widget.product.name,
              decoration: const InputDecoration(
                labelText: 'Tên sản phẩm',
              ),
              onSaved: (value) {
                widget.product.name = value!;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Không được để trống';
                }
                return null;
              },
            ),
          ),
          Container(
            width: SizeConfig.screenWidth * 0.3 * 0.6,
            child: TextFormField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              initialValue: widget.product.price.toString(),
              decoration: const InputDecoration(
                labelText: 'Giá sản phẩm',
              ),
              onSaved: (value) {
                widget.product.price = int.parse(value!);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Không được để trống';
                }
                return null;
              },
            ),
          ),
          Container(
            width: SizeConfig.screenWidth * 0.3 * 0.6,
            child: TextFormField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              initialValue: widget.product.stock.toString(),
              decoration: const InputDecoration(
                labelText: 'Số lượng tồn',
              ),
              onSaved: (value) {
                widget.product.stock = int.parse(value!);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Không được để trống';
                }
                return null;
              },
            ),
          ),
          Container(
              width: SizeConfig.screenWidth * 0.3 * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Loại sản phẩm: '),
                  SizedBox(
                    height: (10),
                  ),
                  DropdownButton2(
                    isExpanded: true,
                    items: ProductType.values.map((e) =>
                        DropdownMenuItem(
                          value: e,
                          child: Text(StringUtil.changeProductType(e)),
                        )).toList(),
                    value: widget.product.productType,
                    onChanged: (value) {
                      setState(() {
                        widget.product.productType = value as ProductType;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      width: SizeConfig.screenWidth * 0.3 * 0.6,
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      elevation: 0,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(Icons.arrow_forward_ios_outlined),
                      iconSize: 14,
                      openMenuIcon: Icon(Icons.keyboard_arrow_down, size: 14),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      width: SizeConfig.screenWidth * 0.3 * 0.6,
                      decoration: const BoxDecoration(color: Colors.white),
                      elevation: 8,
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 14),
                    ),
                    underline: Container(),
                  )
                ],
              )
          ),

        ],
      )
    );
  }
}
