import 'package:chatapp_with_firebase/services/auth/auth_service.dart';
import 'package:chatapp_with_firebase/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../components/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  final VoidCallback onToggle;
  RegisterPage({super.key, required this.onToggle});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void signup(BuildContext context) async {
    // auth service

    final authService = AuthService();

    //password match create user
    if (_confirmPasswordController.text == _passwordController.text) {
      try {
        await authService.signUpWithEmailPassword(
          _emailController.text,
          _passwordController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString())),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text('password dont match')),
      );
    }

    //try login
  }

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

            const SizedBox(height: 10),
            Text(
              "Let's Create an account for you !",
              style: TextStyle(fontSize: 16, color: context.color.primary),
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
            CustomTextField(
              controller: _confirmPasswordController,
              labelText: "Confirm Password",
              prefixIcon: Icons.lock,
              isPassword: true,
            ),
            const SizedBox(height: 30),

            // Login button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  signup(context);
                },
                child: const Text("Register"),
              ),
            ),
            const SizedBox(height: 20),

            // Register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Have an account?"),
                TextButton(onPressed: onToggle, child: const Text("Login Now")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
