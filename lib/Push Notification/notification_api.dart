import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:racemart_app/Pages/Authentication/Login/login_page.dart';
import 'package:racemart_app/Push%20Notification/push_notification_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../Routes/route_names.dart';
import '../main.dart';

//this is top level function of background notification

class PushNotification {
  //intialize
  final firebaseMessaging = FirebaseMessaging.instance;
  //handle message method
  void handleMessage(
      RemoteMessage? message, var appToken, BuildContext context) {
    // print('*******Token*******');
    // print(appToken);
    Future.delayed(const Duration(seconds: 1), () {
      if (appToken != null && message != null) {
        print(message.notification!.title);
        // print('Work apptoken');
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NotificationPage()));
      } else {
        // print('not Work apptoken');
        Navigator.of(context).pushNamed(RouteNames.loginPage);
      }
    });
  }

  //
  Future initPushnotification(var appToken, BuildContext context) async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    //
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print(message!.notification!.title);
      // print('work start!');
      if (message == null) return;
      handleMessage(message, appToken, context);
    });

    //on app open
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message.notification!.title);
      handleMessage(message, appToken, context);
    });
    //
    FirebaseMessaging.onBackgroundMessage((message) {
      print(message.notification!.title);
      return handleBackgroundMessage(message);
    });
  }

  //init notification method
  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
    if (kDebugMode) {
      print('Token:$fcmToken');
    }
    //
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
//

class NotificationFeat {
  final firebaseMessaging = FirebaseMessaging.instance;

  // 1. This method call when app in terminated state and you get a notification
  //when you click on notification app open from terminated state and you can get notification data in this method
//
  Future<void> terminateStateAppNotificationMethod(
      BuildContext context, var apptoken) async {
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print(message!.notification!.title);
        // print("FirebaseMessaging.instance.getInitialMessage");
        if (message == null) return;
        if (apptoken != null) {
          // print("New Notification");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NotificationPage(),
            ),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        }
      },
    );
  }
  //

  // 2. This method only call when App in forground it mean app must be opened
  Future<void> forgroundStateAppNotificationMethod(
      BuildContext context, var apptoken) async {
    FirebaseMessaging.onMessage.listen(
      (message) {
        print(message.notification!.title);
        // print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
        //
        // if (apptoken != null) {
        //   print("New Notification");
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => const NotificationPage(),
        //     ),
        //   );
        // } else {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => const LoginPage(),
        //     ),
        //   );
        // }
      },
    );
    //
  }
  //

  // 3. This method only call when App in background and not terminated(not closed)
  Future<void> appIsBgNotCloseNotificationMethod(
      var apptoken, BuildContext context) async {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        // print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
        }
        //baground done
        if (apptoken != null) {
          // print("New Notification");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NotificationPage(),
            ),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        }
      },
    );
  }
  //
}

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  //
  static void initialize(var apptoken, BuildContext context) {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );
//
    localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print(details);
        if (apptoken != null) {
          // print("New Notification");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NotificationPage(),
            ),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        }
      },
    );
  }

  //create chanal
  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "racemart",
          "racemart",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await localNotificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['_id'],
      );
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
