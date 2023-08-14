import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../utils/app_color.dart';
import '../../About us/about_us_page.dart';
import '../../Advertise Online/advertise_online_page.dart';
import '../../Compare Event/compare_event_page.dart';
import '../../Contact Us/contact_us_page.dart';
import '../../Find A Race/find_race_page.dart';
import '../../Industries Report/industries_report_listing_page.dart';
import '../../Review a race/review_a_race_page.dart';
import '../home_page.dart';
import 'menu_screen.dart';

class ZoomDrawerPage extends StatefulWidget {
  const ZoomDrawerPage({super.key});

  @override
  State<ZoomDrawerPage> createState() => _ZoomDrawerPageState();
}

class _ZoomDrawerPageState extends State<ZoomDrawerPage> {
  MenuItem currentItem = MenuItems.home;
  @override
  Widget build(BuildContext context) => ZoomDrawer(
        duration: const Duration(milliseconds: 250),
        menuBackgroundColor: whiteColor,
        menuScreen: Builder(builder: (context) {
          return MenuScreen(
            currentItem: currentItem,
            onSelectedItem: (item) {
              setState(() {
                currentItem = item;
                //close zoom
              });
              ZoomDrawer.of(context)!.close();
            },
          );
        }),
        mainScreen: getScreen(),
      );
  //
  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.home:
        return const HomePage();
      case MenuItems.receReview:
        return const ReviewARacePage();
      case MenuItems.findRace:
        return const FindARacePage();
      case MenuItems.compareEvent:
        return const CompareEventPage();
      case MenuItems.adOnline:
        return const AdvertiesOnlinePage();
      case MenuItems.industriesReport:
        return const IndustriesReportListingPage();
      case MenuItems.contactUs:
        return const ContactUsPage();
      case MenuItems.aboutUs:
        return const AboutUsPage();
      default:
        return Container();
    }
  }
}

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () => ZoomDrawer.of(context)!.toggle(),
        icon: const Icon(
          Icons.menu,
          color: blackColor,
        ),
      );
}
