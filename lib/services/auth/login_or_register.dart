import 'package:chatapp_with_firebase/pages/login_page.dart';
import 'package:flutter/material.dart';

import '../../pages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  _LoginOrRegisterPageState createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          showLoginPage
              ? LoginPage(onToggle: togglePages)
              : RegisterPage(onToggle: togglePages),
    );
  }
}
