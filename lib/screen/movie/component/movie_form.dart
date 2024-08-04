import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/component/hover_builder.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/genre/genre_search.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/service/firebase_storage_service.dart';

class MovieForm extends StatefulWidget {
  final void Function(Uint8List) submitImageVertical;
  final void Function(Uint8List) submitImageHorizontal;

  const MovieForm({
    super.key,
    required this.formKey,
    required this.movie,
    required this.submitImageVertical,
    required this.submitImageHorizontal,
  });

  final GlobalKey<FormState> formKey;
  final Movie movie;

  @override
  State<MovieForm> createState() => _MovieFormState();
}

class _MovieFormState extends State<MovieForm> {
  XFile? imageVertical;
  Uint8List imageVerticalBytes = Uint8List(0);

  XFile? imageHorizontal;
  Uint8List imageHorizontalBytes = Uint8List(0);

  String changeFormat(String value) {
    switch (value) {
      case 'TWO_D':
        return '2D';
      case 'THREE_D':
        return '3D';
      case 'EIGHT_D':
        return '8D';
      case 'VOICE_OVER':
        return 'LỒNG TIẾNG';
      default:
        return '2D';
    }
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

  UploadTask? uploadTask;

  Future<void> _pickImageVertical() async {
    try {
      final picker = ImagePicker();

      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        var f = await pickedFile.readAsBytes();
        setState(() {
          imageVerticalBytes = f;
          imageVertical = pickedFile;
          widget.submitImageVertical(imageVerticalBytes);
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _pickImageHorizontal() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      var f = await pickedFile.readAsBytes();
      setState(() {
        imageHorizontalBytes = f;
        imageHorizontal = pickedFile;
        widget.submitImageHorizontal(imageHorizontalBytes);
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.movie.id != 0) {
    } else {
      widget.movie.actors.add("");
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final datePickerController = TextEditingController(text: DateFormat('dd-MM-yyyy').format(widget.movie.releaseDate));

    final genreProvider = Provider.of<GenreProvider>(context, listen: false);
    final firebaseStorageService = FirebaseStorageService();

    return Stack(
      children: [
        Form(
          key: widget.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 10,
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(
                          widget.movie.actors.length,
                          (index) => Container(
                            width: SizeConfig.screenWidth * 0.25 * 0.6,
                            child: TextFormField(
                              initialValue: widget.movie.actors[index],
                              decoration: InputDecoration(
                                labelText: "Tên diễn viên",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Tên diễn viên không được để trống';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (widget.movie.actors.length > index) {
                                  widget.movie.actors[index] = value;
                                } else {
                                  widget.movie.actors.add(value);
                                }
                              },
                            ),
                          ),
                        ),
                      )),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Container(
                            child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.blue),
                          child: const Text(
                            'Thêm',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              widget.movie.actors.add("");
                            });
                          },
                        )),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          child: const Text(
                            'Xoá',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              if (widget.movie.actors.length > 1) widget.movie.actors.remove(widget.movie.actors.last);
                            });
                          },
                        )),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.start,
                runSpacing: 30,
                spacing: 30,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.3 * 0.6,
                    child: TextFormField(
                      initialValue: widget.movie.name,
                      decoration: const InputDecoration(
                        labelText: 'Tên phim',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Tên phim không được để trống';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        widget.movie.name = value!;
                      },
                    ),
                  ),

                  SizedBox(
                    width: SizeConfig.screenWidth * 0.3 * 0.6,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      initialValue: widget.movie.rating.toString(),
                      decoration: const InputDecoration(
                        labelText: 'Đánh giá',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Không được để trống';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        widget.movie.rating = double.parse(value!);
                      },
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.3 * 0.6,
                    child: TextFormField(
                      initialValue: widget.movie.duration.toString(),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Thời lượng',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Không được để trống';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        widget.movie.duration = int.parse(value!);
                      },
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.3 * 0.6,
                    child: TextFormField(
                      initialValue: widget.movie.trailerUrl,
                      decoration: const InputDecoration(
                        labelText: 'Trailer url',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Không được để trống';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        widget.movie.trailerUrl = value!;
                      },
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.3 * 0.6,
                    child: TextFormField(
                      initialValue: widget.movie.director,
                      decoration: const InputDecoration(
                        labelText: 'Đạo diễn',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Không được để trống';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        widget.movie.director = value!;
                      },
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.3 * 0.6,
                    child: TextFormField(
                      initialValue: widget.movie.producer,
                      decoration: const InputDecoration(
                        labelText: 'Nhà sản xuất',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Không được để trống';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        widget.movie.producer = value!;
                      },
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.3 * 0.6,
                    child: TextFormField(
                      initialValue: widget.movie.language,
                      decoration: const InputDecoration(
                        labelText: 'Ngôn ngữ',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Không được để trống';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        widget.movie.language = value!;
                      },
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.3 * 0.6,
                    child: TextFormField(
                      initialValue: widget.movie.subtitle,
                      decoration: const InputDecoration(
                        labelText: 'Phụ đề',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Không được để trống';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        widget.movie.subtitle = value!;
                      },
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.3 * 0.6,
                    child: TextFormField(
                      initialValue: widget.movie.country,
                      decoration: const InputDecoration(
                        labelText: 'Quốc gia',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Không được để trống';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        widget.movie.country = value!;
                      },
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.3 * 0.6,
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Trạng thái phim: '),
                            SizedBox(
                              height: (10),
                            ),
                            DropdownButton2(
                              isExpanded: true,
                              value: widget.movie.movieState.value,
                              onChanged: (value) {
                                setState(() {
                                  widget.movie.movieState = MovieState.fromValue(value!);
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                padding: EdgeInsets.symmetric(
                                  horizontal: (20),
                                ),
                                width: SizeConfig.screenWidth * 0.3 * 0.6,
                                height: (40),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                              ),
                              iconStyleData: IconStyleData(
                                icon: Icon(Icons.keyboard_arrow_up_rounded),
                                iconSize: (28),
                                iconEnabledColor: Colors.black,
                                iconDisabledColor: Colors.grey,
                                openMenuIcon: Icon(Icons.keyboard_arrow_down_rounded),
                              ),
                              dropdownStyleData: DropdownStyleData(
                                elevation: 1,
                                maxHeight: 250,
                                width: SizeConfig.screenWidth * 0.3 * 0.6,
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(10),
                                  thickness: MaterialStateProperty.all(5),
                                  thumbColor: MaterialStateProperty.all(Colors.grey),
                                  trackColor: MaterialStateProperty.all(Colors.grey),
                                  thumbVisibility: MaterialStateProperty.all(true),
                                ),
                              ),
                              menuItemStyleData: MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                              ),
                              underline: Container(),
                              items: [
                                DropdownMenuItem(
                                  value: "NOW_SHOWING",
                                  child: Text(
                                    "Đang chiếu",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "UPCOMING",
                                  child: Text(
                                    "Sắp chiếu",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "END_SHOWING",
                                  child: Text(
                                    "Kết thúc",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: (20),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ngày phát hành: '),
                            SizedBox(
                              height: (10),
                            ),
                            TextFormField(
                              controller: datePickerController,
                              keyboardType: TextInputType.datetime,
                              readOnly: true,
                              onChanged: (value) {
                                widget.movie.releaseDate = DateFormat("dd-MM-yyyy").parse(value!);
                              },
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                height: 1.5,
                              ),
                              decoration: const InputDecoration(
                                hintText: "Chọn ngày tháng năm",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                                suffixIcon: Icon(
                                  Icons.calendar_today,
                                  color: Colors.black,
                                  size: (16),
                                ),
                              ),
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1999),
                                  lastDate: DateTime(2024),
                                ).then((value) {
                                  setState(() {
                                    widget.movie.releaseDate = value!;
                                    datePickerController.text = DateFormat('dd-MM-yyyy').format(widget.movie.releaseDate);
                                  });
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.3 * 0.6,
                    height: 200,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Chiều:'),
                          ...MovieFormat.values.map(
                            (option) => CheckboxListTile(
                              title: Text(
                                changeFormat(option.value),
                                style: TextStyle(fontSize: 14),
                              ),
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: widget.movie.movieFormats.contains(option),
                              onChanged: (value) {
                                setState(() {
                                  if (value != null && value) {
                                    widget.movie.movieFormats.add(option);
                                  } else {
                                    widget.movie.movieFormats.remove(option);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.3 * 0.6,
                    height: 200,
                    child: FutureBuilder(
                      future: genreProvider.getGenres(GenreSearch()),
                      builder: (context, snapshot) {
                        List<Genre> genres = [];
                        if (snapshot.hasData) {
                          genres = genreProvider.genres;
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Thể loại:'),
                                ...genres.map(
                                  (genre) => CheckboxListTile(
                                    title: Text(
                                      genre.name,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    value: widget.movie.genres.map((e) => e.id).contains(genre.id),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value != null && value) {
                                          widget.movie.genres.add(genre);
                                        } else {
                                          widget.movie.genres.removeWhere((element) => element.id == genre.id);
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.6,
                    child: TextFormField(
                      initialValue: widget.movie.storyLine,
                      decoration: const InputDecoration(
                        labelText: 'Cốt truyện',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Không được để trống';
                        }
                        return null;
                      },
                      textAlignVertical: TextAlignVertical.top,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      onChanged: (value) {
                        widget.movie.storyLine = value;
                      },
                    ),
                  ),
                  // select image button

                  widget.movie.id != 0
                      ? Row(
                        children: [
                          FutureBuilder(
                              future: firebaseStorageService.getImages([widget.movie.imageVertical]),
                              builder: (context, snapshot) {
                                if (firebaseStorageService.mapImage[widget.movie.imageVertical] != null) {
                                  if (imageVertical == null) {
                                    imageVerticalBytes = firebaseStorageService.mapImage[widget.movie.imageVertical]!;
                                    widget.submitImageVertical(imageVerticalBytes);
                                  }
                                  return SizedBox(
                                      width: SizeConfig.screenWidth * 0.3 * 0.6,
                                      child: Column(
                                        children: [
                                          HoverBuilder(builder: (isHovering) {
                                            return Container(
                                              height: 250,
                                              decoration: imageVerticalBytes.isNotEmpty
                                                  ? BoxDecoration(
                                                image: DecorationImage(
                                                  image: Image.memory(imageVerticalBytes).image,
                                                  fit: BoxFit.contain,
                                                ),
                                                borderRadius: BorderRadius.circular(10),
                                              )
                                                  : null,
                                              child: imageVerticalBytes.isEmpty
                                                  ? dottedBorder(pickImage: _pickImageVertical, text: "Chọn ảnh đứng")
                                                  : (isHovering
                                                  ? InkWell(
                                                onTap: () async {
                                                  await _pickImageVertical();
                                                },
                                                child: Container(
                                                  color: Colors.black.withOpacity(0.5),
                                                  child: Center(
                                                    child: Text(
                                                      "Chọn ảnh khác",
                                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                              )
                                                  : Container()),
                                            );
                                          }),
                                        ],
                                      ));
                                }
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: SizeConfig.screenWidth * 0.27 * 0.6, height: 300, child: Center(child: CircularProgressIndicator())),
                                  ],
                                );
                              }),
                          FutureBuilder(
                              future: firebaseStorageService.getImages([widget.movie.imageHorizontal]),
                              builder: (context, snapshot) {
                                if (firebaseStorageService.mapImage[widget.movie.imageHorizontal] != null) {
                                  if (imageHorizontal == null) {
                                    imageHorizontalBytes = firebaseStorageService.mapImage[widget.movie.imageHorizontal]!;
                                    widget.submitImageHorizontal(imageHorizontalBytes);
                                  }
                                  return SizedBox(
                                      width: SizeConfig.screenWidth * 0.68 * 0.6,
                                      child: Column(
                                        children: [
                                          HoverBuilder(builder: (isHovering) {
                                            return Container(
                                              height: 250,
                                              decoration: imageHorizontalBytes.isNotEmpty
                                                  ? BoxDecoration(
                                                      image: DecorationImage(
                                                        image: Image.memory(imageHorizontalBytes).image,
                                                        fit: BoxFit.contain,
                                                      ),
                                                      borderRadius: BorderRadius.circular(10),
                                                    )
                                                  : null,
                                              child: imageHorizontalBytes.isEmpty
                                                  ? dottedBorder(pickImage: _pickImageHorizontal, text: "Chọn ảnh ngang")
                                                  : (isHovering
                                                      ? InkWell(
                                                          onTap: () async {
                                                            _pickImageHorizontal();
                                                          },
                                                          child: Container(
                                                            color: Colors.black.withOpacity(0.5),
                                                            child: Center(
                                                              child: Text(
                                                                "Chọn ảnh khác",
                                                                style: TextStyle(color: Colors.white, fontSize: 20),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Container()),
                                            );
                                          }),
                                        ],
                                      ));
                                }
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: SizeConfig.screenWidth * 0.67 * 0.6, height: 300, child: Center(child: CircularProgressIndicator())),
                                  ],
                                );
                              }),
                        ],
                      )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: SizeConfig.screenWidth * 0.27 * 0.6,
                                child: Column(
                                  children: [
                                    HoverBuilder(builder: (isHovering) {
                                      return Container(
                                        height: 250,
                                        decoration: imageVerticalBytes.isNotEmpty
                                            ? BoxDecoration(
                                                image: DecorationImage(
                                                  image: Image.memory(imageVerticalBytes).image,
                                                  fit: BoxFit.contain,
                                                ),
                                                borderRadius: BorderRadius.circular(10),
                                              )
                                            : null,
                                        child: imageVerticalBytes.isEmpty
                                            ? dottedBorder(pickImage: _pickImageVertical, text: "Chọn ảnh đứng")
                                            : (isHovering
                                                ? InkWell(
                                                    onTap: () {
                                                      _pickImageVertical();
                                                    },
                                                    child: Container(
                                                      color: Colors.black.withOpacity(0.5),
                                                      child: Center(
                                                        child: Text(
                                                          "Chọn ảnh khác",
                                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container()),
                                      );
                                    }),
                                  ],
                                )),
                            SizedBox(
                                width: SizeConfig.screenWidth * 0.67 * 0.6,
                                child: Column(
                                  children: [
                                    HoverBuilder(builder: (isHovering) {
                                      return Container(
                                        height: 250,
                                        decoration: imageHorizontalBytes.isNotEmpty
                                            ? BoxDecoration(
                                                image: DecorationImage(
                                                  image: Image.memory(imageHorizontalBytes).image,
                                                  fit: BoxFit.contain,
                                                ),
                                                borderRadius: BorderRadius.circular(10),
                                              )
                                            : null,
                                        child: imageHorizontalBytes.isEmpty
                                            ? dottedBorder(pickImage: _pickImageHorizontal, text: "Chọn ảnh ngang")
                                            : (isHovering
                                                ? InkWell(
                                                    onTap: () {
                                                      _pickImageHorizontal();
                                                    },
                                                    child: Container(
                                                      color: Colors.black.withOpacity(0.5),
                                                      child: Center(
                                                        child: Text(
                                                          "Chọn ảnh khác",
                                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container()),
                                      );
                                    }),
                                  ],
                                )),
                          ],
                        ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
