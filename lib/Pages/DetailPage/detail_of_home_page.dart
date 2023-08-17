import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Utils/app_color.dart';
import 'package:vertical_tab_bar_view/vertical_tab_bar_view.dart';
import '../../Provider/detail_page_provider.dart';
import '../../Utils/app_asset.dart';
import '../../Utils/app_size.dart';
import 'Components/ImpDateAndTerrains/impdate_and_terrains.dart';
import 'Components/dateAndDescription/components/registration_container.dart';
import 'Components/dateAndDescription/date_and_description.dart';
import 'Components/distancesAndPartners.dart/distances_and_partners.dart';
import 'Components/heading_of_detail_page.dart';
import 'Components/image_heading_container.dart';
import 'Components/priceAndLocation/components/location_contaner.dart';
import 'Components/priceAndLocation/price_and_location.dart';
import 'Components/similar_listing_list.dart';

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
    TabController controller = TabController(length: 5, vsync: this);
    //
    final provider = Provider.of<DetailProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: appBg,
      body: SafeArea(
        child: provider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TabBar(
                        controller: controller,
                        labelColor: blackColor,
                        indicatorColor: blueColor,
                        indicatorWeight: 2,
                        isScrollable: true,
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 40),
                        tabs: const [
                          Tab(text: 'Description'),
                          Tab(text: 'Distances&Partners'),
                          Tab(text: 'Price&loaction'),
                          Tab(text: 'Imporatnt&Terrains'),
                          Tab(text: 'Simlilar listing'),
                        ]),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child:
                        VerticalTabBarView(controller: controller, children: [
                      DataAndDescription(data: provider.detailEventData),
                      DistancesAndPartenr(data: provider.detailEventData),
                      PriceAndLocation(data: provider.detailEventData),
                      ImpDateAndTerrains(data: provider.detailEventData),
                      SimilarListingList(data: provider.detailEventData),
                    ]),
                  ),
                ],
              ),
      ),
    );
  }
}
