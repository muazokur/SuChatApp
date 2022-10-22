import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:su_chat_hakan/models/user.dart';
import 'package:su_chat_hakan/services/auth_sevice.dart';
import 'package:su_chat_hakan/services/database_service.dart';

class UserModel with ChangeNotifier {
  final DatabaseService _service = DatabaseService();
  final String _reference = 'Users';
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> emailUserList = [];

  Stream<List<Users>> getUsers() {
    const String _reference = 'Users';

    // stream<QuerySnapshot> --> Stream<List<DocumentSnapshot>>
    Stream<List<DocumentSnapshot>> streamListDocument =
        _service //yani kullanıcı listesi
            .getUsers(_reference)
            .map((querySnapshot) => querySnapshot
                .docs); //DocumentSnapshotlara ait bir map -> getUsers, stream olarak dönüyor çünkü .snapshots metodu eklenmiş

    //Stream<List<DocumentSnapshot>> --> Stream<List<UsersList>>

    var streamListUsers = streamListDocument.map((listOfSnap) => listOfSnap
        .map<Users>(
            (docSnap) => Users.fromMap(docSnap.data() as Map<String, dynamic>))
        .toList());

    return streamListUsers;
  }

  Stream<List<Users>> getUsersRequest() {
    const String _reference = 'Users';
    List<String> emailUserList;
    // stream<QuerySnapshot> --> Stream<List<DocumentSnapshot>>
    Stream<List<DocumentSnapshot>> streamListDocument =
        _service //yani kullanıcı listesi
            .getUsersRequest(_reference)
            .map((querySnapshot) => querySnapshot
                .docs); //DocumentSnapshotlara ait bir map -> getUsers, stream olarak dönüyor çünkü .snapshots metodu eklenmiş

    //Stream<List<DocumentSnapshot>> --> Stream<List<UsersList>>

    var streamListUsers = streamListDocument.map((listOfSnap) => listOfSnap
        .map<Users>(
            (docSnap) => Users.fromMap(docSnap.data() as Map<String, dynamic>))
        .toList());

    return streamListUsers;
  }

  Stream<List<Users>> getChats() {
    const String _reference = 'Users';
    // stream<QuerySnapshot> --> Stream<List<DocumentSnapshot>>
    Stream<List<DocumentSnapshot>> streamListDocument =
        _service //yani kullanıcı listesi
            .getUsers(_reference)
            .map((querySnapshot) => querySnapshot
                .docs); //DocumentSnapshotlara ait bir map -> getUsers, stream olarak dönüyor çünkü .snapshots metodu eklenmiş

    //Stream<List<DocumentSnapshot>> --> Stream<List<UsersList>>

    var streamListUsers = streamListDocument.map((listOfSnap) => listOfSnap
        .map<Users>(
            (docSnap) => Users.fromMap(docSnap.data() as Map<String, dynamic>))
        .toList());

    return streamListUsers;
  }

  getChatUserList(String email) async {
    var emailList = _service.getConversationId('Conversations', email);
    emailUserList = await emailList;
  }

  Stream<DocumentSnapshot> getCurrentUser(String email) {
    var ref = _firestore.collection(_reference).doc(email).snapshots();

    return ref;
  }

  usersRequestAdmitIt(String userId, String email, String password) async {
    await _service
        .getCollection(_reference)
        .doc(email)
        .update({'requestStatus': true});

    await _authService.userAuth(email, password, userId);

    print(email);
  }

  toRejectUser(String email) async {
    await _service.getCollection(_reference).doc(email).delete();
    //print(email);
  }

  deleteUser(String email, String password, String number) async {
    //await _authService.deleteUser(email, password);
    await _service.getCollection(_reference).doc(email).delete();
    //print(userId);
  }
}
