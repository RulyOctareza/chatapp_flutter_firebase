import 'package:chatapp_with_firebase/components/custom_user_tile.dart';
import 'package:chatapp_with_firebase/services/auth/auth_service.dart';
import 'package:chatapp_with_firebase/components/custom_drawer.dart';
import 'package:chatapp_with_firebase/extensions/extensions.dart';
import 'package:chatapp_with_firebase/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: context.color.onSurface,
        title: Text('Homepage', textAlign: TextAlign.center),
      ),

      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return Text('error ');
        }

        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return ListView(
          children:
              snapshot.data!
                  .map<Widget>(
                    (userData) => _buildUserListItem(userData, context),
                  )
                  .toList(),
        );

        //return list view
      },
    );
  }

  // build individual user list item
  Widget _buildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    if (userData['email'] != authService.getCurrentUser()!.emailVerified) {
      return CustomUserTile(
        text: userData['email'],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(receiverEmail: userData['email']),
            ),
          );
        },
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}
