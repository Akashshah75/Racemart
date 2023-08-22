import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/authentication_provider.dart';
import 'package:racemart_app/Routes/route_names.dart';
import 'package:racemart_app/Utils/app_asset.dart';

import '../../Provider/wishlist/wishlist_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    provider.getUserToken();

    // print(provider.appLoginToken);
    Future.delayed(const Duration(seconds: 1), () async {
      final wishProvider =
          Provider.of<WishListProvider>(context, listen: false);
      wishProvider.wishListEvent(context);
      Future.delayed(const Duration(milliseconds: 800), () {
        wishProvider.checkId(context);
      });
      var token = provider.appLoginToken;
      if (kDebugMode) {
        print(token);
      }
      changePage(token.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(bgLoginPage),
              const Text('Racemart'),
              const SizedBox(height: 20),
              const Text(
                'Loading...',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changePage(String token) {
    if (token == 'null' || token == '' || token.isEmpty) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pushNamed(RouteNames.loginPage);
        // Navigator.of(context).pushReplacementNamed(RouteNames.loginPage);
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pushNamed(RouteNames.homePage);
        // Navigator.of(context).pushReplacementNamed(RouteNames.homePage);
        // Navigator.of(context).pushNamed(RouteNames.homePage);
      });
    }
  }
}
