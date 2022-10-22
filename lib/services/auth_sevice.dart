import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:su_chat_hakan/services/database_service.dart';

class AuthService {
  DatabaseService _databaseService = DatabaseService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final bool requestStatus = false;

  Future<bool?> userAuth(String email, String password, String number) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await _databaseService
        .getCollection('Users')
        .doc(email)
        .update({'userId': user.user!.uid});
  }

  Future<bool?> createUser(String nameSurname, String number, String email,
      String password, String state) async {
    try {
      await _firestore.collection('Users').doc(email).set({
        'userId': '1',
        'nameSurname': nameSurname,
        'number': number,
        'email': email,
        'password': password,
        'state': state,
        'requestStatus': requestStatus,
        'image': 'Fotoğraf Yok'
      });
      return true;
    } on Exception catch (error) {
      return false;
    }
  }

  Future<bool?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        return false;
      }
    }
    return null;
  }

  Future deleteUser(String email, String password) async {
    //auth idleri geri getir
    var user = _auth.currentUser;
    print(user);
    print(email + password);

    // try {
    //   AuthCredential _authCredential =
    //       EmailAuthProvider.credential(email: email, password: password);
    //   var result = await user?.reauthenticateWithCredential(_authCredential);
    //   await result!.user?.delete();
    // } catch (e) {
    //   print(e.toString());
    // }
  }
}
