import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/User%20interest/user_interest_provider.dart';
import 'Provider/adverties/adverties_provider.dart';
import 'Provider/authentication_provider.dart';
import 'Provider/compare event/compare_event_provider.dart';
import 'Provider/contact us/contact_us_provider.dart';
import 'Provider/detail_page_provider.dart';
import 'Provider/droup_line_provider.dart';
import 'Provider/find_race_provider.dart';
import 'Provider/Home providers/home_page_provider.dart';
import 'Provider/icon_change_provider.dart';
import 'Provider/report/industries_provider.dart';
import 'Provider/profile/profile_provider.dart';
import 'Provider/review a race provider/review_a_race_provider.dart';
import 'Provider/testimonial/testimonial_provider.dart';
import 'Provider/wishlist/fav_event_add_wishlist_provider.dart';
import 'Provider/wishlist/wishlist_provider.dart';
import 'Routes/route.dart';
import 'Routes/route_names.dart';

//top leven method for notification
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title:${message.notification?.title}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

  // NotificationApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => IconChangeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FindARacesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AdveriesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthenticationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DroupUsLineProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => IndustriesReportProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReviewARaceProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TestimonialProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CompareEventProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishListProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavEventAddWishlist(),
        ),
        ChangeNotifierProvider(
          create: (_) => ContactUsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserInterestProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Racemart',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
        // navigatorKey: navigatorKey,
        initialRoute: RouteNames.splashPage,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
