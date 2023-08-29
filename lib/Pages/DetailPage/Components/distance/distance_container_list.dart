import 'package:flutter/material.dart';

import '../../../../Utils/app_asset.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/app_size.dart';

class DistanceContainerList extends StatelessWidget {
  const DistanceContainerList({
    super.key,
    this.data,
  });
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    List dataOfDistance = data['distances'] ?? [];
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: dataOfDistance.isEmpty
          ? const Center(
              child: Text("Don't have distances!"),
            )
          : Padding(
              padding: defaultSymetricPeding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Distances',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: blackColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 8),
                  dataOfDistance.isEmpty
                      ? const Text("No distance have!")
                      : SizedBox(
                          // height: 50, //dataOfDistance.length > 2 ? 100 : 80,
                          child: Row(
                            children: [
                              dataOfDistance.isNotEmpty
                                  ? CustomeDistanceContainer(
                                      name:
                                          dataOfDistance[0]['name'].toString(),
                                    )
                                  : const SizedBox(),
                              const SizedBox(width: 10),
                              dataOfDistance.length > 1
                                  ? CustomeDistanceContainer(
                                      name:
                                          dataOfDistance[1]['name'].toString(),
                                    )
                                  : const SizedBox(),
                              const SizedBox(width: 10),
                              dataOfDistance.length > 2
                                  ? CustomeDistanceContainer(
                                      name:
                                          dataOfDistance[2]['name'].toString(),
                                    )
                                  : const SizedBox(),
                              const SizedBox(width: 10),
                              dataOfDistance.length > 3
                                  ? IconButtonContainer(
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
                                            return DistanceBottomSheetContainer(
                                                dataOfDistance: dataOfDistance);
                                          },
                                        );
                                      },
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}

class DistanceBottomSheetContainer extends StatelessWidget {
  const DistanceBottomSheetContainer({
    super.key,
    required this.dataOfDistance,
  });
  final List dataOfDistance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            const Text(
              "Distances",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: dataOfDistance.length,
                  itemBuilder: (context, index) {
                    var distanceData = dataOfDistance[index];
                    // if (index > 4) {
                    //   return const Text('More...');
                    // } else {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        color: appBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(distance, width: 20, color: blackColor),
                          //const Icon(Icons.track_changes, size: 18),
                          const SizedBox(width: 8),
                          Text(distanceData['name'].toString())
                        ],
                      ),
                    );
                    // }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class IconButtonContainer extends StatelessWidget {
  const IconButtonContainer({
    super.key,
    required this.press,
  });
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: appBg,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: press,
        icon: const Icon(
          Icons.add,
          size: 25,
        ),
      ),
    );
  }
}
//
//  showModalBottomSheet(
//                           isScrollControlled: true,
//                           enableDrag: false,
//                           context: context,
//                           isDismissible: false,
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(25),
//                               topRight: Radius.circular(25),
//                             ),
//                           ),
//                           builder: (context) => ChangePasswordBottomSheet(
//                               h: h, controller: controller),
//                         );

//
class CustomeDistanceContainer extends StatelessWidget {
  const CustomeDistanceContainer({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 90,
      height: 35,
      decoration: BoxDecoration(
        color: appBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(distance, width: 20, color: blackColor),
          //const Icon(Icons.track_changes, size: 18),
          const SizedBox(width: 5),
          Text(name)
          // Text(distanceData['name'].toString())
        ],
      ),
    );
  }
}


 // Container(),
                  // SizedBox(
                  //   height: dataOfDistance.length > 2 ? 100 : 80,
                  //   child:
                  //    GridView.builder(
                  // gridDelegate:
                  //     const SliverGridDelegateWithFixedCrossAxisCount(
                  //   crossAxisCount: 3,
                  //   mainAxisSpacing: 10,
                  //   crossAxisSpacing: 10,
                  //   childAspectRatio: 2.5,
                  // ),
                  //       itemCount: dataOfDistance.length,
                  //       itemBuilder: (context, index) {
                  //         var distanceData = dataOfDistance[index];
                  //         if (index > 4) {
                  //           return const Text('More...');
                  //         } else {
                  //           return Container(
                  //             decoration: BoxDecoration(
                  //               color: grey,
                  //               borderRadius: BorderRadius.circular(8),
                  //             ),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Image.asset(distance,
                  //                     width: 20, color: blackColor),
                  //                 //const Icon(Icons.track_changes, size: 18),
                  //                 const SizedBox(width: 8),
                  //                 Text(distanceData['name'].toString())
                  //               ],
                  //             ),
                  //           );
                  //         }
                  //       }),
                  // ),