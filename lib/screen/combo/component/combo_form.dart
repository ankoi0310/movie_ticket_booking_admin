import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/combo.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/combo_item.dart';
import 'package:quantity_input/quantity_input.dart';

class ComboForm extends StatefulWidget {
  final GlobalKey formKey;
  final Combo combo;
  final Function(Uint8List) submitImage;

  const ComboForm({Key? key, required this.formKey, required this.combo, required this.submitImage}) : super(key: key);

  @override
  State<ComboForm> createState() => _ComboFormState();
}

class _ComboFormState extends State<ComboForm> {
  XFile? image;
  Uint8List imageBytes = Uint8List(8);
  UploadTask? uploadTask;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.combo.comboItems = [ComboItem.empty()];
  }


  Widget dottedBorder({
    required Function() pickImage,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DottedBorder(
          dashPattern: const [6.7],
          borderType: BorderType.RRect,
          color: Colors.black,
          radius: const Radius.circular(12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.image_outlined,
                  color: Colors.black,
                  size: 50,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: (() {
                      pickImage();
                    }),
                    child: Text(
                      text,
                      style: const TextStyle(color: Colors.blue),
                    ))
              ],
            ),
          )),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      var f = await pickedFile.readAsBytes();
      setState(() {
        imageBytes = f;
        image = pickedFile;
        widget.submitImage(imageBytes);
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Form(
        key: widget.formKey,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.start,
          runSpacing: 30,
          spacing: 30,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth * 0.45 * 0.4,
              child: TextFormField(
                initialValue: widget.combo.name,
                decoration: const InputDecoration(
                  labelText: 'Tên combo',
                ),
                onSaved: (value) {
                  widget.combo.name = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Không được để trống';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: SizeConfig.screenWidth * 0.45 * 0.4,
              child: TextFormField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                initialValue: widget.combo.price.toString(),
                decoration: const InputDecoration(
                  labelText: 'Giá combo',
                ),
                onSaved: (value) {
                  widget.combo.price = int.parse(value!);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Không được để trống';
                  }
                  return null;
                },
              ),
            ),
            Container(),
            SizedBox(
                width: SizeConfig.screenWidth * 0.6,
                child: Column(
                  children: [
                    Container(
                      height: 250,
                      decoration: image != null
                          ? BoxDecoration(
                              image: DecorationImage(
                                image: Image.memory(imageBytes).image,
                                fit: BoxFit.contain,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            )
                          : null,
                      child: image == null ? dottedBorder(pickImage: _pickImage, text: "Chọn ảnh combo") : Container(),
                    ),
                  ],
                )),
            Container(),
            SizedBox(
              child: FutureBuilder(
                  future: productProvider.getProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<DropdownMenuItem> items = [];
                      items.add(DropdownMenuItem(
                        value: Product.empty(),
                        child: Text("Chọn sản phẩm"),
                      ));

                      items.addAll(productProvider.products.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e.name),
                        );
                      }).toList());
                      return Container(
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Thành phần combo",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            widget.combo.comboItems.add(ComboItem.empty());
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 15),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 6,
                                          ),
                                          color: Colors.green,
                                          child: Text(
                                            "Thêm",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (widget.combo.comboItems.length > 1) {
                                              widget.combo.comboItems.remove(widget.combo.comboItems.last);
                                              // addProductIntoCombo();
                                            }
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 6,
                                          ),
                                          color: Colors.red,
                                          child: Text(
                                            "Xoá",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                                child: Column(
                              children: List.generate(widget.combo.comboItems.length, (index) {
                                ComboItem comboItem = widget.combo.comboItems[index];
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: SizeConfig.screenWidth * 0.4 * 0.4,
                                        margin: EdgeInsets.symmetric(vertical: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Sản phẩm: '),
                                            SizedBox(
                                              height: (10),
                                            ),
                                            DropdownButton2(
                                              isExpanded: true,
                                              items: items,
                                              value: comboItem.product,
                                              onChanged: (value) {
                                                setState(() {
                                                  widget.combo.comboItems[index].product = value!;
                                                });
                                              },
                                              buttonStyleData: ButtonStyleData(
                                                width: SizeConfig.screenWidth * 0.4 * 0.4,
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
                                                maxHeight: 200,
                                                width: SizeConfig.screenWidth * 0.4 * 0.4,
                                                decoration: const BoxDecoration(color: Colors.white),
                                                elevation: 8,
                                                scrollbarTheme: ScrollbarThemeData(
                                                  radius: const Radius.circular(40),
                                                  thickness: MaterialStateProperty.all<double>(6),
                                                  thumbVisibility: MaterialStateProperty.all<bool>(true),
                                                ),
                                              ),
                                              menuItemStyleData: const MenuItemStyleData(
                                                height: 40,
                                                padding: EdgeInsets.symmetric(horizontal: 18),
                                              ),
                                              underline: Container(),
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      width: SizeConfig.screenWidth * 0.05 * 0.4,
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      width: SizeConfig.screenWidth * 0.45 * 0.4,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Số lượng: '),
                                          SizedBox(
                                            height: (6),
                                          ),
                                          QuantityInput(
                                              value: widget.combo.comboItems[index].quantity,
                                              maxValue: 10,
                                              acceptsNegatives: false,
                                              type: QuantityInputType.int,
                                              minValue: 0,
                                              acceptsZero: true,
                                              step: 1,
                                              inputWidth: 150,
                                              elevation: 3,
                                              onChanged: (value) {
                                                setState(() {
                                                  widget.combo.comboItems[index].quantity = int.parse(value);
                                                });
                                              }),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            )),
                          ],
                        ),
                      );
                    }
                    return Container();
                  }),
            )
          ],
        ));
  }
}
