import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/find_race_provider.dart';

import '../../../../Network/base_clent.dart';
import '../../../../Provider/Home providers/home_page_provider.dart';
import '../../../../Provider/advertiesment/advertiesment_provider.dart';
import '../../../../Provider/authentication_provider.dart';
import '../../../../Utils/app_asset.dart';
import '../../../DetailPage/detail_of_home_page.dart';
import '../../Components/customeEventContainer/custome_event_container.dart';
import '../../Components/customeEventContainer/grid_view_container.dart';
import '../../advertisment/advertisment_container.dart';

class TrithlonPage extends StatefulWidget {
  const TrithlonPage({super.key});

  @override
  State<TrithlonPage> createState() => _TrithlonPageState();
}

class _TrithlonPageState extends State<TrithlonPage> {
  final controllers = ScrollController();
  bool hasMore = true;
  int page = 2;
  bool isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final findRaceProvider =
          Provider.of<FindARacesProvider>(context, listen: false);
      findRaceProvider.searchEventWithOutNavigation(context, category: 665);
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
  Future fetch() async {
    if (isLoading) return;
    isLoading = true;
    const limit = 10;
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    final findARaceProvider =
        Provider.of<FindARacesProvider>(context, listen: false);
    // final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final url = "https://racemart.youtoocanrun.com/api/search?page=$page";
    // print(url);
    var body = {
      "search": '',
      "distance": '',
      "badge": '',
      "partner": '',
      "category": 665,
      "city": '',
      "start_date": '',
      "end_date": '',
      "sortby": ""
    };
    // print(body);
    var res = await BaseClient()
        .postMethodWithToken(url, provider.appLoginToken.toString(), body);
    // print(res);
    var result = jsonDecode(res);
    if (result['data'] == null) {
      setState(() {
        hasMore = false;
      });
      return;
    }
    // print(res);
    final List newEvent = result['data']['list'];
    //
    setState(() {
      page++;
      isLoading = false;
      if (newEvent.length < limit) {
        hasMore = false;
      }
      // widget.provider.searchListData.addAll(newEvent);
      findARaceProvider.typeOfData.addAll(newEvent);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: true);
    final adverisement =
        Provider.of<AdvertiesmentProvider>(context, listen: true);

    return Scaffold(
      body: SafeArea(
        child: Consumer<FindARacesProvider>(builder: (context, value, child) {
          final duathlondata = value.typeOfData;
          return value.isTypeOfDataLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : value.typeOfData.isEmpty
                  ? Center(child: Image.asset(noDataFound))
                  : Column(
                      children: [
                        const SizedBox(height: 10),
                        adverisement
                                .trithalonPageTopSectionAdvertiesment.isEmpty
                            ? const SizedBox()
                            : AdvertismentContainer(
                                homeProvider: provider,
                                title: CategoryOfBottomNavigation.trithalon),
                        const SizedBox(height: 10),
                        //
                        Expanded(
                            child: provider.isList
                                ? ListViewOfCycling(
                                    controllers: controllers,
                                    runningTypeData: duathlondata,
                                    hasMore: hasMore)
                                : GridViewOfCycling(
                                    controllers: controllers,
                                    hasMore: hasMore)),
                      ],
                    );
        }),
      ),
    );
  }
}

//
class GridViewOfCycling extends StatelessWidget {
  const GridViewOfCycling(
      {super.key, required this.controllers, required this.hasMore});
  final ScrollController controllers;

  final bool hasMore;
  @override
  Widget build(BuildContext context) {
    return Consumer<FindARacesProvider>(
      builder: (context, value, child) {
        final duathlonData = value.typeOfData;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GridView.builder(
            controller: controllers,
            itemCount: duathlonData.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 1.1,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              if (index < duathlonData.length) {
                dynamic data = duathlonData[index];
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

//
class ListViewOfCycling extends StatelessWidget {
  const ListViewOfCycling({
    super.key,
    required this.controllers,
    required this.runningTypeData,
    required this.hasMore,
  });

  final ScrollController controllers;
  final List runningTypeData;
  final bool hasMore;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: controllers,
        itemCount: runningTypeData.length + 1,
        itemBuilder: (context, index) {
          if (index < runningTypeData.length) {
            var dataOfEvent = runningTypeData[index];
            return GestureDetector(
              onTap: () {
                // widget.provider.openMap();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DetailPageOfHome(index: index, data: dataOfEvent)));
              },
              child: CustomEventContainer(
                key: ValueKey(dataOfEvent['id']),
                data: dataOfEvent,
                index: index,
              ),
              // RaceContainer(index: index, data: dataOfEvent),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: hasMore
                    ? const CircularProgressIndicator()
                    : const SizedBox(), //const Text('No more data to load?'),
              ),
            );
          }
        });
  }
}
