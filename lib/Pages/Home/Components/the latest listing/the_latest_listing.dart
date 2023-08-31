import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/Home%20providers/home_page_provider.dart';

import '../../../../Network/base_clent.dart';
import '../../../../Provider/authentication_provider.dart';
import '../../../../Utils/app_asset.dart';
import '../../../DetailPage/detail_of_home_page.dart';
import '../customeEventContainer/grid_view_container.dart';
import 'list view/list_view_of_latest_listing.dart';

class TheLatestListing extends StatefulWidget {
  const TheLatestListing({
    super.key,
    required this.provider,
  });
  final HomeProvider provider;

  @override
  State<TheLatestListing> createState() => _TheLatestListingState();
}

class _TheLatestListingState extends State<TheLatestListing> {
  final controllers = ScrollController();
  bool hasMore = true;
  int page = 1;
  bool isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      homeProvider.latestListing(context);
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
    final url =
        "https://racemart.youtoocanrun.com/api/latest-listing?page=$page";
    var res = await BaseClient()
        .getMethodWithToken(url, provider.appLoginToken.toString());
    var result = jsonDecode(res);
    if (result['data'] == null) {
      setState(() {
        hasMore = false;
      });
      return;
    }
    //
    final List newEvent = result['data']['list'];
    //
    setState(() {
      page++;
      isLoading = false;
      if (newEvent.length < limit) {
        hasMore = false;
      }
      widget.provider.theLatestListing.addAll(newEvent);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return SizedBox(
      height: size * 0.75,
      child: widget.provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : widget.provider.theLatestListing.isEmpty
              ? Center(child: Image.asset(noDataFound))
              : widget.provider.isList
                  ? ListViewOfLatestListing(
                      controllers: controllers, hasMore: hasMore)
                  : GridViewOfLatestListing(
                      controllers: controllers, hasMore: hasMore),
    );
  }
}

class GridViewOfLatestListing extends StatelessWidget {
  const GridViewOfLatestListing(
      {super.key, required this.controllers, required this.hasMore});
  final ScrollController controllers;

  final bool hasMore;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) {
        final latestListingData = value.theLatestListing;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            controller: controllers,
            itemCount: latestListingData.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 1.1,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              if (index < latestListingData.length) {
                dynamic data = latestListingData[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DetailPageOfHome(index: index, data: data)));
                  },
                  child: GridViewEventContainer(data: data),
                );
              } else {
                return hasMore
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox();
              }
            },
          ),
        );
      },
    );
  }
}
