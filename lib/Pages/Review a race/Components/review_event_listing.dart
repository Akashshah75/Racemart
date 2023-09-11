import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Network/base_clent.dart';
import '../../../Provider/Home providers/home_page_provider.dart';
import '../../../Provider/authentication_provider.dart';
import '../../../Provider/review a race provider/review_a_race_provider.dart';
import '../../DetailPage/detail_of_home_page.dart';
import '../../Home/Components/customeEventContainer/custome_event_container.dart';
import '../../Home/Components/customeEventContainer/grid_view_container.dart';

class ReviewAEventListing extends StatefulWidget {
  const ReviewAEventListing({super.key, required this.provider});
  final ReviewARaceProvider provider;

  @override
  State<ReviewAEventListing> createState() => _ReviewAEventListingState();
}

class _ReviewAEventListingState extends State<ReviewAEventListing> {
  final controllers = ScrollController();
  bool hasMore = true;
  int page = 2;
  bool isLoading = false;
  @override
  void initState() {
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
    var reviewProvider =
        Provider.of<ReviewARaceProvider>(context, listen: false);
    final url = "https://racemart.youtoocanrun.com/api/past-events?page=$page";
    var body = {
      "search": reviewProvider.search.text,
      "distance": reviewProvider.listOfDistanceData,
      "badge": reviewProvider.listOfBadgeData,
      "partner": reviewProvider.listOfPartnersData,
      "category": reviewProvider.choseAllType,
      "city": reviewProvider.choseCity,
    };
    // print(body);
    var res = await BaseClient()
        .postMethodWithToken(url, provider.appLoginToken.toString(), body);

    var result = jsonDecode(res);
    // print(res);
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
      widget.provider.searchListData.addAll(newEvent);
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return SizedBox(
      height: 650,
      child: widget.provider.searchListData.isEmpty
          ? const Center(
              child: Text("Don't have any event"),
            )
          : homeProvider.isList
              ? ListViewOfReviewARace(
                  controllers: controllers, hasMore: hasMore)
              : GridViewOfREvieAList(
                  controllers: controllers, hasMore: hasMore),
    );
  }
}

//grid
class GridViewOfREvieAList extends StatelessWidget {
  const GridViewOfREvieAList(
      {super.key, required this.controllers, required this.hasMore});
  final ScrollController controllers;

  final bool hasMore;
  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewARaceProvider>(
      builder: (context, value, child) {
        final reviewARaceData = value.searchListData;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            controller: controllers,
            itemCount: reviewARaceData.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 1.1,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              if (index < reviewARaceData.length) {
                dynamic data = reviewARaceData[index];
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

//list
class ListViewOfReviewARace extends StatelessWidget {
  const ListViewOfReviewARace({
    super.key,
    required this.controllers,
    required this.hasMore,
  });

  final ScrollController controllers;

  final bool hasMore;

  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewARaceProvider>(builder: (context, value, child) {
      final reviewARaceData = value.searchListData;
      return ListView.builder(
        controller: controllers,
        itemCount: reviewARaceData.length + 1,
        itemBuilder: (context, index) {
          // var dataOfEvent = widget.provider.searchListData[index];
          // return RaceContainer(index: index, data: dataOfEvent);
          if (index < reviewARaceData.length) {
            var dataOfEvent = reviewARaceData[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailPageOfHome(
                          index: index,
                          data: dataOfEvent,
                        )));
              },
              child: CustomEventContainer(
                index: index,
                data: dataOfEvent,
                fav: [],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: hasMore
                    ? const CircularProgressIndicator()
                    : const SizedBox(), // const Text('No more data to load?'),
              ),
            );
          }
        },
      );
    });
  }
}
