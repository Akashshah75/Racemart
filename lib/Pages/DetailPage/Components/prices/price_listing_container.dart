import 'package:flutter/material.dart';

import '../../../../Helper/Widget/heading_text.dart';
import '../../../../Helper/Widget/text_widget.dart';
import '../../../../utils/app_color.dart';

class PriceListingContainer extends StatelessWidget {
  const PriceListingContainer({
    super.key,
    this.data,
  });
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    List priceOfData = data['prices'] ?? [];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: double.infinity,
      height: 190,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeadingText(
              text: 'Prices',
              fontSize: 16,
              color: blackColor,
            ),
            const Divider(),
            priceOfData.isEmpty
                ? const Center(
                    child: Text("Don't have any prices!"),
                  )
                : Column(
                    children: [
                      PriceRowListing(
                        title: priceOfData[0]['title'],
                        date: priceOfData[0]['price'].toString(),
                      ),
                      priceOfData.length > 1
                          ? PriceRowListing(
                              title: priceOfData[1]['title'],
                              date: priceOfData[1]['price'].toString(),
                            )
                          : const SizedBox(),
                      // priceOfData.length > 2
                      //     ? PriceRowListing(
                      //         title: priceOfData[2]['title'],
                      //         date: priceOfData[0]['price'].toString(),
                      //       )
                      //     : const SizedBox(),
                      // const SizedBox(height: 10),
                      priceOfData.length > 2
                          ? const Divider()
                          : const SizedBox(),
                      priceOfData.length > 2
                          ? Center(
                              child: TextButton(
                                  onPressed: () {
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
                                        return PricesBottomSheetContainer(
                                          priceOfData: priceOfData,
                                        );
                                      },
                                    );
                                  },
                                  child: const Text("Show more")),
                            )
                          : const SizedBox(),
                      priceOfData.length < 3
                          ? const SizedBox(height: 5)
                          : const SizedBox(),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

class PricesBottomSheetContainer extends StatelessWidget {
  const PricesBottomSheetContainer({
    super.key,
    required this.priceOfData,
  });
  final List priceOfData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 350,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              const Text(
                "Prices",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              //
              Expanded(
                child: ListView.builder(
                    itemCount: priceOfData.length,
                    itemBuilder: (context, index) {
                      var pirceData = priceOfData[index];
                      return PriceRowListingWithData(data: pirceData);
                    }),
              ),
            ],
          ),
        ));
  }
}
//

//
class PriceRowListing extends StatelessWidget {
  const PriceRowListing({
    super.key,
    required this.title,
    required this.date,
    // this.data,
  });
  // final dynamic data;
  final String title;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 250,
            child: HeadingText(
              text: title, // data['title'] ?? 'Full Marathon 42.195 Km Run ',
              fontSize: 14,
              color: greyColor.withAlpha(250),
            ),
          ),
          TextWidget(
            text: '\u20B9$date', //data['price'].toString(),
            fontSize: 16,
            weight: FontWeight.w400,
          )
        ],
      ),
    );
  }
}

class PriceRowListingWithData extends StatelessWidget {
  const PriceRowListingWithData({
    super.key,
    this.data,
  });
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 250,
            child: HeadingText(
              text: data['title'] ?? 'Full Marathon 42.195 Km Run ',
              fontSize: 14,
              color: greyColor.withAlpha(250),
            ),
          ),
          TextWidget(
            text: "\u20B9${data['price']}",
            fontSize: 16,
            weight: FontWeight.w400,
          )
        ],
      ),
    );
  }
}


//
  // SizedBox(
  //                   height: 160,
  //                   child: 
  // ListView.builder(
  //                       itemCount: priceOfData.length,
  //                       itemBuilder: (context, index) {
  //                         var pirceData = priceOfData[index];
  //                         if (index > 4) {
  //                           return const Text('more...');
  //                         } else {
  //                           return PriceRowListing(data: pirceData);
  //                         }
  //                       }),
  //                 ),

  //Listview
                  // SizedBox(
                  //   height: 160,
                  //   child: ListView.builder(
                  //       itemCount: priceOfData.length,
                  //       itemBuilder: (context, index) {
                  //         var pirceData = priceOfData[index];
                  //         if (index > 4) {
                  //           return const Text('more...');
                  //         } else {
                  //           return PriceRowListing(data: pirceData);
                  //         }
                  //       }),
                  // ),s