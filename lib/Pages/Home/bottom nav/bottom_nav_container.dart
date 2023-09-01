import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../Provider/bottom nav/bottom_nav_type_provider.dart';
import '../../../Utils/app_asset.dart';
import '../../../Utils/app_color.dart';

class BottomNavigationContainer extends StatelessWidget {
  const BottomNavigationContainer({
    super.key,
    required this.bottomNavprovider,
  });

  final BottomnavTypeProvider bottomNavprovider;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GNav(
            padding: const EdgeInsets.all(15),
            tabBackgroundColor: appBg,
            gap: 8,
            onTabChange: (val) {
              bottomNavprovider.changeBottomNavPage(val);
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: FontAwesomeIcons.personRunning,
                text: 'Running',
              ),
              GButton(
                icon: FontAwesomeIcons.personBiking,
                text: 'Cycling',
                iconSize: 24,
              ),
              GButton(
                leading: Image(
                  image: AssetImage(duathlonIcon),
                  color: blackColor,
                  width: 24,
                ),
                icon: FontAwesomeIcons.personBiking,
                text: 'Duathlon',
              ),
              GButton(
                leading: Image(
                  image: AssetImage(trithlonIcon),
                  color: blackColor,
                  width: 25,
                ),
                icon: FontAwesomeIcons.personBiking,
                text: 'Triathlon',
              ),
            ]),
      ),
    );
  }
}
