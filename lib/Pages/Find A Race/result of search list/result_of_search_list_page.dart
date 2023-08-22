import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/Home%20providers/home_page_provider.dart';
import 'package:racemart_app/utils/app_color.dart';

import '../../../Network/base_clent.dart';
import '../../../Provider/authentication_provider.dart';
import '../../../Provider/find_race_provider.dart';
import '../../DetailPage/detail_of_home_page.dart';
import '../../Home/Components/customeEventContainer/custome_event_container.dart';

class ResultOfSerchList extends StatefulWidget {
  const ResultOfSerchList({
    super.key,
    required this.provider,
  });
  final FindARacesProvider provider;

  @override
  State<ResultOfSerchList> createState() => _ResultOfSerchListState();
}

class _ResultOfSerchListState extends State<ResultOfSerchList> {
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
  Future fetch() async {
    if (isLoading) return;
    isLoading = true;
    const limit = 10;
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    final findARaceProvider =
        Provider.of<FindARacesProvider>(context, listen: false);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final url = "https://racemart.youtoocanrun.com/api/search?page=$page";
    print(url);
    var body = {
      "search": findARaceProvider.lookingFor.text,
      "distance": homeProvider.listOfDistanceData,
      "badge": homeProvider.listOfBadgeData,
      "partner": homeProvider.listOfPartnersData,
      "category": homeProvider.choseAllType,
      "city": homeProvider.choseCity,
      "start_date": findARaceProvider.startDate.text,
      "end_date": findARaceProvider.endDate.text,
      "sortby": ""
    };
    print(body);
    var res = await BaseClient()
        .postMethodWithToken(url, provider.appLoginToken.toString(), body);
    print(res);
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
    final searchData = widget.provider.searchListData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBg,
        elevation: 0,
        title: const Text(
          'Search result',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: blackColor),
      ),
      body: SizedBox(
        height: 650,
        child: ListView.builder(
          controller: controllers,
          itemCount: searchData.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index < searchData.length) {
              var serchOfData = searchData[index];

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailPageOfHome(
                            index: index,
                            data: serchOfData,
                          )));
                },
                child: CustomEventContainer(index: index, data: serchOfData),
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
      ),
    );
  }
}
