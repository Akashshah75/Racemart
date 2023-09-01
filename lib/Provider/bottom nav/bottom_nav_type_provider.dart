import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Pages/Home/bottom%20nav/cycling%20page/cycling_page.dart';
import 'package:racemart_app/Pages/Home/bottom%20nav/duathlon%20page/duathlon_page.dart';
import 'package:racemart_app/Pages/Home/bottom%20nav/running%20page/running_page.dart';
import 'package:racemart_app/Pages/Home/bottom%20nav/trithalon%20page/trithlon_page.dart';
import 'package:racemart_app/Provider/Home%20providers/home_page_provider.dart';
import 'package:badges/badges.dart' as badges;

import '../../Helper/appbar/app_bar_widget.dart';
import '../../Pages/Find A Race/find_race_page.dart';
import '../../Pages/Home/Drawer/zoom_drawer.dart';
import '../../Pages/Home/home widget/home_main_widget.dart';
import '../../Pages/Wishlist/wishlist_page.dart';
import '../../Utils/app_color.dart';
import '../wishlist/wishlist_provider.dart';

class BottomnavTypeProvider with ChangeNotifier {
  Widget activeScreen = const HomeMainWidget();
  int activeIndex = 0;

  void changeBottomNavPage(int val) {
    print(val);
    if (val == 0) {
      activeScreen = const HomeMainWidget();
      activeIndex = 0;
      notifyListeners();
    } else if (val == 1) {
      activeScreen = const RunningPage();
      activeIndex = 1;
      notifyListeners();
    } else if (val == 2) {
      activeScreen = const CyclingPage();
      activeIndex = 2;
      notifyListeners();
    } else if (val == 3) {
      activeScreen = const DuathlonPage();
      activeIndex = 3;
      notifyListeners();
    } else if (val == 4) {
      activeScreen = const TrithlonPage();
      activeIndex = 4;
      notifyListeners();
    }
  }

