import 'package:chatapp_with_firebase/components/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';
import '../services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key, required this.receiverEmail});

  final String receiverEmail;
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  final TextEditingController _messageController = TextEditingController();

  Future<void> sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      String? receiverID = await _getReceiverID();
      if (receiverID != null) {
        await _chatService.sendMessage(receiverID, _messageController.text);
        _messageController.clear();
      }
    }
  }

  Future<String?> _getReceiverID() async {
    return await _chatService.getUserIDByEmail(receiverEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(receiverEmail)),
      body: Column(
        children: [Expanded(child: _buildMessageList()), _buildUserInput()],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;

    return FutureBuilder<String?>(
      future: _getReceiverID(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError || snapshot.data == null) {
          return Text("Error loading messages");
        }

        String receiverID = snapshot.data!;

        return StreamBuilder(
          stream: _chatService.getMessages(senderID, receiverID),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Text("No messages yet.");
            }

            return ListView(
              children:
                  snapshot.data!.docs
                      .map<Widget>((doc) => _buildMessageItem(doc))
                      .toList(),
            );
          },
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;



    return Text(data['message']);
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            controller: _messageController,
            labelText: 'Type a message ..',
          ),
        ),

        IconButton(icon: Icon(Icons.send), onPressed: sendMessage),
      ],
    );
  }
}
