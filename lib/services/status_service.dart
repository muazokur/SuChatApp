import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:su_chat_hakan/services/storage_service.dart';

class StatusService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StorageService _storageService = StorageService();
  String mediaUrl = "";

  Future<void> addStatus(PickedFile pickedFile, String email) async {
    var ref = _firestore.collection("Users").doc(email);

    if (pickedFile == null) {
      mediaUrl = "";
    } else {
      mediaUrl = await _storageService.uploadMedia(File(pickedFile.path));
    }

    var documentRef = await ref.update({'image': mediaUrl});
  }
}
