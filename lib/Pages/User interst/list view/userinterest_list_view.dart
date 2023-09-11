import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Provider/Home providers/home_page_provider.dart';
import '../../DetailPage/detail_of_home_page.dart';
import '../../Home/Components/customeEventContainer/custome_event_container.dart';

class UserInterestListView extends StatelessWidget {
  const UserInterestListView({
    super.key,
    required this.controllers,
    required this.hasMore,
  });

  final ScrollController controllers;
  final bool hasMore;

  @override
  Widget build(BuildContext context) {
    // print(controllers.position.maxScrollExtent == controllers.offset);
    // print('build');
    return Consumer<HomeProvider>(builder: (context, value, child) {
      final userInterestData = value.listOfUserInterest;
      return ListView.builder(
        controller: controllers,
        itemCount: userInterestData.length + 1,
        itemBuilder: (context, index) {
          if (index < userInterestData.length) {
            var dataOfEvent = userInterestData[index];
            return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailPageOfHome(index: index, data: dataOfEvent),
                    ),
                  );
                },
                child: CustomEventContainer(
                  key: ValueKey(dataOfEvent['id']),
                  data: dataOfEvent,
                  index: index,
                  fav: [],
                )
                // RaceContainer(index: index, data: dataOfEvent),
                );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: userInterestData.length > 10 && hasMore
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
