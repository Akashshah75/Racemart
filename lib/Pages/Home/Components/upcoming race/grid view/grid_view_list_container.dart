import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../Provider/Home providers/home_page_provider.dart';
import '../../../../DetailPage/detail_of_home_page.dart';
import '../../customeEventContainer/grid_view_container.dart';
// import '../upcoming_race_listing_page.dart';

class GridViewContainer extends StatelessWidget {
  const GridViewContainer(
      {super.key, required this.controllers, required this.hasMore});
  final ScrollController controllers;

  final bool hasMore;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            controller: controllers,
            itemCount: value.upcomingEventList.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 1.1,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              if (index < value.upcomingEventList.length) {
                dynamic data = value.upcomingEventList[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DetailPageOfHome(index: index, data: data)));
                  },
                  child: GridViewEventContainer(data: data),
                );
              } else {
                return hasMore
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox();
              }
            },
          ),
        );
      },
    );
  }
}
