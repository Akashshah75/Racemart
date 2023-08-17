import 'package:flutter/material.dart';

import '../../../Helper/Widget/heading_text.dart';
import '../../../Helper/Widget/text_widget.dart';
import '../../../Utils/app_asset.dart';
import '../../../utils/app_color.dart';

class SimilarListingList extends StatelessWidget {
  const SimilarListingList({
    super.key,
    this.data,
  });
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    List similarListingDataList = data['similar_events'] ?? [];
    return similarListingDataList.isEmpty
        ? Center(
            child: Image.asset(noDataFound),
          )
        : SizedBox(
            // color: redColor,
            //height: 400,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: similarListingDataList.length,
                itemBuilder: (context, index) {
                  var similarListingData = similarListingDataList[index];
                  return SimilarListingtContainer(
                    data: similarListingData,
                    width: similarListingDataList.length > 1 ? 350 : 370,
                  );
                }),
          );
  }
}

class SimilarListingtContainer extends StatelessWidget {
  const SimilarListingtContainer({
    super.key,
    this.data,
    required this.width,
  });
  final dynamic data;
  final double width;

  @override
  Widget build(BuildContext context) {
    final String titleLength = data['title'];
    // print(titleLength.length);
    return Container(
      width: width,
      // height: 300,
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 40,
        bottom: titleLength.length > 23
            ? 100
            : titleLength.length > 46
                ? 90
                : 115,
      ),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: blackColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              // color: redColor,
              color: whiteColor.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    data['poster'],
                  )
                  // AssetImage(demo),
                  ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: HeadingText(
              text: data['title'] ?? '...',
              fontSize: 16,
              color: blackColor,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 6),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 18,
                  color: redColor,
                ),
                const SizedBox(width: 6),
                //
                TextWidget(
                  text: data['city'] ?? 'Location',
                  color: greyColor,
                  fontSize: 15,
                  weight: FontWeight.w800,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
