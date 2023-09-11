import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/advertiesment/advertiesment_provider.dart';
import 'package:racemart_app/Utils/app_color.dart';
import 'package:racemart_app/Utils/constant.dart';

import '../../Pages/Push Notification/notification_api.dart';
import '../../Utils/app_asset.dart';
import '../authentication_provider.dart';
import '../find_race_provider.dart';
import '../profile/profile_provider.dart';
import '../wishlist/wishlist_provider.dart';
import 'home_page_provider.dart';

class HomePageInit {
  //homepage provider methods
  void homePageIntiMehod(BuildContext context) {
    //intialize all  provider
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final findProvider =
        Provider.of<FindARacesProvider>(context, listen: false);
    // final advertiesmentProvider =
    //     Provider.of<AdvertiesmentProvider>(context, listen: false);
    // //adverment
    // advertiesmentProvider.fetchAdvertismentData(context);
    // homeProvider.upcomingEvent(context);
    homeProvider.getCurrentPosition(context);
    homeProvider.listOfCities();
    homeProvider.listOfDistances();
    homeProvider.listOfBades();
    homeProvider.listOfPartners();
    homeProvider.listOfAllType();
    homeProvider.fetchTerrainsData();
    homeProvider.userInterest(context);
    homeProvider.latestListing(context);
    homeProvider.exploreCity(context);
    //profile
    profileProvider.fetchProfileData(context);
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
      // wishProvider.fetch(context);
      //after wishlist then complete homepage methods
      // Future.delayed(const Duration(milliseconds: 800), () {
      //   wishProvider.checkId(context);
      // });
      HomePageInit().homePageIntiMehod(context);
    });
  }

  //oprn advertisment dialog
  Future openDialog(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final advertiesmentProvider =
    //     Provider.of<AdvertiesmentProvider>(context, listen: false);
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>
            Consumer<AdvertiesmentProvider>(builder: (context, value, child) {
              // final adverstismentData = value.horizontalAdvertismentData;
              final adverstismentData = value.shuffleList;

              // final adverstismentData = value.verticleAdvertismentData;
              // List getSuffledAnswer() {
              //   final suffeldList = List.of(adverstismentData);
              //   suffeldList.shuffle();
              //   return suffeldList;
              // }

              return AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: Container(
                  color: appBg,
                  height: size.height * 0.6,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: size.height * 0.6,
                        width: double.infinity,
                        child: adverstismentData.isNotEmpty
                            ? InkWell(
                                onTap: () {
                                  final Uri uri =
                                      Uri.parse(adverstismentData[0]['url']);
                                  launchUrls(uri);
                                },
                                child: Image.network(
                                  adverstismentData[0]['image'],
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.asset(
                                demo,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: blackColor,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
//for advertisment init
}
