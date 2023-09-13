import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Pages/Home/Drawer/zoom_drawer.dart';
import 'package:racemart_app/Provider/Home%20providers/home_page_provider.dart';
import 'package:racemart_app/Utils/app_color.dart';
import 'package:racemart_app/Utils/constant.dart';
import '../../Helper/Widget/custome_textfield.dart';
import '../../Helper/Widget/drop_down_btn.dart';
import '../../Helper/Widget/text_button_widget.dart';
import '../../Provider/review a race provider/review_a_race_provider.dart';
import '../Find A Race/find_race_page.dart';
import 'Components/review_event_listing.dart';

class ReviewARacePage extends StatefulWidget {
  const ReviewARacePage({super.key});

  @override
  State<ReviewARacePage> createState() => _ReviewARacePageState();
}

class _ReviewARacePageState extends State<ReviewARacePage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final provider = Provider.of<ReviewARaceProvider>(context, listen: false);
      provider.searchEvent(context);

      provider.reviewRaceEvent(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    DateTime timeBackPressed = DateTime.now();
    final provider = Provider.of<ReviewARaceProvider>(context, listen: true);
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);

    return WillPopScope(
      onWillPop: () async {
        final diffrence = DateTime.now().difference(timeBackPressed);
        final isExitWarning = diffrence >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        return exitTheAppMethod(isExitWarning);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 0,
          leading: const MenuWidget(),
          title: const Text(
            'Past Events',
            style: TextStyle(
              color: blackColor,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                homeProvider.chageListToGrid();
              },
              icon: Icon(
                homeProvider.isList ? Icons.grid_view : Icons.list,
                color: blackColor,
              ),
            )
          ],
        ),
        body: provider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          enableDrag: false,
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          builder: (context) => SearchPastEventPage(h: h),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: appBg,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Search past event'),
                              Icon(Icons.search),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ReviewAEventListing(provider: provider),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
      ),
    );
  }
}

class SearchPastEventPage extends StatelessWidget {
  const SearchPastEventPage({super.key, required this.h});
  final double h;

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);
    return Consumer<ReviewARaceProvider>(
      builder: (context, value, child) {
        final reviewProvider = value;
        return Container(
          height: h * 0.75,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: h * 0.02),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.arrow_back),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Search",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      //
                      MaterialButton(
                        onPressed: () {
                          reviewProvider.cleanDropDownBoxes();
                        },
                        child: const Text('Clean'),
                      )
                    ],
                  ),
                ),
                SizedBox(height: h * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomeTextField(
                    hintText: 'What are you looking for?',
                    icon: Icons.bookmark_outline,
                    textInputType: TextInputType.name,
                    controller: reviewProvider.search,
                  ),
                ),
                SizedBox(height: h * 0.025),
                EventDropDownButton(
                  hintText: 'All Type',
                  choseValue: reviewProvider.choseAllType,
                  onChanged: (val) {
                    reviewProvider.changeAllType(val);
                  },
                  items: homeProvider.listOfAllTypeData.map((val) {
                    return DropdownMenuItem(
                      value: val['id'].toString(),
                      child: Text(val['category']),
                    );
                  }).toList(),
                ),
                SizedBox(height: h * 0.025),
                EventDropDownButton(
                  hintText: 'All cities',
                  choseValue: reviewProvider.choseCity,
                  onChanged: (val) {
                    reviewProvider.changeDropDownVal(val);
                  },
                  items: homeProvider.listOfCitiesNames.map((val) {
                    return DropdownMenuItem(
                      value: val['id'].toString(),
                      child: Text(val['name']),
                    );
                  }).toList(),
                ),
                SizedBox(height: h * 0.025),
                //distances
                CustomeMultiSelectDropDown(
                  btnText: 'Select distance',
                  dialogHintText: "Select distances",
                  items: homeProvider.listOfDetancesNames.map((val) {
                    return MultiSelectItem(val['id'], val['name']);
                  }).toList(),
                  intialValue: reviewProvider.listOfDistanceData,
                  onConfirm: (val) {
                    reviewProvider.listOfDistanceData.clear();
                    reviewProvider.changeDistance(val);
                  },
                ),
                //badge
                SizedBox(height: h * 0.025),
                CustomeMultiSelectDropDown(
                  btnText: 'Select Badges',
                  dialogHintText: "Select Badges",
                  items: homeProvider.listOfBadgeNames.map((val) {
                    return MultiSelectItem(val['id'], val['title']);
                  }).toList(),
                  intialValue: reviewProvider.listOfBadgeData,
                  onConfirm: (val) {
                    reviewProvider.listOfBadgeData.clear();
                    reviewProvider.changeBadge(val);
                  },
                ),
                //partners
                SizedBox(height: h * 0.025),
                CustomeMultiSelectDropDown(
                  btnText: 'Select Partners',
                  dialogHintText: "Select Partners",
                  items: homeProvider.listOfPartnersNames.map((val) {
                    return MultiSelectItem(val['id'], val['title']);
                  }).toList(),
                  intialValue: reviewProvider.listOfPartnersData,
                  onConfirm: (val) {
                    reviewProvider.listOfPartnersData.clear();
                    reviewProvider.changePartners(val);
                  },
                ),
                SizedBox(height: h * 0.025),
                TextButtonWidget(
                    text: 'Search',
                    pres: () {
                      reviewProvider
                          .searchEvent(
                        context,
                        category: reviewProvider.choseAllType,
                        city: reviewProvider.choseCity,
                        distance: reviewProvider.listOfDistanceData,
                        badge: reviewProvider.listOfBadgeData,
                        partner: reviewProvider.listOfPartnersData,
                      )
                          .then((_) {
                        Navigator.of(context).pop();
                      });
                    }),
                const SizedBox(height: 20)
              ],
            ),
          ),
        );
      },
    );
  }
}
