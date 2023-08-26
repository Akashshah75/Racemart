import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Utils/app_color.dart';
import '../../Provider/detail_page_provider.dart';
import '../../Utils/app_asset.dart';
import '../../Utils/app_size.dart';
import 'Components/Description/discription_container.dart';
import 'Components/deliverables/deliverables_container.dart';
import 'Components/horizontal_tab_container.dart';
import 'Components/registerDateContainer/registration_date_container.dart';
import 'Components/distance/distance_container_list.dart';
import 'Components/partener/partener_container_list.dart';
import 'Components/heading_of_detail_page.dart';
import 'Components/howToRach/how_to_reac_container.dart';
import 'Components/image_heading_container.dart';
import 'Components/impDate/important_dates_list.dart';
import 'Components/location/location_contaner.dart';
import 'Components/prices/price_listing_container.dart';
import 'Components/similarListing/similar_listing_list.dart';
import 'Components/terrrains/terains_container_list.dart';

class DetailPageOfHome extends StatefulWidget {
  const DetailPageOfHome({super.key, required this.index, this.data});

  final int index;
  final dynamic data;

  @override
  State<DetailPageOfHome> createState() => _DetailPageOfHomeState();
}

class _DetailPageOfHomeState extends State<DetailPageOfHome>
    with TickerProviderStateMixin {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final provider = Provider.of<DetailProvider>(context, listen: false);
      provider.fetchEventDetail(context, widget.data['id']);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //for page size
    final size = MediaQuery.of(context).size.height;
    //for scrolling detail page data
    ScrollController scrollController = ScrollController();
    //provider
    final provider = Provider.of<DetailProvider>(context, listen: true);
    List tabContent = [
      DescriptionContainer(data: provider.detailEventData),
      //
      DistanceContainerList(data: provider.detailEventData),
      //
      PartenerContainerList(data: provider.detailEventData),
      //
      PriceListingContainer(data: provider.detailEventData),
      //
      HowToREachContainer(data: provider.detailEventData),
      //
      ImporantDatesList(data: provider.detailEventData),
      //
      TerrainsContainerList(data: provider.detailEventData),
      //
      DeleverableContainer(data: provider.detailEventData),
      //
      SimilarListing(data: provider.detailEventData),
      // SimilarListingList(data: provider.detailEventData),
    ];
    List<Map> containerNames = [
      // {'h': size * 0.4, 'key': 'All'},
      {'h': size * 0.4, 'key': 'Description'},
      {'h': size * 0.42, 'key': 'Distances'},
      {'h': size * 0.31, 'key': 'Partners'},
      {'h': size * 0.3, 'key': 'Prices'},
      {'h': size * 0.3, 'key': 'How to reach'},
      {'h': size * 0.29, 'key': 'Important Dates'},
      {'h': size * 0.29, 'key': 'Terrains'},
      {'h': size * 0.274, 'key': 'Deliverables'},
      {'h': size * 0.30, 'key': 'similar listing'}
    ];
    void scrollToTap(int index) {
      double sizeOfContainer = containerNames[index]['h'];
      scrollController.animateTo(index * sizeOfContainer,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }

    print('Event_Id: ${widget.data['id']}');
    return Scaffold(
      backgroundColor: appBg,
      body: SafeArea(
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  ImageHedingContainer(
                    shareUrl: widget.data['share-url'] ?? 'url',
                    image: widget.data['poster'] ?? demo,
                    title: widget.data['title'],
                    registrationUrl: widget.data['registration_url'],
                  ),
                  spacingHeightMin1,
                  HedingOfDetailPage(title: widget.data['title']),
                  spacingHeightMin,
                  widget.data['city'] == null
                      ? const SizedBox()
                      : LoctionContair(location: widget.data['city']),
                  const SizedBox(height: 8),
                  RegisterationDateContainer(data: widget.data),
                  // const Text('REgister now'),
                  const Divider(),
                  //horizontal view
                  Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: tabContent.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: HorizontalTabContainer(
                              press: () {
                                scrollToTap(index);
                                provider.changeIndex(index);
                              },
                              name: containerNames[index]['key'],
                              curentIndex: index,
                              selectd: index,
                            ),
                          );
                        }),
                  ),
                  //vertical view
                  Expanded(
                    child: ListView.builder(
                        controller: scrollController,
                        itemCount: tabContent.length,
                        itemBuilder: (context, index) {
                          return tabContent[index];
                        }),
                  ),
                ],
              ),
      ),
    );
  }
}
