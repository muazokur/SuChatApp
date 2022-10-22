import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:su_chat_hakan/models/conversations.dart';
import 'package:su_chat_hakan/services/database_service.dart';

class ConversationModel with ChangeNotifier {
  final DatabaseService _service = DatabaseService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<Conversation>> getMessages(String conversationId) {
    const String _reference = 'Conversations';

    Stream<List<DocumentSnapshot>> streamListDocument =
        _service //yani kullanıcı listesi
            .getMessages(_reference, conversationId)
            .map((querySnapshot) => querySnapshot.docs);

    //Stream<List<DocumentSnapshot>> --> Stream<List<UsersList>>
    var streamListMessages = streamListDocument.map((listOfSnap) => listOfSnap
        .map<Conversation>((docSnap) =>
            Conversation.fromMap(docSnap.data() as Map<String, dynamic>))
        .toList());

    return streamListMessages;
  }

  Future<bool?> sendMessage(String? senderId, String receiveId, String message,
      String type, String time, String? filePath) async {
    try {
      await _firestore
          .collection('Conversations')
          .doc(senderId! + '-' + receiveId)
          .set({'id': senderId + '-' + receiveId});

      await _firestore
          .collection('Conversations')
          .doc(senderId + '-' + receiveId)
          .collection('messages')
          .doc(DateTime.now().toString())
          .set({
        'messageId': '1',
        'message': message,
        'timeStamp': time,
        'filePath': filePath,
        'type': 'sender',
      });
      await _firestore
          .collection('Conversations')
          .doc(receiveId + '-' + senderId)
          .set({'id': receiveId + '-' + senderId});

      await _firestore
          .collection('Conversations')
          .doc(receiveId + '-' + senderId)
          .collection('messages')
          .doc(DateTime.now().toString())
          .set({
        'messageId': '1',
        'message': message,
        'timeStamp': time,
        'filePath': filePath,
        'type': 'receive',
      });
      return true;
    } on Exception catch (error) {
      return false;
    }
  }
}
