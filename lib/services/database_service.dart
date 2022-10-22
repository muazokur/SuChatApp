import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getData(String referencePath) {
    return _firestore.collection(referencePath).snapshots();
  }

  CollectionReference getCollection(String referencePath) {
    return _firestore.collection(referencePath);
  }

  Stream<QuerySnapshot> getUsersRequest(String referencePath) {
    return _firestore
        .collection(referencePath)
        .where('requestStatus', isEqualTo: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getUsers(String referencePath) {
    return _firestore
        .collection(referencePath)
        .where('requestStatus', isEqualTo: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getConversationId3(String referencePath) {
    return _firestore.collection(referencePath).snapshots();
  }

  Future<List<String>> getConversationId(
      String referencePath, String email) async {
    var conversationId = await _firestore.collection(referencePath).get();
    var list = conversationId.docs;
    List<String> emailList = [];
    for (int i = 0; i < list.length; i++) {
      if (email == list[i].data()['id'].toString().split('-')[0]) {
        emailList.add(list[i].data()['id'].toString().split('-')[1]);
      }
    }
    return emailList;
  }

  Stream<QuerySnapshot> getMessages(
      String referencePath, String conversationId) {
    return _firestore
        .collection(referencePath)
        .doc(conversationId)
        .collection('messages')
        .orderBy('timeStamp')
        .snapshots();
  }
}