  //method for appbar
  PreferredSizeWidget changeAppBarWidget(
      BuildContext context, HomeProvider homeProvider, double h) {
    if (activeIndex == 0) {
      return customeAppBar(context, provider: homeProvider, h: h);
    } else if (activeIndex == 1) {
      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: white,
        title: const Text(
          'Running',
          style: TextStyle(color: blackColor),
        ),
        leading: const MenuWidget(),
        actions: [
          Consumer<WishListProvider>(builder: (context, value, child) {
            return badges.Badge(
              showBadge: value.lengthOFwishlist <= 0 ? false : true,
              position: value.lengthOFwishlist > 9
                  ? badges.BadgePosition.topEnd(top: 2, end: -8)
                  : badges.BadgePosition.topEnd(top: 2, end: 1),
              badgeContent: Text(
                value.lengthOFwishlist > 9
                    ? '9+'
                    : value.lengthOFwishlist.toString(),
                style: const TextStyle(color: whiteColor),
              ),
              badgeAnimation: const badges.BadgeAnimation.rotation(
                animationDuration: Duration(seconds: 1),
                colorChangeAnimationDuration: Duration(seconds: 1),
                loopAnimation: false,
                curve: Curves.fastOutSlowIn,
                colorChangeAnimationCurve: Curves.easeInCubic,
              ),
              child: IconButton(
                padding: const EdgeInsets.only(top: 8),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const WishListPage()),
                  );
                },
                icon: const Icon(
                  Icons.favorite_border_sharp,
                  color: blackColor,
                ),
              ),
            );
          }),
          //
          IconButton(
            onPressed: () {
              homeProvider.chageListToGrid();
            },
            icon: Icon(
              homeProvider.isList ? Icons.grid_view : Icons.list,
              color: blackColor,
            ),
          ),
          // : const SizedBox(),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const FindRacePage(),
              ));
            },
            icon: const Icon(
              Icons.search,
              color: blackColor,
            ),
          )
        ],
      );
    } else if (activeIndex == 2) {
      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: white,
        title: const Text(
          'Cycling',
          style: TextStyle(color: blackColor),
        ),
        leading: const MenuWidget(),
        actions: [
          Consumer<WishListProvider>(builder: (context, value, child) {
            return badges.Badge(
              showBadge: value.lengthOFwishlist <= 0 ? false : true,
              position: value.lengthOFwishlist > 9
                  ? badges.BadgePosition.topEnd(top: 2, end: -8)
                  : badges.BadgePosition.topEnd(top: 2, end: 1),
              badgeContent: Text(
                value.lengthOFwishlist > 9
                    ? '9+'
                    : value.lengthOFwishlist.toString(),
                style: const TextStyle(color: whiteColor),
              ),
              badgeAnimation: const badges.BadgeAnimation.rotation(
                animationDuration: Duration(seconds: 1),
                colorChangeAnimationDuration: Duration(seconds: 1),
                loopAnimation: false,
                curve: Curves.fastOutSlowIn,
                colorChangeAnimationCurve: Curves.easeInCubic,
              ),
              child: IconButton(
                padding: const EdgeInsets.only(top: 8),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const WishListPage()),
                  );
                },
                icon: const Icon(
                  Icons.favorite_border_sharp,
                  color: blackColor,
                ),
              ),
            );
          }),
          //
          IconButton(
            onPressed: () {
              homeProvider.chageListToGrid();
            },
            icon: Icon(
              homeProvider.isList ? Icons.grid_view : Icons.list,
              color: blackColor,
            ),
          ),
          // : const SizedBox(),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const FindRacePage(),
              ));
            },
            icon: const Icon(
              Icons.search,
              color: blackColor,
            ),
          )
        ],
      );
    } else if (activeIndex == 3) {
      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: white,
        title: const Text(
          'Duathlon',
          style: TextStyle(color: blackColor),
        ),
        leading: const MenuWidget(),
        actions: [
          Consumer<WishListProvider>(builder: (context, value, child) {
            return badges.Badge(
              showBadge: value.lengthOFwishlist <= 0 ? false : true,
              position: value.lengthOFwishlist > 9
                  ? badges.BadgePosition.topEnd(top: 2, end: -8)
                  : badges.BadgePosition.topEnd(top: 2, end: 1),
              badgeContent: Text(
                value.lengthOFwishlist > 9
                    ? '9+'
                    : value.lengthOFwishlist.toString(),
                style: const TextStyle(color: whiteColor),
              ),
              badgeAnimation: const badges.BadgeAnimation.rotation(
                animationDuration: Duration(seconds: 1),
                colorChangeAnimationDuration: Duration(seconds: 1),
                loopAnimation: false,
                curve: Curves.fastOutSlowIn,
                colorChangeAnimationCurve: Curves.easeInCubic,
              ),
              child: IconButton(
                padding: const EdgeInsets.only(top: 8),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const WishListPage()),
                  );
                },
                icon: const Icon(
                  Icons.favorite_border_sharp,
                  color: blackColor,
                ),
              ),
            );
          }),
          //
          IconButton(
            onPressed: () {
              homeProvider.chageListToGrid();
            },
            icon: Icon(
              homeProvider.isList ? Icons.grid_view : Icons.list,
              color: blackColor,
            ),
          ),
          // : const SizedBox(),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const FindRacePage(),
              ));
            },
            icon: const Icon(
              Icons.search,
              color: blackColor,
            ),
          ),
        ],
      );
    } else {
      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: white,
        title: const Text(
          'Triathlon',
          style: TextStyle(color: blackColor),
        ),
        leading: const MenuWidget(),
        actions: [
          Consumer<WishListProvider>(builder: (context, value, child) {
            return badges.Badge(
              showBadge: value.lengthOFwishlist <= 0 ? false : true,
              position: value.lengthOFwishlist > 9
                  ? badges.BadgePosition.topEnd(top: 2, end: -8)
                  : badges.BadgePosition.topEnd(top: 2, end: 1),
              badgeContent: Text(
                value.lengthOFwishlist > 9
                    ? '9+'
                    : value.lengthOFwishlist.toString(),
                style: const TextStyle(color: whiteColor),
              ),
              badgeAnimation: const badges.BadgeAnimation.rotation(
                animationDuration: Duration(seconds: 1),
                colorChangeAnimationDuration: Duration(seconds: 1),
                loopAnimation: false,
                curve: Curves.fastOutSlowIn,
                colorChangeAnimationCurve: Curves.easeInCubic,
              ),
              child: IconButton(
                padding: const EdgeInsets.only(top: 8),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const WishListPage()),
                  );
                },
                icon: const Icon(
                  Icons.favorite_border_sharp,
                  color: blackColor,
                ),
              ),
            );
          }),
          //
          IconButton(
            onPressed: () {
              homeProvider.chageListToGrid();
            },
            icon: Icon(
              homeProvider.isList ? Icons.grid_view : Icons.list,
              color: blackColor,
            ),
          ),
          // : const SizedBox(),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const FindRacePage(),
              ));
            },
            icon: const Icon(
              Icons.search,
              color: blackColor,
            ),
          ),
        ],
      );
    }
  }
}
