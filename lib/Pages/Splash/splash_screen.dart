import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/authentication_provider.dart';
import 'package:racemart_app/Routes/route_names.dart';
import 'package:racemart_app/Utils/app_asset.dart';

import '../../Provider/advertiesment/advertiesment_provider.dart';
import '../../Provider/wishlist/wishlist_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //
  @override
  void initState() {
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    provider.getUserToken();
    // print(provider.appLoginToken);
    Future.delayed(const Duration(seconds: 1), () async {
      //notification
      //wishlist
      final wishProvider =
          Provider.of<WishListProvider>(context, listen: false);
      // wishProvider.fetch(context);
      // Future.delayed(const Duration(milliseconds: 800), () {
      //   wishProvider.checkId(context);
      // });
      wishProvider.wishListEvent(context);
      // Future.delayed(const Duration(milliseconds: 800), () {
      //   wishProvider.checkId(context);
      // });
      var token = provider.appLoginToken;
      if (kDebugMode) {
        print(token);
      }
      final advertiesmentProvider =
          Provider.of<AdvertiesmentProvider>(context, listen: false);
      //adverment
      advertiesmentProvider.fetchAdvertismentData(context);
      // notification.initNotifications(provider.appLoginToken, context);
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
              Image.asset(
                appLogo,
                width: 120,
              ),
              // SvgPicture.asset(appLogo),
              const Text('Racemart'),
              const SizedBox(height: 20),
              // const Text(
              //   'Loading...',
              //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              // ),
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
