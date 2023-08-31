import 'package:flutter/material.dart';

import '../../../Helper/Widget/heading_text.dart';
import '../../../Provider/Home providers/home_page_provider.dart';
import '../../../Utils/app_asset.dart';
import '../../../utils/app_color.dart';

class ExploreBestCities extends StatelessWidget {
  const ExploreBestCities({
    super.key,
    required this.provider,
  });
  final HomeProvider provider;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;

    return SizedBox(
      height: size * 0.7,
      child: ListView.builder(
        // shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: provider.exploreBestCities.length,
        itemBuilder: (context, index) {
          var eventData = provider.exploreBestCities[index];
          return CitiesEventContainer(data: eventData);
        },
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////

class CitiesEventContainer extends StatelessWidget {
  const CitiesEventContainer({
    super.key,
    this.data,
  });
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: blackColor.withOpacity(0.2)),
        image: data['image'] != null
            ? DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(data['image']))
            : const DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(noImage),
              ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: whiteColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            width: 100,
            height: 40,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 10),
                Text(
                  data['total'].toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: blueColor,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Events',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: blueColor,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadingText(
                  text: data['name'] ?? 'Mumbai', color: blueColor //whiteColor,
                  ),
              Container(
                margin: const EdgeInsets.only(left: 2),
                color: redColor,
                height: 5,
                width: 50,
              )
            ],
          )
        ]),
      ),
    );
  }
}
