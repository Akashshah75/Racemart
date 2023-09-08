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
                height: 19,
                width: 19,
                child: SvgPicture.asset('asset/image/app icons_home.svg'),
              ),
              icon: Icons.home,
              text: 'Home',
              iconSize: 15,
            ),
            GButton(
              leading: SizedBox(
                  height: 19,
                  width: 19,
                  child: SvgPicture.asset('asset/image/app icons_running.svg')),
              icon: FontAwesomeIcons.personRunning,
              text: 'Running',
              iconSize: 15,
            ),
            GButton(
              leading: SizedBox(
                height: 19,
                width: 19,
                child: SvgPicture.asset('asset/image/app_cycling_icon.svg'),
              ),
              icon: FontAwesomeIcons.personBiking,
              text: 'Cycling',
              iconSize: 15,
            ),
            GButton(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              leading: SizedBox(
                width: 40,
                height: 40,
                child: Image.asset('asset/image/duathlonicon.png'),
              ),
              icon: FontAwesomeIcons.personBiking,
              text: 'Duathlon',
            ),
            GButton(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              leading: SizedBox(
                width: 40,
                height: 40,
                child: Image.asset('asset/image/app icons_tri.png'),
              ),
              icon: Icons.abc,
              text: 'Triathlon',
            ),
          ]),
    );
  }
}
