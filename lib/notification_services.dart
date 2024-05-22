import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationServices{
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  bool kDebugMode = true;
  //Getting Permission
  void requestNotificationPermission() async{
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      sound: true,
      provisional: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user granted permission');
    }
    else if (settings.authorizationStatus == AuthorizationStatus.provisional) {    //y iphone users k liy h
      print('user granted provisional permission');
    }
    else {
      //AppSettings.openAppSettings();
      print('user denied permission');
    }
  }

  //mobile notification show
  void initLocalNotification(BuildContext context, RemoteMessage message) async{
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings,
        iOS: iosInitializationSettings
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (payload) {

      }
    );
  }

  //console pr show
  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
      }
      showNotification(message);
    });
  }

  //mobile pr show
  Future<void> showNotification(RemoteMessage message) async{
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(10000).toString(),
        'High Importance Notifications',
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        channel.id.toString(),
        channel.name.toString(),
        channelDescription: 'Your Channel Description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker'
    );

    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android:  androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    
    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  //Device ka token lia q k firebase id pr ni Device token pr notification send krta h
  Future<String> getDeviceToken() async{
    String? token = await messaging.getToken();
    return token!;
  }

  //Token agr expire ho jay to refresh k liy, lekin isy udr import ni krna.
  void isTokenRefresh() async{
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }
}