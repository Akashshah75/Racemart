import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Push Notification/notification_api.dart';
import '../authentication_provider.dart';
import '../find_race_provider.dart';
import '../profile/profile_provider.dart';
import '../wishlist/wishlist_provider.dart';
import 'home_page_provider.dart';

class HomePageInit {
  //homepage provider methods
  void homePageIntiMehod(BuildContext context) {
    //intialize all three provider
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final findProvider =
        Provider.of<FindARacesProvider>(context, listen: false);
    // homeProvider.upcomingEvent(context);
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
  }

  //all notification method
  void notificationMethods(
    BuildContext context,
  ) {
    NotificationFeat notification = NotificationFeat();
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    //
    LocalNotificationService.initialize(provider.appLoginToken, context);
    //when app is terminate state
    notification.terminateStateAppNotificationMethod(
        context, provider.appLoginToken);
    //when app is forground state
    notification.forgroundStateAppNotificationMethod(
        context, provider.appToken);
    //
    notification.appIsBgNotCloseNotificationMethod(
        provider.appLoginToken, context);
  }

  //home page add product on wishlist method

  void addProductOnWishlistPageMethod(BuildContext context) {
    //intialized wishlist provider
    Future.delayed(Duration.zero, () async {
      final wishProvider =
          Provider.of<WishListProvider>(context, listen: false);
      wishProvider.wishListEvent(context);
      //after wishlist then complete homepage methods
      Future.delayed(const Duration(milliseconds: 800), () {
        wishProvider.checkId(context);
      });
      HomePageInit().homePageIntiMehod(context);
    });
  }
}
