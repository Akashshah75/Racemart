import 'package:flutter/material.dart';

import '../../../../Utils/app_color.dart';
import '../../../../Utils/app_size.dart';
import '../distance/distance_container_list.dart';

class DeleverableContainer extends StatelessWidget {
  const DeleverableContainer({
    super.key,
    this.data,
  });
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    List listOfDeliverables = data['deliverables'] ?? [];
    print(listOfDeliverables);
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
              'Deliverables',
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
          listOfDeliverables.isEmpty
              ? const SizedBox(
                  child: Center(
                    child: Text("Don't have deliverables!!!"),
                  ),
                )
              : Row(
                  children: [
                    DeliverablesImageContainer(
                        deliverableImage: listOfDeliverables[0]['image']),
                    const SizedBox(width: 10),
                    listOfDeliverables.length > 1
                        ? DeliverablesImageContainer(
                            deliverableImage: listOfDeliverables[1]['image'])
                        : const SizedBox(),
                    const SizedBox(width: 10),
                    listOfDeliverables.length > 2
                        ? DeliverablesImageContainer(
                            deliverableImage: listOfDeliverables[2]['image'])
                        : const SizedBox(),
                    const SizedBox(width: 10),
                    listOfDeliverables.length > 3
                        ? DeliverablesImageContainer(
                            deliverableImage: listOfDeliverables[3]['image'])
                        : const SizedBox(),
                    const SizedBox(width: 10),
                    listOfDeliverables.length > 4
                        ? DeliverablesImageContainer(
                            deliverableImage: listOfDeliverables[4]['image'])
                        : const SizedBox(),
                    const SizedBox(width: 10),
                    listOfDeliverables.length > 5
                        ? DeliverablesImageContainer(
                            deliverableImage: listOfDeliverables[5]['image'])
                        : const SizedBox(),
                    const SizedBox(width: 10),
                    listOfDeliverables.length > 6
                        ? IconButtonContainer(press: () {
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
                                return DeliverablesBottomSheet(
                                  listOfDeliverables: listOfDeliverables,
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

class DeliverablesImageContainer extends StatelessWidget {
  const DeliverablesImageContainer({
    super.key,
    required this.deliverableImage,
  });

  final String deliverableImage;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Image.network(deliverableImage),
    );
  }
}

class DeliverablesBottomSheet extends StatelessWidget {
  const DeliverablesBottomSheet({
    super.key,
    required this.listOfDeliverables,
  });
  final List listOfDeliverables;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            const Text(
              "Deliverables",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5,
                      childAspectRatio: 3,
                    ),
                    itemCount: listOfDeliverables.length,
                    itemBuilder: (context, index) {
                      var deliverablesData = listOfDeliverables[index];
                      return ListOfDeliverablesImage(
                        data: deliverablesData,
                      );
                    })),
          ],
        ),
      ),
    );
  }
}

class ListOfDeliverablesImage extends StatelessWidget {
  const ListOfDeliverablesImage({
    super.key,
    this.data,
  });
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: data['image'] == null
          ? const SizedBox()
          : Image.network(data['image']),
    );
  }
}
