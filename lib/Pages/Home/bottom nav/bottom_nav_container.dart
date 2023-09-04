import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../Provider/bottom nav/bottom_nav_type_provider.dart';
import '../../../Utils/app_color.dart';

class BottomNavigationContainer extends StatelessWidget {
  const BottomNavigationContainer({
    super.key,
    required this.bottomNavprovider,
    required this.size,
  });

  final BottomnavTypeProvider bottomNavprovider;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: white,
      height: size.height * 0.1,
      width: size.width * 1,
      child: GNav(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          tabBackgroundColor: appBg,
          gap: 8,
          onTabChange: (val) {
            bottomNavprovider.changeBottomNavPage(val);
          },
          tabs: [
            const GButton(
              icon: Icons.home,
              text: 'Home',
              iconSize: 20,
            ),
            const GButton(
              icon: FontAwesomeIcons.personRunning,
              text: 'Running',
              iconSize: 20,
            ),
            const GButton(
              icon: FontAwesomeIcons.personBiking,
              text: 'Cycling',
              iconSize: 20,
            ),
            GButton(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              leading: SizedBox(
                height: 40,
                width: 40,
                child: Image.asset(
                  'asset/image/duathlonicon.png',
                  // height: 35,
                ),
              ),
              icon: FontAwesomeIcons.personBiking,
              text: 'Duathlon',
            ),
            GButton(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              leading: SizedBox(
                height: 40,
                width: 40,
                child: Image.asset(
                  'asset/image/app icons_tri.png',
                ),
              ),
              icon: FontAwesomeIcons.personBiking,
              text: 'Triathlon',
            ),
          ]),
    );
  }
}
