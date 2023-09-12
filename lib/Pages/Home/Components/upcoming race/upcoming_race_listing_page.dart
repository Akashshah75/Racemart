import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/advertiesment/advertiesment_provider.dart';
import '../../../../Network/base_clent.dart';
import '../../../../Provider/Home providers/home_page_provider.dart';
import '../../../../Provider/authentication_provider.dart';
import '../../../../Utils/app_asset.dart';
import 'grid view/grid_view_list_container.dart';
import 'list view/list_view_listing_container.dart';

class UpcomingRaceListingPage extends StatefulWidget {
  const UpcomingRaceListingPage({super.key, required this.provider});
  final HomeProvider provider;

  @override
  State<UpcomingRaceListingPage> createState() =>
      _UpcomingRaceListingPageState();
}

class _UpcomingRaceListingPageState extends State<UpcomingRaceListingPage> {
  final controllers = ScrollController();
  bool hasMore = true;
  int page = 2;
  bool isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      homeProvider.upcomingEvent(context);
    });
    controllers.addListener(() {
      if (controllers.position.maxScrollExtent == controllers.offset) {
        fetch();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controllers.dispose();
    super.dispose();
  }

  Future fetch() async {
    if (isLoading) return;
    isLoading = true;
    const limit = 10;
    var provider = Provider.of<AuthenticationProvider>(context, listen: false);
    final url = "https://racemart.youtoocanrun.com/api/upcoming?page=$page";
    var res = await BaseClient()
        .getMethodWithToken(url, provider.appLoginToken.toString());
    var result = jsonDecode(res);

    if (result['data'] == null) {
      setState(() {
        hasMore = false;
      });
      return;
    }
    final List newEvent = result['data']['list'];
    //
    setState(() {
      page++;
      isLoading = false;
      if (newEvent.length < limit) {
        hasMore = false;
      }
      widget.provider.upcomingEventList.addAll(newEvent);
    });
  }

  @override
  Widget build(BuildContext context) {
    final adProvider =
        Provider.of<AdvertiesmentProvider>(context, listen: true);
    final size = MediaQuery.of(context).size.height;
    return SizedBox(
      height: adProvider.homePageAdvertisementpopUp.isEmpty
          ? size * 0.7
          : size * 0.55,
      child: widget.provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : widget.provider.upcomingEventList.isEmpty
              ? Center(child: Image.asset(noDataFound))
              : widget.provider.isList
                  ? ListViewContainer(
                      controllers: controllers,
                      hasMore: hasMore,
                    )
                  : GridViewContainer(
                      controllers: controllers,
                      hasMore: hasMore,
                    ),
    );
  }
}
