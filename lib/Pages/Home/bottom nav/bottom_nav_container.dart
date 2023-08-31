import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../Provider/bottom nav/bottom_nav_type_provider.dart';
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
            padding: EdgeInsets.all(15),
            tabBackgroundColor: appBg,
            gap: 5,
            onTabChange: (val) {
              bottomNavprovider.changeBottomNavPage(val);
            },
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: FontAwesomeIcons.personRunning,
                text: 'Running',
              ),
              GButton(
                icon: FontAwesomeIcons.personWalking,
                text: 'Walking',
              ),
              GButton(
                icon: FontAwesomeIcons.personBiking,
                text: ' Cycling',
              ),
            ]),
      ),
    );
  }
}
