import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Provider/Home providers/home_page_provider.dart';
import '../../DetailPage/detail_of_home_page.dart';
import '../../Home/Components/customeEventContainer/grid_view_container.dart';

class UserInterestGridView extends StatelessWidget {
  const UserInterestGridView(
      {super.key, required this.controllers, required this.hasMore});
  final ScrollController controllers;

  final bool hasMore;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, value, child) {
      final userInterestData = value.listOfUserInterest;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          controller: controllers,
          itemCount: userInterestData.length + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            childAspectRatio: 1.1,
            mainAxisSpacing: 15,
          ),
          itemBuilder: (context, index) {
            if (index < userInterestData.length) {
              dynamic data = userInterestData[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DetailPageOfHome(index: index, data: data)));
                },
                child: GridViewEventContainer(data: data),
              );
            } else {
              return userInterestData.length > 10 && hasMore
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox();
            }
          },
        ),
      );
    });
  }
}
