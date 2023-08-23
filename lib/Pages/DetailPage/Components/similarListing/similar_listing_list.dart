import 'package:flutter/material.dart';
import '../../../../Utils/app_asset.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/app_size.dart';
import '../../detail_of_home_page.dart';
import 'components/similar_listingt_container.dart';

class SimilarListing extends StatelessWidget {
  const SimilarListing({super.key, this.data});
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    List similarListingDataList = data['similar_events'] ?? [];
    return similarListingDataList.isEmpty
        ? Center(
            child: Image.asset(noDataFound),
          )
        : Container(
            margin: defaultSymetricPeding,
            width: double.infinity,
            height: 380,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 10),
                  child: const Text(
                    'Similar listing',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: blackColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const Divider(),
                //
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: similarListingDataList.length,
                      itemBuilder: (context, index) {
                        var similarListingData = similarListingDataList[index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailPageOfHome(
                                    index: index, data: similarListingData),
                              ),
                            );
                          },
                          child: SimilarListingtContainer(
                            data: similarListingData,
                            // width: 3,
                            width:
                                similarListingDataList.length > 1 ? 320 : 350,
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
  }
}
