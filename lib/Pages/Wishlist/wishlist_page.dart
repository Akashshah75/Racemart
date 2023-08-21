import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Utils/app_color.dart';

import '../../Network/base_clent.dart';
import '../../Provider/authentication_provider.dart';
import '../../Provider/wishlist/wishlist_provider.dart';
import '../Home/Components/customeEventContainer/custome_event_container.dart';
import '../DetailPage/detail_of_home_page.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final provider = Provider.of<WishListProvider>(context, listen: false);
      provider.wishListEvent(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WishListProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: blackColor),
        title: const Text(
          'Your Event',
          style: TextStyle(
            color: blackColor,
          ),
        ),
      ),
      body: Column(
        children: [
          WishListListing(provider: provider),
        ],
      ),
    );
  }
}

class WishListListing extends StatefulWidget {
  const WishListListing({super.key, required this.provider});
  final WishListProvider provider;

  @override
  State<WishListListing> createState() => _WishListListingState();
}

class _WishListListingState extends State<WishListListing> {
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
    //   https: //racemart.youtoocanrun.com/api/wishlist?page=2
    if (isLoading) return;
    isLoading = true;
    const limit = 10;
    var provider = Provider.of<AuthenticationProvider>(context, listen: false);
    final url = "https://racemart.youtoocanrun.com/api/wishlist?page=$page";

    var res = await BaseClient()
        .getMethodWithToken(url, provider.appLoginToken.toString());
    // print(res);

    var result = jsonDecode(res);
    final List newEvent = result['data']['list'];
    // print(newEvent);

    //
    setState(() {
      page++;

      isLoading = false;
      if (newEvent.length < limit) {
        hasMore = false;
      }
      widget.provider.wishListData.addAll(newEvent);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(page);
    return SizedBox(
      height: 692,
      child: widget.provider.wishListData.isEmpty
          ? const Text("Don't have any event")
          : ListView.builder(
              controller: controllers,
              itemCount: widget.provider.wishListData.length + 1,
              itemBuilder: (context, index) {
                // var dataOfEvent = widget.provider.wishListData[index];
//return
                //RaceContainer(index: index, data: dataOfEvent);
                if (index < widget.provider.wishListData.length) {
                  var dataOfEvent = widget.provider.wishListData[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailPageOfHome(
                                index: index,
                                data: dataOfEvent,
                              )));
                    },
                    child:
                        CustomEventContainer(data: dataOfEvent, index: index),
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
