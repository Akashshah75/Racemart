import 'package:flutter/material.dart';

import '../../../../Utils/app_asset.dart';
import '../../../../Utils/app_color.dart';

class ListOfGalaryImage extends StatelessWidget {
  const ListOfGalaryImage({
    super.key,
    this.data,
  });
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    List listOfGalary = data['gallery'] ?? [];
    return listOfGalary.isEmpty
        ? Center(
            child: Image.asset(noDataFound),
          )
        : SizedBox(
            height: 400,
            child: ListView.builder(
                itemCount: listOfGalary.length,
                itemBuilder: (context, index) {
                  var galaryData = listOfGalary[index];
                  return GalaryContainer(
                    data: galaryData,
                  );
                }),
          );
  }
}

class GalaryContainer extends StatelessWidget {
  const GalaryContainer({
    super.key,
    this.data,
  });
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(data)
            //  AssetImage(demo),
            ),
      ),
    );
  }
}
