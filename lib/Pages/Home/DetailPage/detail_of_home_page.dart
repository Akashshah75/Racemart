import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Pages/Home/DetailPage/Components/registration_container.dart';
import 'package:racemart_app/Utils/app_color.dart';
import 'package:vertical_tab_bar_view/vertical_tab_bar_view.dart';
import '../../../Provider/detail_page_provider.dart';
import '../../../Utils/app_asset.dart';
import '../../../Utils/app_size.dart';
import 'Components/discription_container.dart';
import 'Components/distance_container_list.dart';
import 'Components/heading_of_detail_page.dart';
import 'Components/how_to_reac_container.dart';
import 'Components/image_heading_container.dart';
import 'Components/important_dates_list.dart';
import 'Components/location_contaner.dart';
import 'Components/partener_container_list.dart';
import 'Components/price_listing_container.dart';
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
                  HedingOfDetailPage(
                    title: widget.data['title'],
                  ),
                  spacingHeightMin,
                  widget.data['city'] == null
                      ? const SizedBox()
                      : LoctionContair(location: widget.data['city']),
                  const Divider(),
                  // spacingHeightMedium,
                  // const BodyRouteOfDetailPage(),
                  //
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
                          Tab(text: 'Date&Description'),
                          Tab(text: 'Distances&Partners'),
                          Tab(text: 'Price&loaction'),
                          Tab(text: 'Imporatnt&Terrains'),
                          Tab(text: 'Simlilar listing'),
                        ]),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
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

//
class ImpDateAndTerrains extends StatelessWidget {
  const ImpDateAndTerrains({super.key, this.data});
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    return
        // SingleChildScrollView(
        //     child:
        Column(
      children: [
        ImporantDatesList(data: data),
        const SizedBox(height: 10),
        TerrainsContainerList(data: data),
      ],
      // )
    );
  }
}

//
class PriceAndLocation extends StatelessWidget {
  const PriceAndLocation({super.key, this.data});
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        PriceListingContainer(data: data),
        const SizedBox(height: 20),
        HowToREachContainer(data: data),
      ],
    );
  }
}

//
class DistancesAndPartenr extends StatelessWidget {
  const DistancesAndPartenr({super.key, this.data});
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        DistanceContainerList(data: data),
        const SizedBox(height: 10),
        PartenerContainerList(data: data),
      ],
    );
  }
}

//
class DataAndDescription extends StatelessWidget {
  const DataAndDescription({super.key, this.data});
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        spacingHeightMedium,
        RegistrationContainer(data: data),
        spacingHeightMedium,
        DescriptionContainer(data: data),
      ],
    );
  }
}
