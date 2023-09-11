import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:racemart_app/Pages/Authentication/Login/login_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification list/notification_list_page.dart';

//this is top level function of background notification
class NotificationFeat {
  final firebaseMessaging = FirebaseMessaging.instance;

  //request for permission
  Future<dynamic> requestNotificationPermission() async {
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
    print('fcmToken:$fcmToken');
    return fcmToken;
  }

  //
  // 1. This method call when app in terminated state and you get a notification
  //when you click on notification app open from terminated state and you can get notification data in this method
//
  Future<void> terminateStateAppNotificationMethod(
      BuildContext context, var apptoken) async {
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        // print("FirebaseMessaging.instance.getInitialMessage");
        if (message == null) return;
        if (apptoken != null) {
          // print("New Notification");
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NotificationListPage()
                // NotificationDetailPage(eventId: message.data['id']),
                ),
          );
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) =>
          //         NotificationDetailPage(eventId: message.data['id']),
          //   ),
          // );
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
        if (message.notification != null) {
          // print(message);

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

  // 3. This method only call when App in background and not terminated(not closed)
  Future<void> appIsBgNotCloseNotificationMethod(
      var apptoken, BuildContext context) async {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        if (apptoken != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => const NotificationListPage()),
          );
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) =>
          //         NotificationDetailPage(eventId: message.data['id']),
          //   ),
          // );
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
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        // print(jsonDecode(notificationResponse.payload!));
        // print('details :${jsonDecode(notificationResponse.payload!)}');
        //pa load for notification
        // final eventId = jsonDecode(notificationResponse.payload!);
        if (apptoken != null) {
          // print("New Notification");
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NotificationListPage()
                // NotificationDetailPage(eventId: message.data['id']),
                ),
          );
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //       builder: (context) => NotificationDetailPage(eventId: eventId)),
          // );
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
        payload: message.data['id'],
      );
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
