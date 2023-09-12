//list view container
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/Home%20providers/home_page_provider.dart';
import 'package:racemart_app/Provider/wishlist/wishlist_provider.dart';

import '../../../../DetailPage/detail_of_home_page.dart';
import '../../customeEventContainer/custome_event_container.dart';

class ListViewContainer extends StatelessWidget {
  const ListViewContainer({
    super.key,
    required this.controllers,
    required this.hasMore,
  });

  final ScrollController controllers;
  final bool hasMore;

  @override
  Widget build(BuildContext context) {
    final wishProvider = Provider.of<WishListProvider>(context, listen: true);
    return Consumer<HomeProvider>(builder: (context, value, child) {
      final upcomingEventList = value.upcomingEventList;
      return ListView.builder(
        controller: controllers,
        itemCount: upcomingEventList.length + 1,
        itemBuilder: (context, index) {
          if (index < upcomingEventList.length) {
            var dataOfEvent = upcomingEventList[index];
            return GestureDetector(
              onTap: () {
                // widget.provider.openMap();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DetailPageOfHome(index: index, data: dataOfEvent)));
              },
              child: CustomEventContainer(
                data: dataOfEvent,
                index: index,
                fav: wishProvider.fav,
                eventId: dataOfEvent['id'],
              ),
              // RaceContainer(index: index, data: dataOfEvent),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: hasMore
                    ? const CircularProgressIndicator()
                    : const SizedBox(), //const Text('No more data to load?'),
              ),
            );
          }
        },
      );
    });
  }
}
