import 'package:flutter/material.dart';
import 'package:racemart_app/Utils/app_asset.dart';

import '../../../../Utils/app_color.dart';

class ListOfDeliverables extends StatelessWidget {
  const ListOfDeliverables({
    super.key,
    this.data,
  });
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    List deliverableListingData = data['deliverables'];
    return deliverableListingData.isEmpty
        ? Center(
            child: Image.asset(noDataFound),
          )
        : SizedBox(
            height: 500,
            // decoration: BoxDecoration(
            //   border: Border.all(),
            // ),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1.2,
                ),
                itemCount: deliverableListingData.length,
                itemBuilder: (context, index) {
                  var dataOfDeliverable = deliverableListingData[index];
                  return Container(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DeliverablesContainer(
                      data: dataOfDeliverable,
                    ),
                  );
                }));
  }
}

class DeliverablesContainer extends StatelessWidget {
  const DeliverablesContainer({
    super.key,
    this.data,
  });
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Align(
        alignment: Alignment.center,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: redColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(image: NetworkImage(data['image']))
              // Image.asset(demo),
              ),
        ),
      ),
    );
  }
}
