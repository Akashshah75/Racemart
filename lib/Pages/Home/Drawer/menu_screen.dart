import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/authentication_provider.dart';
import 'package:racemart_app/Provider/profile/profile_provider.dart';
import 'package:racemart_app/Utils/constant.dart';
import '../../../Routes/route_names.dart';
import '../../../Utils/app_asset.dart';
import '../../../utils/app_color.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen(
      {super.key, required this.currentItem, required this.onSelectedItem});
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthenticationProvider>(context, listen: true);
    final profileProvider = Provider.of<ProfileProvider>(context, listen: true);
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: blueColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteNames.profilePage);
                },
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: profileProvider.mapOfProfileData['profile'] != null
                          ? DecorationImage(
                              image: NetworkImage(
                                profileProvider.mapOfProfileData['profile'],
                              ),
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(noImageProfile),
                            ),
                      border: Border.all(color: whiteColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  profileProvider.mapOfProfileData['name'] ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ...MenuItems.all.map(buildMenuItem).toList(),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // provider.removeToken();
                  // print('logOut');
                  provider.logOut(context).then((value) {
                    if (value) {
                      provider.removeToken();
                      Navigator.of(context)
                          .pushReplacementNamed(RouteNames.splashPage);
                    } else {
                      toastMessage('Unauthenticated token');
                    }
                  });
                  //
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 10),
                  width: 130,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: whiteColor,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      provider.isLogOut
                          ? const Text('...')
                          : const Icon(Icons.lock),
                      const SizedBox(width: 10),
                      const Text(
                        'Logout',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //
  Widget buildMenuItem(MenuItem item) => ListTileTheme(
        selectedColor: whiteColor,
        child: ListTile(
          selectedTileColor: Colors.black26,
          selected: currentItem == item,
          minLeadingWidth: 20,
          leading: Icon(
            item.icon,
          ),
          title: Text(
            item.title,
          ),
          onTap: () => onSelectedItem(item),
        ),
      );
}

class MenuItems {
  static const home = MenuItem('Home', Icons.home);
  static const receReview = MenuItem('Review a race', Icons.reviews);
  static const findRace = MenuItem('Find a race', Icons.search);
  static const adOnline = MenuItem('Advertise online', Icons.ad_units);
  static const aboutUs = MenuItem('About us', Icons.info);
  static const contactUs = MenuItem('Contact us', Icons.info);
  static const compareEvent = MenuItem('Compare event', Icons.compare);
  static const industriesReport =
      MenuItem('Industry report', Icons.report_outlined);
  //
  static List<MenuItem> all = [
    home,
    receReview,
    findRace,
    compareEvent,
    adOnline,
    industriesReport,
    contactUs,
    aboutUs,
  ];
}

class MenuItem {
  final String title;
  final IconData icon;
  const MenuItem(this.title, this.icon);
}
