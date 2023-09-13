import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../Provider/find_race_provider.dart';
import '../../../../DetailPage/detail_of_home_page.dart';
import '../../../Components/customeEventContainer/grid_view_container.dart';

class GridViewOfRunning extends StatelessWidget {
  const GridViewOfRunning(
      {super.key, required this.controllers, required this.hasMore});
  final ScrollController controllers;

  final bool hasMore;
  @override
  Widget build(BuildContext context) {
    return Consumer<FindARacesProvider>(
      builder: (context, value, child) {
        final runningTypeData = value.typeOfData;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GridView.builder(
            controller: controllers,
            itemCount: runningTypeData.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 1.1,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              if (index < runningTypeData.length) {
                dynamic data = runningTypeData[index];
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
