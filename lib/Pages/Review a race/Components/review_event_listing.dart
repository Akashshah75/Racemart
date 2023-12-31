import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Network/base_clent.dart';
import '../../../Provider/authentication_provider.dart';
import '../../../Provider/review a race provider/review_a_race_provider.dart';
import '../../DetailPage/detail_of_home_page.dart';
import '../../Home/Components/customeEventContainer/custome_event_container.dart';

class ReviewAEventListing extends StatefulWidget {
  const ReviewAEventListing({super.key, required this.provider});
  final ReviewARaceProvider provider;

  @override
  State<ReviewAEventListing> createState() => _ReviewAEventListingState();
}

class _ReviewAEventListingState extends State<ReviewAEventListing> {
  final controllers = ScrollController();
  bool hasMore = true;
  int page = 1;
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
    print(body);
    var res = await BaseClient()
        .postMethodWithToken(url, provider.appLoginToken.toString(), body);

    var result = jsonDecode(res);
    // print(res);
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
    return SizedBox(
      height: 650,
      child: widget.provider.searchListData.isEmpty
          ? const Center(
              child: Text("Don't have any event"),
            )
          : ListView.builder(
              controller: controllers,
              itemCount: widget.provider.searchListData.length + 1,
              itemBuilder: (context, index) {
                // var dataOfEvent = widget.provider.searchListData[index];
                // return RaceContainer(index: index, data: dataOfEvent);
                if (index < widget.provider.searchListData.length) {
                  var dataOfEvent = widget.provider.searchListData[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailPageOfHome(
                                index: index,
                                data: dataOfEvent,
                              )));
                    },
                    child:
                        CustomEventContainer(index: index, data: dataOfEvent),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: hasMore
                          ? const CircularProgressIndicator()
                          : const Text('No more data to load?'),
                    ),
                  );
                }
              },
            ),
    );
  }
}
