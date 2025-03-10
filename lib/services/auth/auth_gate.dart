import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../pages/home_page.dart';
import 'login_or_register.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              // User is logged in, go to HomePage
              return HomePage();
            } else {
              // User is not logged in, go to LoginOrRegisterPage
              return LoginOrRegisterPage();
            }
          }
          // Show loading indicator while waiting
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
