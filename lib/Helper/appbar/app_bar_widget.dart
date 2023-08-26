import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Pages/Wishlist/wishlist_page.dart';
import 'package:racemart_app/Provider/Home%20providers/home_page_provider.dart';
import '../../Pages/Find A Race/find_race_page.dart';
import '../../Pages/Home/Components/event_names_for_route.dart';
import '../../Pages/Home/Drawer/zoom_drawer.dart';
import '../../Provider/User interest/user_interest_provider.dart';
import '../../Utils/app_color.dart';
import '../Widget/custome_app_bar_widget.dart';
import '../Widget/text_button_widget.dart';

PreferredSizeWidget customeAppBar(BuildContext context,
    {required HomeProvider provider, required double h}) {
  return PreferredSize(
    preferredSize: const Size(double.infinity, 120),
    child: Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: white,

            // backgroundColor: halfWhite.withAlpha(1),
            leading: const MenuWidget(),
            actions: [
              //Like button
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const WishListPage()),
                  );
                },
                icon: const Icon(
                  Icons.favorite_border_sharp,
                  color: blackColor,
                ),
              ),
              //filtre button for userinterest page
              provider.selectedIndex == 1
                  ? IconButton(
                      onPressed: () {
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
                            builder: (context) {
                              return UserInterestBootomSheet(h: h);
                            });
                        print('filter');
                      },
                      icon: const Icon(
                        Icons.filter_list,
                        color: blackColor,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8, top: 10),
            child: EventNamesForRoute(),
          ),
        ],
      ),
    ),
  );
}

class UserInterestBootomSheet extends StatefulWidget {
  const UserInterestBootomSheet({super.key, required this.h});
  final double h;

  @override
  State<UserInterestBootomSheet> createState() =>
      _UserInterestBootomSheetState();
}

class _UserInterestBootomSheetState extends State<UserInterestBootomSheet> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final provider =
          Provider.of<UserInterestProvider>(context, listen: false);
      provider.fetchSelectedUserInterest(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);
    return Container(
      height: widget.h * 0.85,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Consumer<UserInterestProvider>(
        builder: (context, provider, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //heading
              const CustomeTextWidget(
                title: 'User Interest',
              ),
              const Divider(),
              const SizedBox(height: 10),
              //
              provider.isSelected
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          CustomeMultiSelectDropDown(
                            btnText: 'Select Type',
                            dialogHintText: "Select Type",
                            items: homeProvider.listOfAllTypeData.map((val) {
                              return MultiSelectItem(
                                  val['id'], val['category']);
                            }).toList(),
                            intialValue: provider.selectedType.isEmpty
                                ? homeProvider.listOfType
                                : provider.selectedType,
                            onConfirm: (val) {
                              homeProvider.listOfType.clear();
                              homeProvider.changeType(val);
                            },
                          ),

                          const SizedBox(height: 20),
                          CustomeMultiSelectDropDown(
                            btnText: 'Select Terrains',
                            dialogHintText: "Select Terrains",
                            items: homeProvider.listOfTerrainsData.map((val) {
                              return MultiSelectItem(val['id'], val['name']);
                            }).toList(),
                            intialValue: provider.selectedTerrains.isEmpty
                                ? homeProvider.listOfTerrains
                                : provider.selectedTerrains,
                            onConfirm: (val) {
                              homeProvider.listOfTerrains.clear();
                              homeProvider.changeTrainsData(val);
                            },
                          ),
                          const SizedBox(height: 20),
                          //
                          CustomeMultiSelectDropDown(
                            btnText: 'Select Cities',
                            dialogHintText: "Select Cities",
                            items: homeProvider.listOfCitiesNames.map((val) {
                              return MultiSelectItem(val['id'], val['name']);
                            }).toList(),
                            intialValue: provider.selectedCities.isEmpty
                                ? homeProvider.listOfCitiesData
                                : provider.selectedCities,
                            onConfirm: (val) {
                              homeProvider.listOfCitiesData.clear();
                              homeProvider.changeCitiesData(val);
                            },
                          ),
                          //partners
                          const SizedBox(height: 20),
                          CustomeMultiSelectDropDown(
                            btnText: 'Select distance',
                            dialogHintText: "Select distances",
                            items: homeProvider.listOfDetancesNames.map((val) {
                              return MultiSelectItem(val['id'], val['name']);
                            }).toList(),
                            intialValue: provider.selectedDistances.isEmpty
                                ? homeProvider.listOfDistanceData
                                : provider.selectedDistances,
                            onConfirm: (val) {
                              homeProvider.listOfDistanceData.clear();
                              homeProvider.changeDistance(val);
                            },
                          ),
                          const SizedBox(height: 20),
                          TextButtonWidget(
                              text: 'Update',
                              pres: () {
                                provider.updateUserInterest(
                                  context,
                                  city: homeProvider.listOfCitiesData,
                                  type: homeProvider.listOfType,
                                  distances: homeProvider.listOfDistanceData,
                                  terrains: homeProvider.listOfTerrains,
                                );
                              }),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    )
            ],
          );
        },
      ),
    );
  }
}
