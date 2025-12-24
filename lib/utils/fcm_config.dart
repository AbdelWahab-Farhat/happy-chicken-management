
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FcmConfig {
  static Future<String?> getToken() async {
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {

    });
    String? token = await FirebaseMessaging.instance.getToken();
    return token;
  }

  static Future<void> init() async {
    final NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        // icon: '@drawable/ic_notification',
        'daily_channel_id',
        "Daily Notification",
        playSound: true,
        channelDescription: "Daily Notification",
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('sound'),
      ),
      iOS: DarwinNotificationDetails(
        sound: 'sound',
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettingsIos = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      defaultPresentSound: true,
      defaultPresentAlert: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initSettingsIos,
    );

    var token = await FirebaseMessaging.instance.getToken();
    log(token ?? 'no token');


    PermissionStatus permissionStatus = await Permission.notification.status;
    if (permissionStatus == PermissionStatus.denied) {
      await Permission.notification.request();
    }

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.instance
      ..requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
      )
      ..subscribeToTopic('messages')
      ..subscribeToTopic('reviews')
      ..subscribeToTopic('reminders')
      ..subscribeToTopic('announcements')
      ..setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        FlutterLocalNotificationsPlugin().show(
          notification.hashCode,
          notification.title,
          notification.body,
          notificationDetails,
        );
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // if (message.data.isNotEmpty) {
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => null,));
      // }
    });
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  // if (message.data.isNotEmpty) {}
  // await Firebase.initializeApp();
}
