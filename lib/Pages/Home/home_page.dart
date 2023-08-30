import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/Home%20providers/home_page_init_methods.dart';
import '../../Helper/appbar/app_bar_widget.dart';
import '../../Provider/Home providers/home_page_provider.dart';
import '../../Utils/app_color.dart';
import '../../Utils/constant.dart';
import 'home widget/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    HomePageInit().notificationMethods(context);
    HomePageInit().addProductOnWishlistPageMethod(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    DateTime timeBackPressed = DateTime.now();
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);
    return DefaultTabController(
      length: 5,
      child: WillPopScope(
        onWillPop: () async {
          final diffrence = DateTime.now().difference(timeBackPressed);
          final isExitWarning = diffrence >= const Duration(seconds: 2);
          timeBackPressed = DateTime.now();
          return exitTheAppMethod(isExitWarning);
        },
        child: Scaffold(
          backgroundColor: white, //appbg,
          appBar: customeAppBar(context, provider: homeProvider, h: h),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                homeWidget(homeProvider),
              ],
            ),
          ),
          bottomNavigationBar: GNav(tabs: [
            GButton(
              icon: Icons.home,
              gap: 5,
              text: 'Home',
            ),
            GButton(
              icon: FontAwesomeIcons.personRunning,
              gap: 5,
              text: 'Running',
            ),
            GButton(
              icon: FontAwesomeIcons.personWalking,
              gap: 5,
              text: 'Walking',
            ),
            GButton(
              icon: FontAwesomeIcons.personBiking,
              gap: 5,
              text: ' Cycling',
            ),
          ]),
        ),
      ),
    );
  }
}
