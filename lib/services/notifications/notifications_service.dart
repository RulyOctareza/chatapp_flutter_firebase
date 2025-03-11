import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/subjects.dart';

class NotificationsService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _messageStreamController = BehaviorSubject<RemoteMessage>();
  //Request permission

  Future<void> requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('user declined permission');
    }
  }

  void setupInteractions() {
    //user received
    FirebaseMessaging.onMessage.listen((event) {
      log('Got message in foreground');
      log('message data: ${event.data}');

      _messageStreamController.sink.add(event);
    });
    //user open message
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      log('message clicked !');
    });
  }

  void dispose() {
    _messageStreamController.close();
  }

  // setup token listeners

  void setupTokenListeners() {
    FirebaseMessaging.instance.getToken().then((token) {
      saveTokenToDatabase(token);
    });

    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }

  // save device token

  void saveTokenToDatabase(String? token) {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null && token != null) {
      FirebaseFirestore.instance.collection('users').doc(userId).set({
        'fcmToken': token,
      }, SetOptions(merge: true));
    }
  }

  // clear device token

  Future<void> clearTokenOnLogout(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'fcmToken': FieldValue.delete(),
      });
      log('Token cleared');
    } catch (e) {
      log('failed to clear token $e');
    }
  }
}
