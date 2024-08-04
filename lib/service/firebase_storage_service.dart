import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/exception/bad_request_exception.dart';

Reference get storageRef => FirebaseStorage.instance.ref();

class FirebaseStorageService extends ChangeNotifier {
  final Map<String, Uint8List> _mapImage = {};
  Uint8List? _image;

  Map<String, Uint8List> get mapImage => _mapImage;

  Uint8List? get image => _image;

  Future<Uint8List?> getImages(List<String> paths) async {
    try {
      if (paths.isEmpty) return null;

      for (final path in paths) {
        if (_mapImage.containsKey(path)) {
          _image = _mapImage[path];
        } else {
          _image = await storageRef.child(path).getData();
          _mapImage[path] = _image!;
        }
      }
      return _image;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> uploadImage(String path, Uint8List data) async {
    final ref = storageRef.child(path);
    final uploadTask = ref.putData(data);

    if (uploadTask == null) return;

    await uploadTask.whenComplete(() {}).catchError((error) {
      throw BadRequestException(error.toString());
    });
  }
}
