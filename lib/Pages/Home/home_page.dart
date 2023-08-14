import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/find_race_provider.dart';
import 'package:racemart_app/Provider/profile/profile_provider.dart';

import '../../Helper/appbar/app_bar_widget.dart';
import '../../Provider/Home providers/home_page_provider.dart';
import '../../Provider/wishlist/wishlist_provider.dart';
import '../../Utils/app_color.dart';
import '../User interst/user_interest.dart';
import 'Components/event_in_mumbai.dart';
import 'Components/explore_best_cities.dart';
import 'Components/home_race_listing_event.dart';
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
    Future.delayed(Duration.zero, () async {
      final wishProvider =
          Provider.of<WishListProvider>(context, listen: false);
      wishProvider.wishListEvent(context);
      Future.delayed(const Duration(milliseconds: 800), () {
        wishProvider.checkId(context);
      });
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      final findProvider =
          Provider.of<FindARacesProvider>(context, listen: false);
      homeProvider.upcomingEvent(context);
      homeProvider.getCurrentPosition(context);
      homeProvider.listOfCities();
      homeProvider.listOfDistances();
      homeProvider.listOfBades();
      homeProvider.listOfPartners();
      homeProvider.listOfAllType();
      homeProvider.fetchTerrainsData();
      homeProvider.userInterest(context);
      //
      homeProvider.latestListing(context);
      homeProvider.exploreCity(context);

      // Future.delayed(const Duration(milliseconds: 1000), () {
      //   homeProvider.findACity(homeProvider.lat!.toDouble(),
      //       homeProvider.long!.toDouble(), context);
      // });

      //profiel
      profileProvider.fetchProfileData(context);
      // homeProvider.eventOfMumbai(context);
      //clear
      findProvider.searchListData.clear();
      findProvider.lookingFor.clear();
      homeProvider.choseAllType = '';
      findProvider.startDate.clear();
      findProvider.endDate.clear();
      homeProvider.choseCity = '';
      homeProvider.listOfDistanceData.clear();
      homeProvider.listOfBadgeData.clear();
      homeProvider.listOfPartnersData.clear();
      homeProvider.listOfTerrains.clear();
      homeProvider.listOfCitiesData.clear();
      homeProvider.listOfType.clear();
      //
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);
    // print(AuthenticationProvider.appToken);
    return DefaultTabController(
      length: 5,
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor: white, //appbg,
          appBar: customeAppBar(context),
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
        return HomeRaceListingEvent(provider: provider);
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
