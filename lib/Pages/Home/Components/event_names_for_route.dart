import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Provider/Home providers/home_page_provider.dart';
import '../../../Utils/app_color.dart';

class EventNamesForRoute extends StatefulWidget {
  const EventNamesForRoute({
    super.key,
  });

  @override
  State<EventNamesForRoute> createState() => _EventNamesForRouteState();
}

class _EventNamesForRouteState extends State<EventNamesForRoute> {
  List<String> eventNames = [
    'Upcoming Races',
    'User interest',
    'The Latest Listing',
    'Explore Best Cities',
    'Event In Mumbai',
    'Testimonials',
  ];
  bool isActive = true;
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: eventNames.length,
        itemBuilder: (context, index) {
          return buildCustomeSelectEvent(index, homeProvider);
        },
      ),
    );
  }

  //
  Widget buildCustomeSelectEvent(int index, HomeProvider homeProvider) {
    return GestureDetector(
      onTap: () {
        homeProvider.changeIndex(index);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        width: 150,
        height: 40,
        decoration: BoxDecoration(
          color:
              homeProvider.selectedIndex == index ? active : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: homeProvider.selectedIndex == index ? active : appBg,
          ),
        ),
        child: Text(
          index == 4
              ? "Event in ${homeProvider.getMyCity ? '  ...' : homeProvider.city}"
              : eventNames[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: homeProvider.selectedIndex == index
                ? whiteColor
                : blackColor.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}




//
 