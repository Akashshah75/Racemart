import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Network/url.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Network/base_clent.dart';
import '../authentication_provider.dart';
import '../wishlist/wishlist_provider.dart';

class HomeProvider with ChangeNotifier {
  int selectedIndex = 0;
  int currentPage = 0;
  //

  //
  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void changePage(int index) {
    currentPage = index;
    notifyListeners();
  }

  //upcoming
  List<dynamic> upcomingEventList = [];
  bool isLoading = false;
  bool isFav = false;
  String url = '';
  //the latest listing
  List<dynamic> theLatestListing = [];
  bool isLoadingForLatestListing = false;
  //
  //explore best city
  List<dynamic> exploreBestCities = [];
  bool isLoadingForexploreBestCities = false;
  //
  //event in city //mumbai
  List<dynamic> eventInMumbai = [];
  bool isLoadingForeventInMumbai = false;
  //
  String city = 'mumbai';
  bool getMyCity = false;
  double? lat;
  double? long;
  //
  //1.list of city
  List listOfCitiesNames = [];
  List listOfCitiesData = [];
  void changeCitiesData(var val) {
    listOfCitiesData = val;
    notifyListeners();
  }

  String choseCity = '';
  void changeDropDownVal(var val) {
    choseCity = val;
    notifyListeners();
  }

  //2.distance list
  List listOfDetancesNames = [];
  List listOfDistanceData = [];
  void changeDistance(var val) {
    listOfDistanceData = val;
    notifyListeners();
  }

  //3.badeg list
  List listOfBadgeNames = [];
  List listOfBadgeData = [];
  void changeBadge(var val) {
    listOfBadgeData = val;
    notifyListeners();
  }

  //4.patners
  List listOfPartnersNames = [];
  List listOfPartnersData = [];
  void changePartners(var val) {
    listOfPartnersData = val;
    notifyListeners();
  }

  //5.all type list
  List listOfAllTypeData = [];
  String choseAllType = '';
  // int choseAllType = 0;
  List listOfType = [];
  void changeType(var val) {
    listOfType = val;
    notifyListeners();
  }

  //
  void changeAllType(var val) {
    choseAllType = val;
    notifyListeners();
  }

  ///
  List listOfTerrainsData = [];
  List listOfTerrains = [];
  void changeTrainsData(var val) {
    listOfTerrains = val;
  }

  //upcoming events
  Future<void> upcomingEvent(BuildContext context) async {
    final wishProvider = Provider.of<WishListProvider>(context, listen: false);
    wishProvider.wishListEvent(context).then((_) {
      wishProvider.checkId(context);
    });
    // Future.delayed(const Duration(milliseconds: 1500), () {});
    //
    isLoading = true;
    isFav = true;
    notifyListeners();
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);

    var response = await BaseClient()
        .getMethodWithToken(upcominEventUrl, provider.appLoginToken.toString());
    // print(response);
    //
    upcomingEventList = [];
    isLoading = false;
    isFav = false;
    notifyListeners();
    var result = jsonDecode(response);
    //

    // url = '';
    if (result['status'] == 'success') {
      //
      upcomingEventList = result['data']['list'];
      notifyListeners();
      url = result['data']['first_page_url'];
      notifyListeners();
    }
  }

  //guest apis
  //1.cities
  Future<void> listOfCities() async {
    var response = await BaseClient().getMethodWithOutToken(citiesUrl);
    var result = jsonDecode(response);
    listOfCitiesNames = [];
    if (result['status'] == 'success') {
      listOfCitiesNames = result['data'];
    }
    notifyListeners();
  }

  //2.distances
  Future<void> listOfDistances() async {
    var response = await BaseClient().getMethodWithOutToken(distancesUrl);
    var result = jsonDecode(response);
    listOfDetancesNames = [];
    if (result['status'] == 'success') {
      listOfDetancesNames = result['data'];
      notifyListeners();
    }
  }

//3.badeg
  Future<void> listOfBades() async {
    var response = await BaseClient().getMethodWithOutToken(badgesUrl);

    var result = jsonDecode(response);

    listOfBadgeNames = [];
    if (result['status'] == 'success') {
      listOfBadgeNames = result['data'];
    }
    notifyListeners();
  }

// 4.parteners
  Future<void> listOfPartners() async {
    var response = await BaseClient().getMethodWithOutToken(partnersUrl);

    var result = jsonDecode(response);

    listOfPartnersNames = [];
    if (result['status'] == 'success') {
      listOfPartnersNames = result['data'];
    }
    notifyListeners();
  }

