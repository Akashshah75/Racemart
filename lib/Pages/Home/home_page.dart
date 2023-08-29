import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/Home%20providers/home_page_init_methods.dart';
import '../../Helper/appbar/app_bar_widget.dart';
import '../../Provider/Home providers/home_page_provider.dart';
import '../../Utils/app_color.dart';
import '../../Utils/constant.dart';
import '../User interst/user_interest.dart';
import 'Components/event_in_mumbai.dart';
import 'Components/explore_best_cities.dart';
import 'Components/upcoming race/upcoming_race_listing_page.dart';
import 'Components/testimonial_list.dart';
import 'Components/the_latest_listing.dart';

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
        ),
      ),
    );
  }

  homeWidget(HomeProvider provider) {
    switch (provider.selectedIndex) {
      case 0:
        return UpcomingRaceListingPage(provider: provider);
      //HomeListingEvent()
      case 1:
        return UserInterestPage(provider: provider);
      case 2:
        return TheLatestListing(provider: provider);
      case 3:
        return ExploreBestCities(
          provider: provider,
        );
      case 4:
        return EventInCity(
          provider: provider,
        );
      case 5:
        return const TestimonialListOfHome();
      default:
        return Container();
    }
  }
}
