import 'package:flutter/material.dart';

import '../../../../../Utils/app_color.dart';
import '../../../../../Utils/app_size.dart';

class PartenerContainerList extends StatelessWidget {
  const PartenerContainerList({
    super.key,
    this.data,
  });
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    List dataOfPartners = data['partners'] ?? [];
    return dataOfPartners.isEmpty
        ? const Center(child: Text("Don't have any patners!"))
        : Container(
            height: 200,
            margin: defaultSymetricPeding,
            width: double.infinity,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: defaultSymetricPeding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Partners',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: blackColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const Divider(),
                  dataOfPartners.isEmpty
                      ? const SizedBox()
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              PatnerContainer(
                                  title: dataOfPartners[0]['title']),
                              const SizedBox(height: 10),
                              dataOfPartners.length > 1
                                  ? PatnerContainer(
                                      title: dataOfPartners[1]['title'])
                                  : const SizedBox(),
                              dataOfPartners.length > 2
                                  ? PatnerContainer(
                                      title: dataOfPartners[2]['title'])
                                  : const SizedBox(),
                              dataOfPartners.length > 3
                                  ? Center(
                                      child: TextButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              isScrollControlled: true,
                                              enableDrag: false,
                                              context: context,
                                              // isDismissible: false,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(25),
                                                  topRight: Radius.circular(25),
                                                ),
                                              ),
                                              builder: (context) {
                                                return PartenerBottomSheetContainer(
                                                  dataOfPartners:
                                                      dataOfPartners,
                                                );
                                              },
                                            );
                                          },
                                          child: const Text("Show more")),
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

class PartenerBottomSheetContainer extends StatelessWidget {
  const PartenerBottomSheetContainer({
    super.key,
    required this.dataOfPartners,
  });
  final List dataOfPartners;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            const Text(
              "Parteners",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                  itemCount: dataOfPartners.length,
                  itemBuilder: (context, index) {
                    var data = dataOfPartners[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.handshake),
                          const SizedBox(width: 10),
                          Text(
                            data['title'] ?? 'Divisional Section Partner',
                          )
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
//

//
class PatnerContainer extends StatelessWidget {
  const PatnerContainer({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.handshake),
        const SizedBox(width: 5),
        SizedBox(
          width: 300,
          child: Text(
            title,
          ),
        )
      ],
    );
  }
}

 // defaultSpaceHeight,
                  // SizedBox(
                  //   height: dataOfPartners.length > 2 ? 180 : 100,
                  //   child: GridView.builder(
                  //       gridDelegate:
                  //           const SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: 2,
                  //         mainAxisSpacing: 5,
                  //         crossAxisSpacing: 5,
                  //         childAspectRatio: 2,
                  //       ),
                  //       itemCount: dataOfPartners.length,
                  //       itemBuilder: (context, index) {
                  //         var data = dataOfPartners[index];
                  //         if (index > 2) {
                  //           return const Text('More...');
                  //         } else {
                  //           return Container(
                  //             padding: defaultSymetricPeding,
                  //             decoration: BoxDecoration(
                  //               color: appBg,
                  //               borderRadius: BorderRadius.circular(8),
                  //             ),
                  //             child: SingleChildScrollView(
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 mainAxisAlignment: MainAxisAlignment.start,
                  //                 children: [
                  //                   const Icon(Icons.handshake),
                  //                   // SizedBox(height: ),
                  //                   Text(
                  //                     data['title'] ??
                  //                         'Divisional Section Partner',
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //           );
                  //         }
                  //       }),
                  // ),