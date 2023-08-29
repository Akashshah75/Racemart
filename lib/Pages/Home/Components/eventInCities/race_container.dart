import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Helper/Widget/text_widget.dart';
import '../../../../Provider/wishlist/fav_event_add_wishlist_provider.dart';
import '../../../../Provider/wishlist/wishlist_provider.dart';
import '../../../../Utils/app_asset.dart';
import '../../../../Utils/app_color.dart';

class RaceContainer extends StatelessWidget {
  const RaceContainer({super.key, required this.index, this.data});
  final int index;
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavEventAddWishlist>(context, listen: true);
    final wishProvider = Provider.of<WishListProvider>(context, listen: true);
    List showDistance = data['distances'];
    var title = data['title'];

    return Container(
      key: ValueKey(data['id']),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: title.length >= 60 ? 190 : 195,
      width: double.infinity,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
      ),
      //
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 170,
                width: 125,
                margin: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 8),
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Hero(
                          transitionOnUserGestures: true,
                          tag: data['title'],
                          child: data['poster'] != null
                              ? Image(
                                  image: NetworkImage(data['poster']),
                                  width: 130,
                                  height: 170,
                                  fit: BoxFit.fill,
                                )
                              : Image.network(
                                  // "${data['poster']}",
                                  "https://picsum.photos/id/2$index/130/170",
                                  fit: BoxFit.cover,
                                ),
                        )
                        //     Image.asset(
                        //   data['poster'],
                        //   fit: BoxFit.cover,
                        // ),
                        ),
                    Positioned(
                      // bottom: 0,
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        key: ValueKey(data['id']),
                        onTap: () {
                          //  print(data['wishlist']);
                          // provider.chageWishList(data['wishlist']);
                          // provider.fav(data['id']);
                          // provider.chageWishList(index);
                          int eventId = data['id'];
                          provider.addEvent(eventId, context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 5, right: 5, top: 5),
                          child: Icon(
                              // provider.id.contains(data['id']) ||
                              data['wishlist'] ||
                                      wishProvider.wishListData
                                          .contains(data['id'])
                                  ? Icons.favorite_outlined
                                  : Icons.favorite_border_outlined,
                              color: // provider.id.contains(data['id']) ||
                                  data['wishlist'] ||
                                          wishProvider.wishListData
                                              .contains(data['id'])
                                      ? redColor
                                      : white),
                        ),
                      ),
                    ),
                  ],
                ),
                //  ClipRRect(
                //   borderRadius: BorderRadius.circular(12),
                //   child: Image.asset(demo, fit: BoxFit.cover),
                // ),
              ),
              //
              Column(
                children: [
                  //title
                  Container(
                    width: 220,
                    margin: const EdgeInsets.only(top: 15),
                    padding: const EdgeInsets.only(left: 5),
                    child: TextWidget(
                      text: data['title'] ??
                          "Mg vadodara marathon 2024".toUpperCase(),
                      fontSize: 14,
                      letterSpacing: 1,
                    ),
                  ),
                  //location
                  Container(
                    width: 220,
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on,
                            size: 18, color: redColor),
                        const SizedBox(width: 5),
                        Text(
                          data['city'] ?? 'Bandra fort',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                            color: textColor,
                            // color: blueColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 220,
                    margin: const EdgeInsets.only(top: 8),
                    // padding: const EdgeInsets.only(le),
                    child: Row(
                      children: [
                        Image.asset(distance, width: 20, color: redColor),
                        const SizedBox(width: 2),
                        //
                        SizedBox(
                            width: 130,
                            height: 20,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: showDistance.length,
                                itemBuilder: (context, index) {
                                  if (showDistance.length <= 3) {
                                    return SizedBox(
                                      width: 40,
                                      child: Text(
                                        showDistance[index]['name'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.1,
                                          // color: blueColor,
                                          color: textColor,
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

                  Container(
                      width: 220,
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.only(left: 3),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  data['category'] == 'Running'
                                      ? runIcon
                                      : category,
                                  width: 14,
                                  color: redColor.withOpacity(0.8),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  data['category'] ?? 'Running',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.1,
                                    // color: blueColor,
                                    color: textColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )
                          ])),

                  Container(
                    width: 220,
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(left: 2),
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                          color: redColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Register',
                            style: TextStyle(color: whiteColor),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          //
        ],
      ),
    );
  }
}
