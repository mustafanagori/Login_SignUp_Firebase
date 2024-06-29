import 'dart:async';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationPlugin =
      FlutterLocalNotificationsPlugin();
  void requestNotificationPermission() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      carPlay: true,
      announcement: true,
      criticalAlert: true,
      provisional: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted permission");
    } else if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted provisonal permission");
    } else {
      print("user denied permission");
    }
  }

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidinitialization =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosinitialization = const DarwinInitializationSettings();
    var initializationSetting = InitializationSettings(
        android: androidinitialization, iOS: iosinitialization);

    await _localNotificationPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {});
  }

  

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(10000).toString(), 'high important',
        importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'your Channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher', // Add the icon parameter
    );
    DarwinNotificationDetails drawinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: drawinNotificationDetails);
    Future.delayed(Duration.zero, () {
      _localNotificationPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification!.title.toString());
      print(message.notification!.body.toString());
      showNotification(message);
    });
  }

  Future<void> getDeviceToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    if (token != null) {
      print("Device Token: $token");
    }
  }

  void isTokenExpire() {
    firebaseMessaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('refresh');
      }
    });
  }
}
