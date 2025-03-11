import 'package:chatapp_with_firebase/components/custom_chat_bubble.dart';
import 'package:chatapp_with_firebase/components/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';
import '../services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.receiverEmail});

  final String receiverEmail;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
    return await _chatService.getUserIDByEmail(widget.receiverEmail);
  }

  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(Duration(milliseconds: 500), () => scrollDown());
      }
    });

    Future.delayed(Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    _messageController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverEmail)),
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
              controller: _scrollController,
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

    var aligment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: aligment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          CustomChatBubble(
            message: data['message'],
            isCurrentUser: isCurrentUser,
          ),
        ],
      ),
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0, left: Checkbox.width),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              focusNode: myFocusNode,

              controller: _messageController,
              labelText: 'Type a message ..',
            ),
          ),

          Container(
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_upward),
              onPressed: sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
