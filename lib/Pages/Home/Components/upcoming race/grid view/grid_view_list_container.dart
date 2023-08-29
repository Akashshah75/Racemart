import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

import '../../../../../Provider/Home providers/home_page_provider.dart';
import '../../../../../Provider/wishlist/fav_event_add_wishlist_provider.dart';
import '../../../../../Provider/wishlist/wishlist_provider.dart';
import '../../../../../Utils/app_color.dart';
import '../../../../DetailPage/detail_of_home_page.dart';
// import '../upcoming_race_listing_page.dart';

class GridViewContainer extends StatelessWidget {
  const GridViewContainer(
      {super.key,
      required this.controllers,
      // required this.widget,
      required this.hasMore});
  final ScrollController controllers;
  // final UpcomingRaceListingPage widget;

  final bool hasMore;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            controller: controllers,
            itemCount: value.upcomingEventList.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 1.1,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              if (index < value.upcomingEventList.length) {
                dynamic data = value.upcomingEventList[index];
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