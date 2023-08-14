import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Provider/wishlist/fav_event_add_wishlist_provider.dart';
import '../../../Provider/wishlist/wishlist_provider.dart';
import '../../../Utils/app_asset.dart';
import '../../../Utils/app_color.dart';

class EventContainer extends StatefulWidget {
  const EventContainer({super.key, this.data, required this.index});
  final dynamic data;
  final int index;

  @override
  State<EventContainer> createState() => _EventContainerState();
}

class _EventContainerState extends State<EventContainer> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    // final homeProvider = Provider.of<HomeProvider>(context, listen: true);
    final provider = Provider.of<FavEventAddWishlist>(context, listen: true);
    final wishProvider = Provider.of<WishListProvider>(context, listen: true);
    List showDistance = widget.data['distances'];
    List showDeliverables = widget.data['deliverables'] ?? [];
    final Uri url = Uri.parse(widget.data['registration_url']);
//

//
    return Container(
      height: showDistance.isEmpty
          ? 395
          : showDeliverables.isEmpty
              ? 400
              : 420,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: widget.data['poster'] != null
                      ? Image.network(
                          widget.data['poster'],
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        )
                      : Image.asset(
                          demo,
                          height: 200,
                        )),

              //
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: grey,
                    // color: blueColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: LikeButton(
                    animationDuration: const Duration(milliseconds: 1500),
                    padding: const EdgeInsets.only(left: 2, top: 2),
                    isLiked: wishProvider.fav.contains(widget.data['id'])
                        ? true
                        : false,
                    onTap: (isLiked) async {
                      int eventId = widget.data['id'];
                      // print(eventId);
                      provider.addEvent(eventId, context);
                      return !isLiked;
                    },
                  ),
                ),
                // IconButton(
                //   onPressed: () {

                //   },
                //   icon: Consumer<HomeProvider>(
                //     builder: (context, value, child) {
                //       return
                //           //  widget.data['id'] == widget.data['id']
                //           //     ? provider.isFav
                //           //         ? const CircularProgressIndicator()
                //           //         :
                //           Icon(
                //               wishProvider.fav.contains(widget.data['id'])
                //                   ? Icons.favorite_outlined
                //                   : Icons.favorite_border_outlined,
                //               color:
                //                   wishProvider.fav.contains(widget.data['id'])
                //                       ? redColor
                //                       : blueColor);
                //     },
                //   ),
                // ),
              )
            ],
          ),
          //
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "${widget.data['title']}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: blueColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 16,
                  color: redColor,
                ),
                const SizedBox(width: 6),
                Text(
                  "${widget.data['city']}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: blueColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          //
          const Divider(),
          //distances
          showDistance.isEmpty
              ? Container()
              : Container(
                  padding: const EdgeInsets.only(left: 7, bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Distances :'),
                      // Image.asset(
                      //   distance,
                      //   width: 16,
                      //   color: redColor.withOpacity(0.8),
                      // ),
                      // Image.asset(distance, width: 18, color: redColor),
                      const SizedBox(width: 8),
                      //
                      Container(
                          margin: const EdgeInsets.only(top: 2),
                          width: 130,
                          height: 20,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: showDistance.length,
                              itemBuilder: (context, index) {
                                if (index < 2) {
                                  return SizedBox(
                                    width: 40,
                                    child: Text(
                                      showDistance[index]['name'],
                                      style: TextStyle(
                                        color: blueColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  );
                                }
                                return null;
                              })),
                    ],
                  ),
                ),
          //
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Last Registration Date :'),
                // Image.asset(
                //   calender,
                //   width: 14,
                //   color: redColor.withOpacity(0.8),
                // ),
                //
                const SizedBox(width: 10),
                Text(
                  widget.data['registration_end_date'] ?? "15th Aug 2023",
                  style: TextStyle(
                    color: blueColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          //
          const SizedBox(height: 8),
          showDeliverables.isEmpty
              ? Container()
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Deliverables :'),
                      // Image.asset(
                      //   calender,
                      //   width: 14,
                      //   color: redColor.withOpacity(0.8),
                      // ),
                      //
                      SizedBox(width: 10),
                      // Text(
                      //   "15th Aug 2023",
                      //   style: TextStyle(
                      //     color: blueColor,
                      //     fontSize: 12,
                      //   ),
                      // ),
                    ],
                  ),
                ),
          //
          const Divider(),
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.data['category'] ?? 'Running',
                  style: TextStyle(
                    color: blueColor,
                    fontSize: 13,
                  ),
                ),
              ),

              Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              rupay,
                              width: 14,
                              color: redColor.withOpacity(0.8),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              widget.data['lowest_price'].toString(),
                              style: TextStyle(
                                color: blueColor,
                                fontSize: 14,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 2),
                            const Text(
                              'onwards',
                              style: TextStyle(
                                color: redColor,
                                fontSize: 12,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ])),
              //

              const SizedBox(height: 5),
              //
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: 120,
                decoration: BoxDecoration(
                    color: blueColor, borderRadius: BorderRadius.circular(12)),
                child: MaterialButton(
                  onPressed: () {
                    _launchUrl(url);
                  },
                  child: const Text(
                    'Registration',
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              )
            ],
          ),
          //
        ],
      ),
    );
  }

  Future<void> _launchUrl(var url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
//like button code
  // IconButton(
                //   onPressed: () {

                //   },
                //   icon: Consumer<HomeProvider>(
                //     builder: (context, value, child) {
                //       return
                //           //  widget.data['id'] == widget.data['id']
                //           //     ? provider.isFav
                //           //         ? const CircularProgressIndicator()
                //           //         :
                //           Icon(
                //               wishProvider.fav.contains(widget.data['id'])
                //                   ? Icons.favorite_outlined
                //                   : Icons.favorite_border_outlined,
                //               color:
                //                   wishProvider.fav.contains(widget.data['id'])
                //                       ? redColor
                //                       : blueColor);
                //     },
                //   ),
                // ),