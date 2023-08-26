import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'Routes/route.dart';
import 'Routes/route_names.dart';
import 'Utils/Models/provider_list.dart';

//top leven method for notification
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  // print('Title:${message.notification?.title}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProvider.providers, //providers,
      child: MaterialApp(
        title: 'Racemart',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
        initialRoute: RouteNames.splashPage,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
