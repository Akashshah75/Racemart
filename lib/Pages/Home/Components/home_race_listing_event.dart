import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import '../../../Network/base_clent.dart';
import '../../../Provider/Home providers/home_page_provider.dart';
import '../../../Provider/authentication_provider.dart';
import '../../../Provider/wishlist/fav_event_add_wishlist_provider.dart';
import '../../../Provider/wishlist/wishlist_provider.dart';
import '../../../Utils/app_asset.dart';
import '../../../Utils/app_color.dart';
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
    return SizedBox(
      height: 620,
      child: widget.provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : widget.provider.upcomingEventList.isEmpty
              ? Center(child: Image.asset(noDataFound))
              : widget.provider.isList
                  ? ListViewContainer(
                      controllers: controllers,
                      widget: widget,
                      hasMore: hasMore)
                  : GridViewContainer(
                      controllers: controllers,
                      widget: widget,
                      hasMore: hasMore),
    );
  }
}

class GridViewContainer extends StatelessWidget {
  const GridViewContainer(
      {super.key,
      required this.controllers,
      required this.widget,
      required this.hasMore});
  final ScrollController controllers;
  final HomeRaceListingEvent widget;

  final bool hasMore;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        itemCount: widget.provider.upcomingEventList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 1.1,
          mainAxisSpacing: 15,
        ),
        itemBuilder: (context, index) {
          if (index < widget.provider.upcomingEventList.length) {
            dynamic data = widget.provider.upcomingEventList[index];
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DetailPageOfHome(index: index, data: data)));
              },
              child: GridViewEventContainer(data: data),
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

class GridViewEventContainer extends StatelessWidget {
  const GridViewEventContainer({
    super.key,
    required this.data,
  });

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavEventAddWishlist>(context, listen: true);
    final wishProvider = Provider.of<WishListProvider>(context, listen: true);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // color: redColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: blackColor.withOpacity(0.2),
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: data['poster'] != null
                      ? Image.network(
                          data['poster'],
                          fit: BoxFit.cover,
                        )
                      : const SizedBox(),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  data['title'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: redColor,
                    ),
                    const SizedBox(width: 5),
                    //
                    Text(
                      data['city'] ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              //
            ],
          ),
          //
          Positioned(
            top: 5,
            right: 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: grey,
                    // color: blueColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: LikeButton(
                    size: 20,
                    animationDuration: const Duration(milliseconds: 1500),
                    padding: const EdgeInsets.only(left: 2, top: 2),
                    isLiked:
                        wishProvider.fav.contains(data['id']) ? true : false,
                    onTap: (isLiked) async {
                      int eventId = data['id'];
                      // print(eventId);
                      provider.addEvent(eventId, context);
                      return !isLiked;
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//list view container
class ListViewContainer extends StatelessWidget {
  const ListViewContainer({
    super.key,
    required this.controllers,
    required this.widget,
    // required this.widget,
    // required this.widget,
    required this.hasMore,
  });

  final ScrollController controllers;
  final HomeRaceListingEvent widget;
  // final HomeRaceListingEvent widget;
  // final HomeRaceListingEvent widget;
  final bool hasMore;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controllers,
      itemCount: widget.provider.upcomingEventList.length + 1,
      itemBuilder: (context, index) {
        if (index < widget.provider.upcomingEventList.length) {
          var dataOfEvent = widget.provider.upcomingEventList[index];
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
    );
  }
}
