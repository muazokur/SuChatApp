import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadMedia(File file) async {
    var uploadTask = _firebaseStorage
        .ref()
        .child(
            "${DateTime.now().millisecondsSinceEpoch}.${file.path.split('.').last}")
        .putFile(file);

    uploadTask.snapshotEvents.listen((event) {});

    String url = await (await uploadTask).ref.getDownloadURL();

    return url;
  }

  Future<String> uploadFile(String fileName, String filepath) async {
    print('uploadfile');
    File file = File(filepath);
    try {
      var uploadFile =
          _firebaseStorage.ref('/testFile/$fileName').putFile(file);

      uploadFile.snapshotEvents.listen((event) {});

      String urlFile = await (await uploadFile).ref.getDownloadURL();

      return urlFile;
    } on Exception catch (e) {
      print(e);
      return 'Gönderilemedi';
    }
  }
}
