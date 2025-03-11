// ignore_for_file: use_build_context_synchronously

import 'package:chatapp_with_firebase/services/auth/auth_service.dart';
import 'package:chatapp_with_firebase/extensions/extensions.dart';
import 'package:firebase_auth_platform_interface/src/firebase_auth_exception.dart';
import 'package:flutter/material.dart';

import '../components/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  final VoidCallback onToggle;
  LoginPage({super.key, required this.onToggle});

  void login(BuildContext context) async {
    // auth service

    final authService = AuthService();

    //try login

    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text(
                authService.getErrorMessage(
                  e.toString() as FirebaseAuthException,
                ),
              ),
            ),
      );
    }
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.surface,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Icon(
              Icons.chat_bubble_outline,
              size: 100,
              color: context.color.primary,
            ),
            const SizedBox(height: 20),

            // Welcome back text
            const Text(
              "Welcome Back!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Login to continue",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Email text field
            CustomTextField(
              controller: _emailController,
              labelText: "Email",
              prefixIcon: Icons.email,
            ),
            const SizedBox(height: 20),

            // Password text field
            CustomTextField(
              controller: _passwordController,
              labelText: "Password",
              prefixIcon: Icons.lock,
              isPassword: true,
            ),
            const SizedBox(height: 30),

            // Login button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  login(context);
                },
                child: const Text("Login"),
              ),
            ),
            const SizedBox(height: 20),

            // Register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: onToggle,
                  child: const Text("Register Now"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
