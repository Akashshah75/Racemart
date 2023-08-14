import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Pages/Home/DetailPage/detail_of_home_page.dart';
import 'package:racemart_app/Provider/Home%20providers/home_page_provider.dart';

import '../../../Helper/Widget/heading_text.dart';
import '../../../Helper/Widget/text_widget.dart';
import '../../../Network/base_clent.dart';
import '../../../Provider/authentication_provider.dart';
import '../../../Utils/app_asset.dart';
import '../../../utils/app_color.dart';

class TheLatestListing extends StatefulWidget {
  const TheLatestListing({
    super.key,
    required this.provider,
  });
  final HomeProvider provider;

  @override
  State<TheLatestListing> createState() => _TheLatestListingState();
}

class _TheLatestListingState extends State<TheLatestListing> {
  final controllers = ScrollController();
  bool hasMore = true;
  int page = 1;
  bool isLoading = false;
  @override
  void initState() {
    controllers.addListener(() {
      if (controllers.position.maxScrollExtent == controllers.offset) {
        fetch();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controllers.dispose();
    super.dispose();
  }

  Future fetch() async {
    if (isLoading) return;
    isLoading = true;
    const limit = 10;
    var provider = Provider.of<AuthenticationProvider>(context, listen: false);
    final url =
        "https://racemart.youtoocanrun.com/api/latest-listing?page=$page";
    var res = await BaseClient()
        .getMethodWithToken(url, provider.appLoginToken.toString());

    var result = jsonDecode(res);
    final List newEvent = result['data']['list'];

    //
    setState(() {
      page++;

      isLoading = false;
      if (newEvent.length < limit) {
        hasMore = false;
      }
      widget.provider.theLatestListing.addAll(newEvent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 645,
      child: widget.provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : widget.provider.theLatestListing.isEmpty
              ? Center(child: Image.asset(noDataFound))
              : ListView.builder(
                  controller: controllers,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.provider.theLatestListing.length + 1,
                  itemBuilder: (context, index) {
                    if (index < widget.provider.theLatestListing.length) {
                      var dataOfEvent = widget.provider.theLatestListing[index];
                      return GestureDetector(
                        key: ValueKey(dataOfEvent['id']),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailPageOfHome(
                                    index: index,
                                    data: dataOfEvent,
                                  )));
                        },
                        child: EventContainer(data: dataOfEvent),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: hasMore
                              ? const CircularProgressIndicator()
                              : const Text('No more data to load?'),
                        ),
                      );
                    }
                    // var dataOfEvent = widget.provider.theLatestListing[index];
                    // return EventContainer(data: dataOfEvent);
                  },
                ),
    );
  }
}

///////////////////////////////////////////////////////

class EventContainer extends StatelessWidget {
  const EventContainer({
    super.key,
    this.data,
  });
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(color: blackColor.withOpacity(0.1)),
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(data['poster']),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10),
            child: HeadingText(
                fontSize: 16,
                text: data['title'], //'Heading',
                color: redColor //blueColor,
                ),
          ),
          //
          const SizedBox(height: 10),
          Container(
            width: 350,
            margin: const EdgeInsets.only(bottom: 10, left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on,
                  size: 15,
                  color: redColor,
                ),
                const SizedBox(width: 2),
                TextWidget(
                  fontSize: 14,
                  text: data['city'], // 'location',
                  color: blueColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
