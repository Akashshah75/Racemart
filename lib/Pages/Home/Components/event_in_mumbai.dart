import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Pages/Home/Components/race_container.dart';
import 'package:racemart_app/Utils/app_asset.dart';
import '../../../Network/base_clent.dart';
import '../../../Provider/Home providers/home_page_provider.dart';
import '../../../Provider/authentication_provider.dart';
import '../../DetailPage/detail_of_home_page.dart';

class EventInCity extends StatefulWidget {
  const EventInCity({super.key, required this.provider});
  final HomeProvider provider;

  @override
  State<EventInCity> createState() => _EventInCityState();
}

class _EventInCityState extends State<EventInCity> {
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

//

//
  Future fetch() async {
    widget.provider.city;
    // print(widget.provider.city);
    if (isLoading) return;
    isLoading = true;
    const limit = 10;
    var provider = Provider.of<AuthenticationProvider>(context, listen: false);
    final url =
        "https://racemart.youtoocanrun.com/api/city/:${widget.provider.city}?page=$page";
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
      widget.provider.eventInMumbai.addAll(newEvent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 620,
      child: widget.provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : widget.provider.eventInMumbai.isEmpty
              ? Center(child: Image.asset(noDataFound))
              : ListView.builder(
                  controller: controllers,
                  itemCount: widget.provider.eventInMumbai.length + 1,
                  itemBuilder: (context, index) {
                    if (index < widget.provider.eventInMumbai.length) {
                      var dataOfEvent = widget.provider.eventInMumbai[index];

                      return GestureDetector(
                        key: ValueKey(dataOfEvent['id']),
                        onTap: () {
                          // widget.provider.openMap();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailPageOfHome(
                                    index: index,
                                    data: dataOfEvent,
                                  )));
                        },
                        child: RaceContainer(index: index, data: dataOfEvent),
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
