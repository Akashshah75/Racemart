import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
            GButton(
              leading: SizedBox(
                height: 24,
                width: 24,
                child: SvgPicture.asset('asset/image/app icons_home.svg'),
              ),
              icon: Icons.home,
              text: 'Home',
              iconSize: 20,
            ),
            GButton(
              leading: SizedBox(
                  height: 24,
                  width: 24,
                  child: SvgPicture.asset('asset/image/app icons_running.svg')),
              icon: FontAwesomeIcons.personRunning,
              text: 'Running',
              iconSize: 20,
            ),
            GButton(
              leading: SizedBox(
                height: 24,
                width: 24,
                child: SvgPicture.asset('asset/image/app_cycling_icon.svg'),
              ),
              icon: FontAwesomeIcons.personBiking,
              text: 'Cycling',
              iconSize: 20,
            ),
            GButton(
              leading: SizedBox(
                height: 24,
                width: 24,
                child: Image.asset('asset/image/duathlonicon.png'),
                //     SvgPicture.asset(
                //   'asset/image/app icons_dual.svg',
                //   height: 24,
                //   width: 24,
                // ),
              ),
              icon: FontAwesomeIcons.personBiking,
              text: 'Duathlon',
            ),
            GButton(
              leading: SizedBox(
                height: 24,
                width: 24,
                child: Image.asset(
                  'asset/image/app icons_tri.png',
                ),
                //     SvgPicture.asset(
                //   'asset/image/tri.svg',
                //   fit: BoxFit.cover,
                //   height: 40,
                //   width: 40,
                // ),
              ),
              icon: FontAwesomeIcons.personBiking,
              text: 'Triathlon',
            ),
          ]),
    );
  }
}
 // height: 24,
                // width: 24,