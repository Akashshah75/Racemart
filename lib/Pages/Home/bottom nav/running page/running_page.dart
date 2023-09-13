import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Pages/Home/advertisment/advertisment_container.dart';
import 'package:racemart_app/Provider/Home%20providers/home_page_provider.dart';
import 'package:racemart_app/Provider/find_race_provider.dart';

import '../../../../Network/base_clent.dart';
import '../../../../Provider/advertiesment/advertiesment_provider.dart';
import '../../../../Provider/authentication_provider.dart';
import '../../../../Utils/app_asset.dart';
import 'components/gridview_of_running.dart';
import 'components/listview_of_running.dart';

class RunningPage extends StatefulWidget {
  const RunningPage({super.key});

  @override
  State<RunningPage> createState() => _RunningPageState();
}

class _RunningPageState extends State<RunningPage> {
  final controllers = ScrollController();
  bool hasMore = true;
  int page = 2;
  bool isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final findRaceProvider =
          Provider.of<FindARacesProvider>(context, listen: false);
      findRaceProvider.searchEventWithOutNavigation(context, category: 4);
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
      "category": 4,
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
    return Scaffold(
      body: SafeArea(
        child: Consumer<FindARacesProvider>(builder: (context, value, child) {
          final runningTypeData = value.typeOfData;
          return value.isTypeOfDataLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : value.typeOfData.isEmpty
                  ? Center(child: Image.asset(noDataFound))
                  : Column(children: [
                      const SizedBox(height: 10),
                      AdvertismentContainer(
                          homeProvider: provider,
                          title: CategoryOfBottomNavigation.running),
                      const SizedBox(height: 10),
                      Expanded(
                          child: provider.isList
                              ? ListViewOfRunning(
                                  controllers: controllers,
                                  runningTypeData: runningTypeData,
                                  hasMore: hasMore)
                              : GridViewOfRunning(
                                  controllers: controllers, hasMore: hasMore))
                    ]);
        }),
      ),
    );
  }
}
