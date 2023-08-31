import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../Pages/DetailPage/Components/Description/discription_container.dart';
import '../Pages/DetailPage/Components/deliverables/deliverables_container.dart';
import '../Pages/DetailPage/Components/distance/distance_container_list.dart';
import '../Pages/DetailPage/Components/heading_of_detail_page.dart';
import '../Pages/DetailPage/Components/horizontal_tab_container.dart';
import '../Pages/DetailPage/Components/howToRach/how_to_reac_container.dart';
import '../Pages/DetailPage/Components/image_heading_container.dart';
import '../Pages/DetailPage/Components/impDate/important_dates_list.dart';
import '../Pages/DetailPage/Components/location/location_contaner.dart';
import '../Pages/DetailPage/Components/partener/partener_container_list.dart';
import '../Pages/DetailPage/Components/prices/price_listing_container.dart';
import '../Pages/DetailPage/Components/registerDateContainer/registration_date_container.dart';
import '../Pages/DetailPage/Components/registration_now_container.dart';
import '../Pages/DetailPage/Components/similarListing/similar_listing_list.dart';
import '../Pages/DetailPage/Components/terrrains/terains_container_list.dart';
import '../Provider/detail_page_provider.dart';
import '../Utils/app_asset.dart';
import '../Utils/app_color.dart';
import '../Utils/app_size.dart';
import 'package:http/http.dart' as http;

class NotificationDetailPage extends StatefulWidget {
  const NotificationDetailPage({super.key, required this.eventId});

  // final int index;
  final dynamic eventId;

  @override
  State<NotificationDetailPage> createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final provider = Provider.of<DetailProvider>(context, listen: false);
      provider.fetchEventDetail(context, widget.eventId);
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
      //
      RegisterationDateContainer(data: provider.detailEventData),
      //
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
    ];
    List<Map> containerNames = [
      {'h': size * 0.3, 'key': 'Registration date'},
      {'h': size * 0.25, 'key': 'Description'},
      {'h': size * 0.33, 'key': 'Distances'},
      {'h': size * 0.29, 'key': 'Partners'},
      {'h': size * 0.285, 'key': 'Prices'},
      {'h': size * 0.29, 'key': 'How to reach'},
      {'h': size * 0.285, 'key': 'Important Dates'},
      {'h': size * 0.285, 'key': 'Terrains'},
      {'h': size * 0.269, 'key': 'Deliverables'},
      {'h': size * 0.35, 'key': 'similar listing'}
    ];
    void scrollToTap(int index) {
      double sizeOfContainer = containerNames[index]['h'];
      scrollController.animateTo(index * sizeOfContainer,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }

    print('Detail:${provider.detailEventData}');
    print(widget.eventId);
    // print('Event_Id: ${widget.data['id']}');
    return Scaffold(
      backgroundColor: appBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBg,
        iconTheme: IconThemeData(color: blackColor),
        title: Text(
          'Details',
          style: TextStyle(color: blackColor),
        ),
        actions: [
          provider.detailEventData['share-url'] == null
              ? SizedBox()
              : IconButton(
                  onPressed: () async {
                    var urlImage = provider.detailEventData['poster'] ??
                        demo; //provider.detailEventData['poster']; //urlImage1;
                    final Uri url = Uri.parse(urlImage);
                    final res = await http.get(url);
                    final bytes = res.bodyBytes;
                    final temp = await getTemporaryDirectory();
                    final path = '${temp.path}/image.jpg';
                    File(path).writeAsBytesSync(bytes);
                    // ignore: deprecated_member_use
                    await Share.shareFiles(
                      [path],
                      text: provider.detailEventData['share-url'] ?? 'url',
                    );
                  },
                  icon: Icon(Icons.share),
                )
        ],
      ),
      body: SafeArea(
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  ImageHedingContainer(
                    shareUrl: provider.detailEventData['share-url'] ?? 'url',
                    image: provider.detailEventData['poster'] ?? demo,
                    title: provider.detailEventData['title'] ?? '',
                    registrationUrl:
                        provider.detailEventData['registration_url'] ?? "",
                    earlyStartDate:
                        provider.detailEventData['early_start_date'] ?? "",
                    earlyEndDate:
                        provider.detailEventData['early_end_date'] ?? "",
                  ),
                  spacingHeightMin1,
                  HedingOfDetailPage(
                      title: provider.detailEventData['title'] ?? ""),
                  spacingHeightMin,
                  provider.detailEventData['city'] == null
                      ? const SizedBox()
                      : LoctionContair(
                          location: provider.detailEventData['city']),
                  const SizedBox(height: 8),
                  RegisterNowContainer(
                      registrationUrl:
                          provider.detailEventData['registration_url'] ?? ''),
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
