import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../../Utils/app_color.dart';

class CustomeRatingContainer extends StatelessWidget {
  const CustomeRatingContainer({
    super.key,
    required this.title,
    required this.onRatingUpdate,
    required this.intialRating,
  });
  final String title;
  final void Function(double) onRatingUpdate;
  final int intialRating;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: appBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: blueColor, //blueColor.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
            // const SizedBox(width: 10),
            RatingBar.builder(
              initialRating: intialRating.toDouble(),
              itemSize: 25,
              minRating: 0,
              maxRating: 5,
              itemBuilder: (context, index) {
                return const Icon(
                  Icons.star,
                  color: Colors.amber,
                );
              },
              onRatingUpdate: onRatingUpdate,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomeRatingContainerWithOutFunction extends StatelessWidget {
  const CustomeRatingContainerWithOutFunction({
    super.key,
    required this.title,
    required this.rating,
  });
  final String title;
  final int rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: appBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: blueColor, //blueColor.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
            // const SizedBox(width: 10),
            RatingBarIndicator(
              itemSize: 25,
              rating: rating.toDouble(),
              itemBuilder: (context, index) {
                return const Icon(
                  Icons.star,
                  color: Colors.amber,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}