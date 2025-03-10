// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomChatBubble extends StatelessWidget {
  const CustomChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  final String message;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 2.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isCurrentUser ? Colors.green : Colors.grey.shade500,
      ),
      child: Text(message, style: TextStyle(fontSize: 20, color: Colors.white)),
    );
  }
}
