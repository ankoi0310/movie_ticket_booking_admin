import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/exception/bad_request_exception.dart';

Reference get storageRef => FirebaseStorage.instance.ref();

class FirebaseStorageService {
  Future<Uint8List?> getImage(String path) async {
    if (path.isEmpty) return Future.value(null);

    return await storageRef.child(path).getData();
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
