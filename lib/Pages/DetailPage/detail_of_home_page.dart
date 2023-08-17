import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Utils/app_color.dart';
import '../../Provider/detail_page_provider.dart';
import '../../Utils/app_asset.dart';
import '../../Utils/app_size.dart';
import 'Components/dateAndDescription/components/discription_container.dart';
import 'Components/dateAndDescription/components/registration_container.dart';
import 'Components/distancesAndPartners.dart/components/distance_container_list.dart';
import 'Components/distancesAndPartners.dart/components/partener_container_list.dart';
import 'Components/heading_of_detail_page.dart';
import 'Components/how_to_reac_container.dart';
import 'Components/image_heading_container.dart';
import 'Components/important_dates_list.dart';
import 'Components/priceAndLocation/components/location_contaner.dart';
import 'Components/priceAndLocation/components/price_listing_container.dart';
import 'Components/similar_listing_list.dart';
import 'Components/terains_container_list.dart';

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
    // int isSelectedIndex = 0;
    final size = MediaQuery.of(context).size.height;
    // TabController controller = TabController(length: 5, vsync: this);
    ScrollController scrollController = ScrollController();
    //
    final provider = Provider.of<DetailProvider>(context, listen: true);
    List tabContent = [
      DescriptionContainer(data: provider.detailEventData),
      DistanceContainerList(data: provider.detailEventData),
      PartenerContainerList(data: provider.detailEventData),
      PriceListingContainer(data: provider.detailEventData),
      HowToREachContainer(data: provider.detailEventData),
      ImporantDatesList(data: provider.detailEventData),
      TerrainsContainerList(data: provider.detailEventData),
      SimilarListingList(data: provider.detailEventData),
    ];
    List<Map> containerNames = [
      // {'h': size * 0.4, 'key': 'All'},
      {'h': size * 0.4, 'key': 'Description'},
      {'h': size * 0.42, 'key': 'Distances'},
      {'h': size * 0.31, 'key': 'Partners'},
      {'h': size * 0.3, 'key': 'Prices'},
      {'h': size * 0.28, 'key': 'How to reach'},
      {'h': size * 0.265, 'key': 'Important Dates'},
      {'h': size * 0.26, 'key': 'Terrains'},
      {'h': size * 0.25, 'key': 'similar listing'}
    ];
    void scrollToTap(int index) {
      double sizeOfContainer = containerNames[index]['h'];
      scrollController.animateTo(index * sizeOfContainer,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }

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
                      title: widget.data['title']),
                  spacingHeightMin1,
                  HedingOfDetailPage(title: widget.data['title']),
                  spacingHeightMin,
                  widget.data['city'] == null
                      ? const SizedBox()
                      : LoctionContair(location: widget.data['city']),
                  const SizedBox(height: 8),
                  RegistrationContainer(data: widget.data),
                  const Divider(),
                  //horizontal view
                  Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        // controller: scrollController,
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

class HorizontalTabContainer extends StatelessWidget {
  const HorizontalTabContainer({
    super.key,
    required this.press,
    required this.name,
    required this.curentIndex,
    required this.selectd,
  });
  final VoidCallback press;
  final String name;
  final int curentIndex;
  final int selectd;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DetailProvider>(context, listen: true);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: provider.selectedIndex == curentIndex
            ? blueColor
            : appBg, // index == 0 ? blueColor : appBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: blackColor.withOpacity(0.2)),
      ),
      child: InkWell(
        onTap: press,
        splashColor: blueColor,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Text(
            name,
            style: TextStyle(
                color: provider.selectedIndex == curentIndex
                    ? white
                    : Colors.black),
          ),
        ),
      ),
    );
  }
}

// TopContainer(data: widget.data),
// const SizedBox(height: 10),
// Expanded(
//   child:
//       VerticalTabBarView(controller: controller, children: [
//     DataAndDescription(data: provider.detailEventData),
//     DistancesAndPartenr(data: provider.detailEventData),
//     PriceAndLocation(data: provider.detailEventData),
//     ImpDateAndTerrains(data: provider.detailEventData),
//     SimilarListingList(data: provider.detailEventData),
//   ]),
// ),

   //
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: TabBar(
                  //       controller: controller,
                  //       labelColor: blackColor,
                  //       indicatorColor: blueColor,
                  //       indicatorWeight: 2,
                  //       isScrollable: true,
                  //       labelPadding:
                  //           const EdgeInsets.symmetric(horizontal: 40),
                  //       tabs: const [
                  //         Tab(text: 'Description'),
                  //         Tab(text: 'Distances&Partners'),
                  //         Tab(text: 'Price&loaction'),
                  //         Tab(text: 'Imporatnt&Terrains'),
                  //         Tab(text: 'Simlilar listing'),
                  //       ]),
                  // ),
                  // Expanded(
                  //   child: ListView(
                  //     // controller: controller,
                  //     children: const [],
                  //   ),
                  // ),
                  //
                  // Expanded(
                  //   child: VerticalTabBarView(
                  //     controller: controller,
                  //     children: const [
                  //       Column(
                  //         children: [
                  //           Text('new'),
                  //           Text('new'),
                  //           Text('new'),
                  //           Text('new'),
                  //           Text('new'),
                  //         ],
                  //       ),
                  //       Text('new'),
                  //       Text('new'),
                  //       Text('new'),
                  //       Text('new'),

                  // DescriptionContainer(data: provider.detailEventData),
                  // DataAndDescription(data: provider.detailEventData),
                  // DistancesAndPartenr(data: provider.detailEventData),
                  // PriceAndLocation(data: provider.detailEventData),
                  // ImpDateAndTerrains(data: provider.detailEventData),
                  // SimilarListingList(data: provider.detailEventData),
                  // ],
                  // ),
                  // ),