//5.all type
  Future<void> listOfAllType() async {
    var response = await BaseClient().getMethodWithOutToken(categoriesUrl);

    var result = jsonDecode(response);

    listOfAllTypeData = [];

    if (result['status'] == 'success') {
      listOfAllTypeData = result['data'];
      notifyListeners();
    }
  }

  //6.terrains list data
  Future<void> fetchTerrainsData() async {
    var response = await BaseClient().getMethodWithOutToken(terrainsUrl);
    var result = jsonDecode(response);

    listOfTerrainsData = [];

    if (result['status'] == 'success') {
      listOfTerrainsData = result['data'];
      notifyListeners();
    }
  }

  ///////////////////////////

  //latest listing
  Future<void> latestListing(BuildContext context) async {
    isLoadingForLatestListing = true;
    notifyListeners();
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient().getMethodWithToken(
        latestListingEventUrl, provider.appLoginToken.toString());
    isLoading = false;
    notifyListeners();
    var result = jsonDecode(response);
    theLatestListing = [];

    if (result['status'] == 'success') {
      theLatestListing = result['data']['list'];
    }
  }

  //explore city
  Future<void> exploreCity(BuildContext context) async {
    isLoadingForexploreBestCities = true;
    notifyListeners();
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient()
        .getMethodWithToken(exploreCityUrl, provider.appLoginToken.toString());
    isLoading = false;
    notifyListeners();
    var result = jsonDecode(response);
    exploreBestCities = [];
    if (result['status'] == 'success') {
      exploreBestCities = result['data'];
    }
  }

  //event in mumbai
  Future<void> eventOfMumbai(BuildContext context) async {
    // print('$eventInMumbaiUrl$city');
    isLoadingForeventInMumbai = true;
    notifyListeners();
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient().getMethodWithToken(
        "$eventInMumbaiUrl$city", provider.appLoginToken.toString());
    isLoading = false;
    notifyListeners();
    var result = jsonDecode(response);
    eventInMumbai = [];
    if (result['status'] == 'success') {
      eventInMumbai = result['data']['list'];
    }
  }

  Future<void> getCurrentPosition(BuildContext context) async {
    getMyCity = true;
    notifyListeners();
    lat = 0;
    long = 0;
    //Permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // print(permission);
      LocationPermission askedPermission = await Geolocator.requestPermission();
      if (kDebugMode) {
        print("$askedPermission: no permission!");
      }
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      if (kDebugMode) {
        print(currentPosition.latitude.toString());
        print(currentPosition.longitude.toString());
      }

      lat = currentPosition.latitude;
      long = currentPosition.longitude;
      notifyListeners();
      // ignore: use_build_context_synchronously
      findACity(currentPosition.latitude, currentPosition.longitude, context);
      //
    }
  }
  //find a city using lan lat

  Future<void> findACity(
      double latitude, double longitude, BuildContext context) async {
    city = '...';
    List<Placemark> placemark =
        await placemarkFromCoordinates(latitude, longitude);
    // print(placemark);
    Placemark place = placemark[0];
    // print(place.locality);
    city = place.locality.toString();
    notifyListeners();
    if (kDebugMode) {
      print(city);
    }
    getMyCity = false;
    notifyListeners();
    //
    // ignore: use_build_context_synchronously
    eventOfMumbai(context);
  }

  //open map
  Future<void> openMap() async {
    var googleUrl =
        Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$long");
    // var googleUrl =
    //     "https://www.google.com/maps/search/?api=1&query=$lat,$long";
    //
    // print(googleUrl);
    await launchUrl(googleUrl);

    // await canLaunchUrlString(googleUrl)
    //     ? await launchUrlString(googleUrl)
    //     : throw "Could not launch $googleUrl";
  }

  //

  //user interest
  bool isLoadingForUserInterest = false;
  List listOfUserInterest = [];
  //
  Future<void> userInterest(BuildContext context) async {
    isLoadingForUserInterest = true;
    notifyListeners();
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var response = await BaseClient()
        .getMethodWithToken(userInterestUrl, provider.appLoginToken.toString());
    isLoadingForUserInterest = false;
    notifyListeners();
    var result = jsonDecode(response);
    // print(result);
    //
    listOfUserInterest = [];

    if (result['status'] == 'success') {
      if (result['data'] != null) {
        listOfUserInterest = result['data']['list'];
        notifyListeners();
      } else {
        // toastMessage(result['message']);
      }
    }
  }

  //
  void cleanDropDownBoxes() {
    choseAllType = '';
    choseCity = '';
    listOfDistanceData = [];
    listOfBadgeData = [];
    listOfPartnersData = [];
    notifyListeners();
  }
}
