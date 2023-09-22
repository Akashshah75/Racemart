import 'package:flutter/material.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/app_size.dart';

class GalaryContainer extends StatelessWidget {
  const GalaryContainer({
    super.key,
    this.data,
  });
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    List listOfGalary = data['gallery'] ?? [];
    return Container(
      margin: defaultSymetricPeding,
      width: double.infinity,
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: white,
      ),
      child: Padding(
        padding: defaultSymetricPeding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            defaultSpaceHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 2),
                  child: const Text(
                    'Galary',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: blackColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                listOfGalary.length > 2
                    ? InkWell(
                        onTap: () {
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
                              Size size = MediaQuery.of(context).size;
                              return SizedBox(
                                height: size.height / 2 + 100,
                                child: ListOfGalary(listOfGalary: listOfGalary),
                              );
                            },
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Text(
                            'More..',
                            style: TextStyle(
                              color: blueColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ))
                    : const SizedBox(),
              ],
            ),
            const Divider(),
            //
            listOfGalary.isNotEmpty
                ? Column(
                    children: [
                      GalaryItemContainer(data: listOfGalary[0]),
                      listOfGalary.length > 1
                          ? GalaryItemContainer(data: listOfGalary[0])
                          : const SizedBox(),
                    ],
                  )
                : const Center(
                    child: Text('No galary image!!'),
                  )
          ],
        ),
      ),
    );
  }
}

class GalaryItemContainer extends StatelessWidget {
  const GalaryItemContainer({
    super.key,
    this.data,
  });
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(data),
        ),
      ),
    );
  }
}

class ListOfGalary extends StatelessWidget {
  const ListOfGalary({
    super.key,
    required this.listOfGalary,
  });
  final List listOfGalary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          const Text(
            "Galary",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ListView.builder(
                itemCount: listOfGalary.length,
                itemBuilder: (context, index) {
                  final galary = listOfGalary[index];
                  return GalaryItemContainer(data: galary);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
