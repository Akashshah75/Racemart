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
import '../../Home/Components/customeEventContainer/grid_view_container.dart';

class ResultOfSerchList extends StatefulWidget {
  const ResultOfSerchList({
    super.key,
  });

  @override
  State<ResultOfSerchList> createState() => _ResultOfSerchListState();
}

class _ResultOfSerchListState extends State<ResultOfSerchList> {
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
    // print(url);
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
      findARaceProvider.searchListData.addAll(newEvent);
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);
    final findARaceProvider =
        Provider.of<FindARacesProvider>(context, listen: true);
    final searchData = findARaceProvider.searchListData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        title: const Text(
          'Search result',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: blackColor),
        actions: [
          IconButton(
            onPressed: () {
              homeProvider.chageListToGrid();
            },
            icon: Icon(
              homeProvider.isList ? Icons.grid_view : Icons.list,
              color: blackColor,
            ),
          )
        ],
      ),
      body: SizedBox(
        // height: 710,
        child: homeProvider.isList
            ? ListViewOfFindARace(
                controllers: controllers,
                searchData: searchData,
                hasMore: hasMore)
            : GridViewOfFindARace(controllers: controllers, hasMore: hasMore),
      ),
    );
  }
}

//
class GridViewOfFindARace extends StatelessWidget {
  const GridViewOfFindARace({
    super.key,
    required this.controllers,
    required this.hasMore,
  });
  final ScrollController controllers;
  final bool hasMore;
  @override
  Widget build(BuildContext context) {
    return Consumer<FindARacesProvider>(
      builder: (context, value, child) {
        final searchData = value.searchListData;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GridView.builder(
            shrinkWrap: true,
            controller: controllers,
            itemCount: searchData.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 1.1,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              if (index < searchData.length) {
                dynamic data = searchData[index];
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
class ListViewOfFindARace extends StatelessWidget {
  const ListViewOfFindARace({
    super.key,
    required this.controllers,
    required this.searchData,
    required this.hasMore,
  });

  final ScrollController controllers;
  final List searchData;
  final bool hasMore;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
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
            child: CustomEventContainer(
              index: index,
              data: serchOfData,
            ),
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
      },
    );
  }
}
