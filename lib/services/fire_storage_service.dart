import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FireStorageService {
  FireStorageService._();

  static final FireStorageService instance = FireStorageService._();

  FireStorageService();
  Future<String> uploadImage(File file,String name) async {
    try {
      final ref = FirebaseStorage.instance.ref().child('images/${name}${DateTime.now().toString()}');
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      throw e;
    }
  }
}