import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/Home%20providers/home_page_provider.dart';
import 'package:racemart_app/Utils/app_color.dart';

import '../../Network/base_clent.dart';
import '../../Provider/authentication_provider.dart';
import '../../Provider/wishlist/wishlist_provider.dart';
import '../Home/Components/customeEventContainer/custome_event_container.dart';
import '../DetailPage/detail_of_home_page.dart';
import '../Home/Components/customeEventContainer/grid_view_container.dart';

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
      // provider.fetch(context);
      provider.wishListEvent(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WishListProvider>(context, listen: true);
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);
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
      body: Column(
        children: [
          const SizedBox(height: 15),
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
  bool hasMore = false;
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
    //
    if (result['data'] == null) {
      setState(() {
        hasMore = false;
      });
      return;
    }
    final List newEvent = result['list'];
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
    final provider = Provider.of<HomeProvider>(context, listen: false);
    // print(widget.provider.wishListData.length);
    return SizedBox(
      height: 692,
      child: widget.provider.wishListData.isEmpty
          ? const Center(child: Text("Don't have any event"))
          : provider.isList
              ? ListViewOfWishList(controllers: controllers, hasMore: hasMore)
              : GridViewOfWishlist(controllers: controllers, hasMore: hasMore),
    );
  }
}
//grid view

class GridViewOfWishlist extends StatelessWidget {
  const GridViewOfWishlist(
      {super.key, required this.controllers, required this.hasMore});
  final ScrollController controllers;

  final bool hasMore;
  @override
  Widget build(BuildContext context) {
    return Consumer<WishListProvider>(
      builder: (context, value, child) {
        final wishlistData = value.wishListData;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            controller: controllers,
            itemCount: wishlistData.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 1.1,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              if (index < wishlistData.length) {
                dynamic data = wishlistData[index];
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

//lsit view
class ListViewOfWishList extends StatelessWidget {
  const ListViewOfWishList({
    super.key,
    required this.controllers,
    required this.hasMore,
  });

  final ScrollController controllers;

  final bool hasMore;

  @override
  Widget build(BuildContext context) {
    return Consumer<WishListProvider>(builder: (context, value, child) {
      final wishlistData = value.wishListData;
      return ListView.builder(
        // controller: controllers,
        itemCount: wishlistData.length,
        itemBuilder: (context, index) {
          // if (index < wishlistData.length) {
          var dataOfEvent = wishlistData[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailPageOfHome(
                        index: index,
                        data: dataOfEvent,
                      )));
            },
            child: CustomEventContainer(
              data: dataOfEvent,
              index: index,
            ),
          );
          // }
          //  else {
          //   return Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 10),
          //     child: Center(
          //       child: hasMore
          //           ? const CircularProgressIndicator()
          //           : const SizedBox(),
          //     ),
          //   );
          // }
        },
      );
    });
  }
}
