import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Network/base_clent.dart';
import '../../../Provider/Home providers/home_page_provider.dart';
import '../../../Provider/authentication_provider.dart';
import '../../../Utils/app_asset.dart';
import '../../DetailPage/detail_of_home_page.dart';
import 'customeEventContainer/custome_event_container.dart';

class HomeRaceListingEvent extends StatefulWidget {
  const HomeRaceListingEvent({super.key, required this.provider});
  final HomeProvider provider;

  @override
  State<HomeRaceListingEvent> createState() => _HomeRaceListingEventState();
}

class _HomeRaceListingEventState extends State<HomeRaceListingEvent> {
  final controllers = ScrollController();
  bool hasMore = true;
  int page = 2;
  bool isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {});
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
    // final wishProvider = Provider.of<WishListProvider>(context, listen: true);
    return SizedBox(
      height: 620,
      child: widget.provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : widget.provider.upcomingEventList.isEmpty
              ? Center(child: Image.asset(noDataFound))
              : ListView.builder(
                  controller: controllers,
                  itemCount: widget.provider.upcomingEventList.length + 1,
                  itemBuilder: (context, index) {
                    if (index < widget.provider.upcomingEventList.length) {
                      var dataOfEvent =
                          widget.provider.upcomingEventList[index];
                      return GestureDetector(
                        onTap: () {
                          // widget.provider.openMap();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailPageOfHome(
                                  index: index, data: dataOfEvent)));
                        },
                        child: CustomEventContainer(
                            key: ValueKey(dataOfEvent['id']),
                            data: dataOfEvent,
                            index: index),
                        // RaceContainer(index: index, data: dataOfEvent),
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
