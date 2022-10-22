class Conversation {
  final String? messageId;
  final String? message;
  final String? timeStamp;
  final String? type;
  final String? filePath;

  Conversation(
      {this.messageId, this.message, this.timeStamp, this.type, this.filePath});

  Map<String, dynamic> toMap() => {
        'messageId': messageId,
        'message': message,
        'timeStamp': timeStamp,
        'type': type,
        'filePath': filePath,
      };

  factory Conversation.fromMap(Map map) => Conversation(
        messageId: map['messageId'],
        message: map['message'],
        timeStamp: map['timeStamp'],
        type: map['type'],
        filePath: map['filePath'],
      );
}
