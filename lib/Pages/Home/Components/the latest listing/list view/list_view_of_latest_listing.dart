import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../Provider/Home providers/home_page_provider.dart';
import '../../../../DetailPage/detail_of_home_page.dart';
import '../components/latest_listing_container.dart';

class ListViewOfLatestListing extends StatelessWidget {
  const ListViewOfLatestListing({
    super.key,
    required this.controllers,
    required this.hasMore,
  });

  final ScrollController controllers;

  final bool hasMore;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, value, child) {
      final latestListingData = value.theLatestListing;
      return ListView.builder(
        controller: controllers,
        scrollDirection: Axis.vertical,
        itemCount: latestListingData.length + 1,
        itemBuilder: (context, index) {
          if (index < latestListingData.length) {
            var dataOfEvent = latestListingData[index];
            return GestureDetector(
              key: ValueKey(dataOfEvent['id']),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailPageOfHome(
                          index: index,
                          data: dataOfEvent,
                        )));
              },
              child: LatestListingContainer(data: dataOfEvent),
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
    });
  }
}
