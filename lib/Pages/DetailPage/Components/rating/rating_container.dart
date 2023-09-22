import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../Utils/app_asset.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/app_size.dart';

class RatingContainer extends StatelessWidget {
  const RatingContainer({super.key, this.data});
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    final List reviews = data['reviews'] ?? [];
    return Container(
      margin: defaultSymetricPeding,
      width: double.infinity,
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: white,
      ),
      child: Padding(
        padding: defaultSymetricPeding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            defaultSpaceHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 2),
                  child: const Text(
                    'Reviews',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: blackColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                reviews.length > 2
                    ? InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            enableDrag: false,
                            context: context,
                            // isDismissible: false,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                            ),
                            builder: (context) {
                              Size size = MediaQuery.of(context).size;
                              return SizedBox(
                                height: size.height / 2 + 100,
                                child: ListOfReviews(
                                  reviewData: reviews,
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Text(
                            'More..',
                            style: TextStyle(
                              color: blueColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            //

            const Divider(),
            //
            reviews.isNotEmpty
                ? Column(
                    children: [
                      CustomeRatingContainer(
                        name: reviews[0]['name'],
                        rating: reviews[0]['star'].toDouble(),
                        profileUrl: reviews[0]['profile'],
                        comment: reviews[0]['comments'],
                      ),

                      // const SizedBox(height: 10),
                      reviews.length > 1
                          ? CustomeRatingContainer(
                              name: reviews[1]['name'],
                              rating: reviews[1]['star'].toDouble(),
                              profileUrl: reviews[1]['profile'],
                              comment: reviews[1]['comments'],
                            )
                          : const SizedBox(),
                    ],
                  )
                : const Center(
                    child: Text('No Reviews!!'),
                  ),
          ],
        ),
      ),
    );
  }
}

class ListOfReviews extends StatelessWidget {
  const ListOfReviews({
    super.key,
    required this.reviewData,
  });
  final List reviewData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          const Text(
            "Reviews",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ListView.builder(
                itemCount: reviewData.length,
                itemBuilder: (context, index) {
                  final review = reviewData[index];
                  return CustomeRatingContainer(
                    name: review['name'],
                    rating: review['star'].toDouble(),
                    profileUrl: review['profile'],
                    comment: review['comments'],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomeRatingContainer extends StatelessWidget {
  const CustomeRatingContainer({
    super.key,
    required this.name,
    required this.rating,
    required this.profileUrl,
    required this.comment,
  });

  final String name;
  final double rating;
  final String profileUrl;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        color: appBg,
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: profileUrl.isNotEmpty
                        ? Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(profileUrl),
                          )
                        : Image(
                            fit: BoxFit.cover,
                            color: blueColor,
                            image: const AssetImage(noImageProfile),
                          ),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    //
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Text(
                        name,
                        style: TextStyle(
                          color: blueColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    RatingBarIndicator(
                      rating: rating,
                      itemSize: 20,
                      itemBuilder: (context, index) {
                        return const Icon(Icons.star, color: Colors.amber);
                      },
                    ),
                    //
                    const SizedBox(height: 5),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      width: 230,
                      child: Text(
                        comment,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
