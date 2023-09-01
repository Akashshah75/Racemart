import 'package:flutter/material.dart';

import '../../../../DetailPage/detail_of_home_page.dart';
import '../../../Components/customeEventContainer/custome_event_container.dart';

class ListViewOfRunning extends StatelessWidget {
  const ListViewOfRunning({
    super.key,
    required this.controllers,
    required this.runningTypeData,
    required this.hasMore,
  });

  final ScrollController controllers;
  final List runningTypeData;
  final bool hasMore;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: controllers,
        itemCount: runningTypeData.length + 1,
        itemBuilder: (context, index) {
          if (index < runningTypeData.length) {
            var dataOfEvent = runningTypeData[index];
            return GestureDetector(
              onTap: () {
                // widget.provider.openMap();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DetailPageOfHome(index: index, data: dataOfEvent)));
              },
              child: CustomEventContainer(
                  key: ValueKey(dataOfEvent['id']),
                  data: dataOfEvent,
                  index: index),
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
        });
  }
}
