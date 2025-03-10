// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String message;
  final Timestamp timestamp;
  Message({
    required this.senderID,
    required this.senderEmail,
    required this.receiverID,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'receiverID': receiverID,
      'message': message,
      'timestamp': timestamp,
    };
  }

  // factory Message.fromMap(Map<String, dynamic> map) {
  //   return Message(
  //     senderID: map['senderID'] as String,
  //     senderEmail: map['senderEmail'] as String,
  //     receiverID: map['receiverID'] as String,
  //     message: map['message'] as String,
  //     timestamp: Timestamp.fromMap(map['timestamp'] as Map<String, dynamic>),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory Message.fromJson(String source) =>
  //     Message.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() {
  //   return 'Message(senderID: $senderID, senderEmail: $senderEmail, receiverID: $receiverID, message: $message, timestamp: $timestamp)';
  // }

  // @override
  // bool operator ==(covariant Message other) {
  //   if (identical(this, other)) return true;

  //   return other.senderID == senderID &&
  //       other.senderEmail == senderEmail &&
  //       other.receiverID == receiverID &&
  //       other.message == message &&
  //       other.timestamp == timestamp;
  // }

  // @override
  // int get hashCode {
  //   return senderID.hashCode ^
  //       senderEmail.hashCode ^
  //       receiverID.hashCode ^
  //       message.hashCode ^
  //       timestamp.hashCode;
  // }
}
