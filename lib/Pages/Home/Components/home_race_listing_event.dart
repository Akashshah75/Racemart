import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Utils/app_color.dart';
import 'package:racemart_app/Utils/constant.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Network/base_clent.dart';
import '../../../Provider/Home providers/home_page_provider.dart';
import '../../../Provider/authentication_provider.dart';
import '../../../Provider/wishlist/fav_event_add_wishlist_provider.dart';
import '../../../Provider/wishlist/wishlist_provider.dart';
import '../../../Utils/app_asset.dart';
import '../../DetailPage/detail_of_home_page.dart';

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
    // final wishProvider = Provider.of<WishListProvider>(context, listen: true);
    return SizedBox(
      height: 620,
      child: widget.provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : widget.provider.upcomingEventList.isEmpty
              ? Center(child: Image.asset(noDataFound))
              : ListView.builder(
                  controller: controllers,
                  itemCount: widget.provider.upcomingEventList.length + 1,
                  itemBuilder: (context, index) {
                    if (index < widget.provider.upcomingEventList.length) {
                      var dataOfEvent =
                          widget.provider.upcomingEventList[index];
                      return GestureDetector(
                        onTap: () {
                          // widget.provider.openMap();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailPageOfHome(
                                  index: index, data: dataOfEvent)));
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
                ),
    );
  }
}

class CustomEventContainer extends StatefulWidget {
  const CustomEventContainer({super.key, this.data, required this.index});
  final dynamic data;
  final int index;

  @override
  State<CustomEventContainer> createState() => _CustomEventContainerState();
}

class _CustomEventContainerState extends State<CustomEventContainer> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    // final homeProvider = Provider.of<HomeProvider>(context, listen: true);
    final provider = Provider.of<FavEventAddWishlist>(context, listen: true);
    final wishProvider = Provider.of<WishListProvider>(context, listen: true);
    List showDistance = widget.data['distances'];
    List showDeliverables = widget.data['deliverables'] ?? [];
    final Uri url = Uri.parse(widget.data['registration_url']);

    // //

    // final date1 = DateTime.parse('2023-01-17 14:21:00');
    // final date2 = DateTime.parse('2023-01-18 14:21:00');
    // final DateTime now = DateTime.now();
    // //
    // print((now.compareTo(date1) == 0 || date1.compareTo(now) == 1) &&
    //     (date2.compareTo(now) == -1 || date2.compareTo(now) == 0));
    // print((now.compareTo(date1) == 0 || now.compareTo(date1) == 1) &&
    //     (date2.compareTo(now) == -1 || date2.compareTo(now) == 0));
    // print((date2.compareTo(now) == -1 || date2.compareTo(now) == 0));
    // if (widget.data['early_start_date'] != null ||
    //     widget.data['early_end_date'] != null) {
    //   bool res = checkDate(
    //       widget.data['early_start_date'], widget.data['early_end_date']);
    //   print(res);
    // }
    return Container(
      foregroundDecoration: widget.data['early_start_date'] == null ||
              widget.data['early_end_date'] == null
          ? const BoxDecoration()
          : checkDate(widget.data['early_start_date'],
                  widget.data['early_end_date'])
              ? const RotatedCornerDecoration.withColor(
                  color: redColor, // Colors.blue,
                  badgeSize: Size(64, 64),
                  badgePosition: BadgePosition.topStart,
                  textSpan: TextSpan(
                    text: 'Early\n bird',
                    style: TextStyle(fontSize: 10),
                  ),
                )
              : const BoxDecoration(),
      height: widget.data['city'] != null &&
              showDeliverables.isNotEmpty &&
              showDistance.isNotEmpty &&
              widget.data['registration_end_date'] != null
          ? 395
          : widget.data['city'] != null &&
                  showDeliverables.isNotEmpty &&
                  widget.data['registration_end_date'] != null
              ? 365
              : widget.data['city'] != null &&
                      showDistance.isNotEmpty &&
                      widget.data['registration_end_date'] != null
                  ? 375
                  : showDistance.isNotEmpty &&
                          widget.data['registration_end_date'] != null
                      ? 350
                      : widget.data['city'] != null &&
                              widget.data['registration_end_date'] != null
                          ? 345
                          : 375,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: white,
        // border: Border.all(width: 0.1),
        boxShadow: [
          BoxShadow(
              blurRadius: 50.0,
              offset: const Offset(0, 5),
              color: greyColor.withOpacity(0.25) //Color(0xFFe8e8e8),
              ),
          // BoxShadow(
          //   color: white,
          //   offset: const Offset(-5, 0),
          // ),
          // BoxShadow(
          //   color: white,
          //   offset: const Offset(5, 0),
          // ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  // borderRadius: BorderRadius.circular(12),
                  child: widget.data['poster'] != null
                      ? Image.network(
                          widget.data['poster'],
                          fit: BoxFit.fill,
                          height: 200,
                          width: double.infinity,
                        )
                      : Image.asset(
                          demo, //demo,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )),
              //
              widget.data['phase'] == null
                  ? const SizedBox()
                  : Positioned(
                      top: 10,
                      left: 55,
                      child: Container(
                        alignment: Alignment.center,
                        width: 130,
                        height: 20,
                        decoration: BoxDecoration(
                          color: greyColor.withOpacity(0.75),
                        ),
                        child: const Text(
                          'Event Postpont',
                          style: TextStyle(color: whiteColor),
                        ),
                      ),
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
                  ],
                ),
              ),
              //
              Positioned(
                  bottom: -2,
                  left: 25,
                  child: Container(
                    // padding: const EdgeInsets.only(top: 2),
                    alignment: Alignment.bottomCenter,
                    decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80),
                        bottomLeft: Radius.circular(5),
                        topRight: Radius.circular(80),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    width: 120,
                    height: 25,
                    child: Text(
                      widget.data['category'] ?? '', // 'Running',
                    ),
                  )),
              //
              widget.data['rate']['stars'] > 1
                  ? Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 5, bottom: 5),
                        height: 30,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.data['rate']['stars'].toString(),
                              style: const TextStyle(
                                fontSize: 15,
                                color: whiteColor,
                              ),
                            ),
                            const SizedBox(width: 2),
                            const Icon(Icons.star_rate,
                                size: 15, color: whiteColor //yellowColor,
                                ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          //
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
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
            //
          ),
          widget.data['city'] == null
              ? const SizedBox(height: 5)
              : Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
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
          // const SizedBox(height: 10),
          // const Divider(),
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
                  widget.data['registration_end_date'] != null
                      ? convertDate(widget.data['registration_end_date'])
                      : '', //widget.data['registration_end_date'] ?? "",
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Deliverables :'),
                      // const SizedBox(width: 10),
                      Container(
                          margin: const EdgeInsets.only(top: 2),
                          width: 200,
                          height: 20,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: showDeliverables.length,
                              itemBuilder: (context, index) {
                                if (index < 2) {
                                  return Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      showDeliverables[index]['title'] ?? '',
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
          const Divider(),
          //
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  _launchUrl(url);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Registration',
                    style: TextStyle(
                        color: blueColor,
                        fontSize: 14,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              widget.data['lowest_price'] == null
                  ? const SizedBox()
                  : Container(
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
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(var url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> showEventDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
