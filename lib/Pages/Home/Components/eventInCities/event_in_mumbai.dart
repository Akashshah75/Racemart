import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Pages/Home/Components/customeEventContainer/custome_event_container.dart';
import 'package:racemart_app/Utils/app_asset.dart';
import '../../../../Network/base_clent.dart';
import '../../../../Provider/Home providers/home_page_provider.dart';
import '../../../../Provider/authentication_provider.dart';
import '../../../DetailPage/detail_of_home_page.dart';
import '../customeEventContainer/grid_view_container.dart';

class EventInCity extends StatefulWidget {
  const EventInCity({super.key, required this.provider});
  final HomeProvider provider;

  @override
  State<EventInCity> createState() => _EventInCityState();
}

class _EventInCityState extends State<EventInCity> {
  final controllers = ScrollController();
  bool hasMore = true;
  int page = 2;
  bool isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      homeProvider.eventInCity(context);
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

//

//
  Future fetch() async {
    // widget.provider.city;
    print(widget.provider.city);
    if (isLoading) return;
    isLoading = true;
    const limit = 10;
    var provider = Provider.of<AuthenticationProvider>(context, listen: false);
    // final url = "https://racemart.youtoocanrun.com/api/city/:mumbai?page=$page";
    final url =
        "https://racemart.youtoocanrun.com/api/city/:${widget.provider.city}?page=$page";
    var res = await BaseClient()
        .getMethodWithToken(url, provider.appLoginToken.toString());

    var result = jsonDecode(res);
    //
    if (result['data'] == null) {
      setState(() {
        hasMore = false;
      });
      return;
    }
//
    final List newEvent = result['data']['list'];
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
    final size = MediaQuery.of(context).size.height;
    return SizedBox(
      height: size * 0.75,
      child: widget.provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : widget.provider.eventInMumbai.isEmpty
              ? Center(child: Image.asset(noDataFound))
              : widget.provider.isList
                  ? ListViewOfEventInCity(
                      controllers: controllers, hasMore: hasMore)
                  : GridViewOfEventInCity(
                      controllers: controllers, hasMore: hasMore),
    );
  }
}

//grid view
class GridViewOfEventInCity extends StatelessWidget {
  const GridViewOfEventInCity(
      {super.key, required this.controllers, required this.hasMore});
  final ScrollController controllers;

  final bool hasMore;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) {
        final eventInCityData = value.eventInMumbai;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            controller: controllers,
            itemCount: eventInCityData.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 1.1,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              if (index < eventInCityData.length) {
                dynamic data = eventInCityData[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DetailPageOfHome(index: index, data: data)));
                  },
                  child: GridViewEventContainer(data: data),
                );
              } else {
                return eventInCityData.length > 10 && hasMore
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

//list view
class ListViewOfEventInCity extends StatelessWidget {
  const ListViewOfEventInCity({
    super.key,
    required this.controllers,
    required this.hasMore,
  });

  final ScrollController controllers;

  final bool hasMore;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, value, chiid) {
      final eventInCityData = value.eventInMumbai;
      print(eventInCityData.length);
      return ListView.builder(
        controller: controllers,
        itemCount: eventInCityData.length + 1,
        itemBuilder: (context, index) {
          if (index < eventInCityData.length) {
            var dataOfEvent = eventInCityData[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailPageOfHome(
                          index: index,
                          data: dataOfEvent,
                        )));
              },
              child: CustomEventContainer(index: index, data: dataOfEvent),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: eventInCityData.length > 10 && hasMore
                    ? const CircularProgressIndicator()
                    : const SizedBox(), //const Text('No more data to load!!'),
              ),
            );
          }
        },
      );
    });
  }
}
