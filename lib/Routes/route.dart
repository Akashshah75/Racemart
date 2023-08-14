import 'package:flutter/material.dart';
import 'package:racemart_app/Pages/Splash/splash_screen.dart';
import 'package:racemart_app/Routes/route_names.dart';
import '../Pages/About us/about_us_page.dart';
import '../Pages/Authentication/Forget_password/forget_password_page.dart';
import '../Pages/Authentication/Login/login_page.dart';
import '../Pages/Authentication/Sign_up/signup_page.dart';
import '../Pages/Home/Drawer/zoom_drawer.dart';
import '../Pages/Profile/profile_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashPage:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RouteNames.loginPage:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case RouteNames.signUpPage:
        return MaterialPageRoute(
          builder: (context) => const SignUpPage(),
        );
      case RouteNames.forgetPasswordPage:
        return MaterialPageRoute(
          builder: (context) => const ForgetPasswordPage(),
        );
      case RouteNames.homePage:
        return MaterialPageRoute(
          builder: (context) => const ZoomDrawerPage(),
        );
      case RouteNames.aboutUsPage:
        return MaterialPageRoute(
          builder: (context) => const AboutUsPage(),
        );
      case RouteNames.profilePage:
        return MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        );
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No Route Define'),
            ),
          );
        });
    }
  }
}
