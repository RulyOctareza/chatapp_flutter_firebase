import 'dart:developer';

import 'package:chatapp_with_firebase/services/notifications/notifications_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Sign in method
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      NotificationsService().setupTokenListeners();

      // save user as doc

      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      return userCredential.user;
    } catch (e) {
      log("Sign-in error: ${e.toString()}");
      return null;
    }
    // save device token
  }

  // Sign up method
  Future<User?> signUpWithEmailPassword(String email, String password) async {
    try {
      //create user
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // save user as doc

      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
      NotificationsService().setupTokenListeners();

      return userCredential.user;
    } catch (e) {
      log("Sign-up error: ${e.toString()}");
      return null;
    }
  }

  // Sign out method
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      String? userId = _auth.currentUser?.uid;

      if (userId != null) {
        await NotificationsService().clearTokenOnLogout(userId);
      }
    } catch (e) {
      log("Sign-out error: ${e.toString()}");
    }
  }

  // Handle authentication state changes
  Stream<User?> get userStream {
    return _auth.authStateChanges();
  }

  // Handle errors and return user-friendly messages
  String getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Email format is invalid';
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'email-already-in-use':
        return 'Email is already registered';
      default:
        return 'An unexpected error occurred';
    }
  }
}
