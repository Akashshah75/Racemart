import 'dart:async';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Pages/Authentication/Login/login_page.dart';
import 'package:racemart_app/Provider/authentication_provider.dart';
import 'package:racemart_app/Push%20Notification/push_notification_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../Routes/route_names.dart';
import '../main.dart';

//this is top level function of background notification

class NotificationApi {
  final firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel chanel = AndroidNotificationChannel(
    Random.secure().nextInt(10000).toString(),
    'racemart',
    description: 'racemart app',
    importance: Importance.defaultImportance,
  );
  //permission handle
  void requestNotificationPermission() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      // print('User granted provision permission');
    } else {
      // print('User  denied permission');
    }
  }

//init local notification for forground
  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosIntializationSettings = const DarwinInitializationSettings();
    //
    var intializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosIntializationSettings);
    //
    await localNotificationsPlugin.initialize(
      intializationSetting,
      onDidReceiveNotificationResponse: (details) {},
    );
  }

//init method of firebase notification
  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      // print(message.notification!.title.toString());
      showNotification(message);
    });
    //
  }

  //show notification
  Future<void> showNotification(RemoteMessage message) async {
    //chanel id ,channel names
    AndroidNotificationChannel chanel = AndroidNotificationChannel(
      Random.secure().nextInt(10000).toString(),
      'racemart',
      description: 'racemart app',
      importance: Importance.defaultImportance,
    );
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      chanel.id,
      chanel.name,
      importance: Importance.max,
      priority: Priority.max,
      ticker: 'ticker',
    );
    //darawin notification details
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    //
    await localNotificationsPlugin.show(
      0,
      message.notification!.title.toString(),
      message.notification!.body.toString(),
      notificationDetails,
    );
  }

//DeviceToken//fcmtoken
  Future<String> getDeviceToken() async {
    String? token = await firebaseMessaging.getToken();
    return token!;
  }

  //token refresh
  isRefreshToken() {
    firebaseMessaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  //

  //handle message
  void handleMessage(RemoteMessage? message, BuildContext context) {
    // print('work');
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    if (provider.appLoginToken == null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const LoginPage()));
    } else {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const NotificationPage()));
    }
  }

  //
  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    //
    // FirebaseMessaging.instance
    //     .getInitialMessage()
    //     .then(handleMessage(message, context));
    // FirebaseMessaging.onMessageOpenedApp
    //     .listen(handleMessage(message, context));
    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      localNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
            chanel.id,
            chanel.name,
            channelDescription: chanel.description,
            // icon: '@drawable/ic_launcher',
          )));
    });
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android);
    await localNotificationsPlugin.initialize(settings,
        onDidReceiveNotificationResponse: (message) {
      // print(message);
    });

    final platform =
        localNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(chanel);
  }

  //
}
//

class PushNotification {
  //intialize
  final firebaseMessaging = FirebaseMessaging.instance;
  //

  //handle message method
  void handleMessage(
      RemoteMessage? message, var appToken, BuildContext context) {
    // print('*******Token*******');
    // print(appToken);
    Future.delayed(const Duration(seconds: 1), () {
      if (appToken != null && message != null) {
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
      // print('work start!');
      if (message == null) return;
      handleMessage(message, appToken, context);
    });

    //on app open
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(message, appToken, context);
    });
    //
    FirebaseMessaging.onBackgroundMessage((message) {
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
        // print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          // print(message.notification!.title);
          // print(message.notification!.body);
          // print("message.data11 ${message.data}");
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
          // print(message.notification!.title);
          // print(message.notification!.body);
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
        // print(details.payload);
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
