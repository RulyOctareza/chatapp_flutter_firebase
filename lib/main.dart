import 'dart:developer';

import 'package:chatapp_with_firebase/services/auth/auth_gate.dart';
import 'package:chatapp_with_firebase/services/notifications/notifications_service.dart';
import 'package:chatapp_with_firebase/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  //setup firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // setup notifbackground handler

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  //request permission

  final notif = NotificationsService();

  notif.requestPermission;
  notif.setupInteractions();
  //run app
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MainApp(),
    ),
  );
}

// Notification background handler

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('handling a background message: ${message.messageId}');
  log('handling a background message: ${message.data}');
  log('handling a background message: ${message.notification?.title}');
  log('handling a background message: ${message.notification?.body}');
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: AuthGate(),
    );
  }
}
