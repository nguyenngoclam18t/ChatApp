import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final Timestamp timestamp;
  final String message, receiverID, senderEmail, senderID;

  Message(this.timestamp, this.message, this.receiverID, this.senderEmail,
      this.senderID);
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'receiverID': receiverID,
      'message': message,
      'timestamp': timestamp
    };
  }
}
