import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Provider/wishlist/fav_event_add_wishlist_provider.dart';
// import '../../../../Provider/wishlist/wishlist_provider.dart';
import '../../../../Provider/wishlist/wishlist_provider.dart';
import '../../../../Utils/app_asset.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/constant.dart';

class CustomEventContainer extends StatefulWidget {
  const CustomEventContainer(
      {super.key, this.data, required this.index, this.eventId});
  final dynamic data;
  final int index;
  final int? eventId;

  @override
  State<CustomEventContainer> createState() => _CustomEventContainerState();
}

class _CustomEventContainerState extends State<CustomEventContainer> {
  DateTime now = DateTime.now();
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavEventAddWishlist>(context, listen: true);
    final wishProvider = Provider.of<WishListProvider>(context, listen: true);

    List showDistance = widget.data['distances'];
    List showDeliverables = widget.data['deliverables'] ?? [];
    final Uri url = Uri.parse(widget.data['registration_url']);
    final DateTime registraationEndDate =
        DateTime.parse(widget.data['registration_end_date']);

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
          ? 395 //408
          : widget.data['city'] != null &&
                  showDeliverables.isNotEmpty &&
                  widget.data['registration_end_date'] != null
              ? 365 //376
              : widget.data['city'] != null &&
                      showDistance.isNotEmpty &&
                      widget.data['registration_end_date'] != null
                  ? 375 //386
                  : showDistance.isNotEmpty &&
                          widget.data['registration_end_date'] != null
                      ? 355 //
                      : widget.data['city'] != null &&
                              widget.data['registration_end_date'] != null
                          ? 345 //358
                          : 375,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: white,
        border: Border.all(width: 0.12, color: Colors.black),
        boxShadow: [
          BoxShadow(
              blurRadius: 50.0,
              offset: const Offset(0, 5),
              color: greyColor.withOpacity(0.25) //Color(0xFFe8e8e8),
              ),
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
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        )
                      : Image.asset(
                          noImage, //demo,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.fill,
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
                        likeBuilder: (isLiked) {
                          return Icon(
                            Icons.favorite,
                            color: isLiked ? appRed : greyColor,
                          );
                        },
                        onTap: (isLiked) async {
                          // final wishProvider = Provider.of<WishListProvider>(
                          //     context,
                          //     listen: false);

                          // print(isLiked);
                          int eventId = widget.data['id'];
                          // wishProvider.wishListData.length
                          // < 10
                          //     ?
                          provider.addEvent(eventId, context);
                          // : provider.addEvent2(eventId, context);

                          // .then((_) {
                          //   // print(value);
                          //   wishProvider.checkWishlistId(eventId, context);
                          // });
                          // print(eventId);
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
                          //Colors.green[500],
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
                            const Icon(
                              Icons.star_rate,
                              size: 15,
                              color: Colors.yellowAccent,
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
                                    width: 50,
                                    child: Text(
                                      // '10 miles ',
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
                const Text('Last Day to Register :'),
                // const Text('Last Registration Date :'),
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
          registraationEndDate.isBefore(now)
              ? const SizedBox()
              : Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // TextButton(
                    //   onPressed: () {
                    //     _launchUrl(url);
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 10),
                    //     child: Text(
                    //       'Register now',
                    //       style: TextStyle(
                    //           color: blueColor,
                    //           fontSize: 14,
                    //           letterSpacing: 1.2,
                    //           fontWeight: FontWeight.w600),
                    //     ),
                    //   ),
                    // ),

                    InkWell(
                      onTap: () {
                        _launchUrl(url);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              'Register now',
                              style: TextStyle(
                                  color: appRed, // blueColor,
                                  fontSize: 14,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 3),
                            Icon(
                              Icons.how_to_reg_rounded,
                              color: appRed, //blueColor,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    widget.data['lowest_price'] == null
                        ? const SizedBox()
                        : Container(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
