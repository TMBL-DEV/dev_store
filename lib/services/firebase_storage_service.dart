import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  static final FirebaseStorageService instance =
      FirebaseStorageService._internal();

  factory FirebaseStorageService() {
    return instance;
  }

  FirebaseStorageService._internal();

  Future<String> getDownloadUrlFromPath({required String path}) {
    return FirebaseStorage.instance.ref().child(path).getDownloadURL();
  }
}
