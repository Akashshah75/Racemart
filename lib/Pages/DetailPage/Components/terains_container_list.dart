import 'package:flutter/material.dart';
import 'package:racemart_app/Pages/DetailPage/Components/image_heading_container.dart';

import '../../../Utils/app_color.dart';
import '../../../Utils/app_size.dart';

class TerrainsContainerList extends StatelessWidget {
  const TerrainsContainerList({
    super.key,
    this.data,
  });
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    List listOfTerrains = data['terrains'] ?? [];
    return Container(
      margin: defaultSymetricPeding,
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: white,
      ),
      child: Padding(
        padding: defaultSymetricPeding,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          defaultSpaceHeight,
          Container(
            margin: const EdgeInsets.only(left: 2),
            child: const Text(
              'Terrains',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: blackColor,
                letterSpacing: 1.2,
              ),
            ),
          ),
          //
          const Divider(),
          // const SizedBox(height: 15),
          listOfTerrains.isEmpty
              ? const SizedBox()
              : Row(
                  children: [
                    TerrainsNameContainer(name: listOfTerrains[0]['name']),
                    listOfTerrains.length > 1
                        ? TerrainsNameContainer(name: listOfTerrains[1]['name'])
                        : const SizedBox(),
                    listOfTerrains.length > 2
                        ? TerrainsNameContainer(name: listOfTerrains[2]['name'])
                        : const SizedBox(),
                    const SizedBox(width: 5),
                    listOfTerrains.length > 3
                        ? CustomeIconContainer(
                            icon: Icons.add,
                            press: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                enableDrag: false,
                                context: context,
                                // isDismissible: false,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                  ),
                                ),
                                builder: (context) {
                                  return TerrainsDataBottomSheetContainer(
                                    listOfTerrains: listOfTerrains,
                                  );
                                },
                              );
                            })
                        : const SizedBox()
                  ],
                ),
        ]),
      ),
    );
  }
}

class TerrainsDataBottomSheetContainer extends StatelessWidget {
  const TerrainsDataBottomSheetContainer({
    super.key,
    required this.listOfTerrains,
  });
  final List listOfTerrains;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            const Text(
              "Terrains",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 3,
                    ),
                    itemCount: listOfTerrains.length,
                    itemBuilder: (context, index) {
                      var terrainsData = listOfTerrains[index];

                      return TerrainsNameContainerWithData(
                        data: terrainsData,
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
//

///

class TerrainsNameContainer extends StatelessWidget {
  const TerrainsNameContainer({
    super.key,
    required this.name,
  });
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      height: 40,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: appBg,
      ),
      child: Center(
        child: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}

class TerrainsNameContainerWithData extends StatelessWidget {
  const TerrainsNameContainerWithData({
    super.key,
    required this.data,
  });
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      height: 40,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: appBg,
      ),
      child: Center(
        child: Text(
          data['name'] ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
///
///SizedBox(
            //   height: 110,
            //   child: GridView.builder(
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 3,
            //       mainAxisSpacing: 5,
            //       crossAxisSpacing: 5,
            //       childAspectRatio: 3,
            //     ),
            //     itemCount: listOfTerrains.length,
            //     itemBuilder: (context, index) {
            //       var terrainsData = listOfTerrains[index];
            //       if (index > 2) {
            //         return const Text('More...');
            //       } else {
            //         return TerrainsNameContainer(
            //           data: terrainsData,
            //         );
            //       }
            //     },
            //   ),
            // ),