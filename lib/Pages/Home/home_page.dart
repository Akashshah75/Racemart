import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Pages/Home/home%20widget/home_main_widget.dart';
import 'package:racemart_app/Provider/Home%20providers/home_page_init_methods.dart';
import 'package:racemart_app/Provider/advertiesment/advertiesment_provider.dart';
import 'package:racemart_app/Provider/bottom%20nav/bottom_nav_type_provider.dart';
import '../../Provider/Home providers/home_page_provider.dart';
import '../../Utils/app_color.dart';
import '../../Utils/constant.dart';
import 'bottom nav/bottom_nav_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final bottomNavprovider =
        Provider.of<BottomnavTypeProvider>(context, listen: false);
    bottomNavprovider.activeScreen = const HomeMainWidget();
    bottomNavprovider.activeIndex = 0;
    HomePageInit().notificationMethods(context);
    HomePageInit().addProductOnWishlistPageMethod(context);
    Future.delayed(const Duration(milliseconds: 750), () {
      final advertiesmentProvider =
          Provider.of<AdvertiesmentProvider>(context, listen: false);
      if (advertiesmentProvider.homePageAdvertisementpopUp.isNotEmpty) {
        HomePageInit().openDialog(context);
      }
      // if (advertiesmentProvider.horizontalAdvertismentData.isNotEmpty) {
      //   HomePageInit().openDialog(context);
      // }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    DateTime timeBackPressed = DateTime.now();
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);
    final bottomNavprovider =
        Provider.of<BottomnavTypeProvider>(context, listen: true);
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
          backgroundColor: white,
          appBar:
              bottomNavprovider.changeAppBarWidget(context, homeProvider, h),
          body: bottomNavprovider.activeScreen,
          bottomNavigationBar: BottomNavigationContainer(
            bottomNavprovider: bottomNavprovider,
            size: size,
          ),
        ),
      ),
    );
  }
}
