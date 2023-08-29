// import 'package:flutter/material.dart';
// import 'package:multi_select_flutter/util/multi_select_item.dart';
// import 'package:provider/provider.dart';
// import 'package:racemart_app/Provider/Home%20providers/home_page_provider.dart';
// import 'package:racemart_app/Utils/app_color.dart';

// import '../../Helper/Widget/text_button_widget.dart';
// import '../../Provider/User interest/user_interest_provider.dart';
// import '../Find A Race/find_race_page.dart';

// class SearchUserInterestPage extends StatefulWidget {
//   const SearchUserInterestPage({super.key});

//   @override
//   State<SearchUserInterestPage> createState() => _SearchUserInterestPageState();
// }

// class _SearchUserInterestPageState extends State<SearchUserInterestPage> {
//   @override
//   void initState() {
//     Future.delayed(Duration.zero, () {
//       final userProvider =
//           Provider.of<UserInterestProvider>(context, listen: false);
//       userProvider.fetchSelectedUserInterest(context);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final homeProvider = Provider.of<HomeProvider>(context, listen: true);
//     final provider = Provider.of<UserInterestProvider>(context, listen: true);
//     return Scaffold(
//         backgroundColor: white,
//         appBar: AppBar(
//           backgroundColor: white,
//           elevation: 0,
//           iconTheme: const IconThemeData(color: blackColor),
//           title: const Text(
//             'User Interest',
//             style: TextStyle(color: blackColor),
//           ),
//         ),
//         body: provider.isSelected
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : Builder(builder: (context) {
//                 return SafeArea(
//                   child: Container(
//                     alignment: Alignment.center,
//                     height: double.infinity,
//                     width: double.infinity,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           const SizedBox(height: 20),
//                           CustomeMultiSelectDropDown(
//                             btnText: 'Select Type',
//                             dialogHintText: "Select Type",
//                             items: homeProvider.listOfAllTypeData.map((val) {
//                               return MultiSelectItem(
//                                   val['id'], val['category']);
//                             }).toList(),
//                             intialValue: provider.selectedType.isEmpty
//                                 ? homeProvider.listOfType
//                                 : provider.selectedType,
//                             onConfirm: (val) {
//                               homeProvider.listOfType.clear();
//                               homeProvider.changeType(val);
//                             },
//                           ),

//                           ///
//                           ///
//                           const SizedBox(height: 20),
//                           CustomeMultiSelectDropDown(
//                             btnText: 'Select Terrains',
//                             dialogHintText: "Select Terrains",
//                             items: homeProvider.listOfTerrainsData.map((val) {
//                               return MultiSelectItem(val['id'], val['name']);
//                             }).toList(),
//                             intialValue: provider.selectedTerrains.isEmpty
//                                 ? homeProvider.listOfTerrains
//                                 : provider.selectedTerrains,
//                             onConfirm: (val) {
//                               homeProvider.listOfTerrains.clear();
//                               homeProvider.changeTrainsData(val);
//                             },
//                           ),
//                           const SizedBox(height: 20),
//                           //
//                           CustomeMultiSelectDropDown(
//                             btnText: 'Select Cities',
//                             dialogHintText: "Select Cities",
//                             items: homeProvider.listOfCitiesNames.map((val) {
//                               return MultiSelectItem(val['id'], val['name']);
//                             }).toList(),
//                             intialValue: provider.selectedCities.isEmpty
//                                 ? homeProvider.listOfCitiesData
//                                 : provider.selectedCities,
//                             onConfirm: (val) {
//                               homeProvider.listOfCitiesData.clear();
//                               homeProvider.changeCitiesData(val);
//                             },
//                           ),
//                           //partners
//                           const SizedBox(height: 20),
//                           CustomeMultiSelectDropDown(
//                             btnText: 'Select distance',
//                             dialogHintText: "Select distances",
//                             items: homeProvider.listOfDetancesNames.map((val) {
//                               return MultiSelectItem(val['id'], val['name']);
//                             }).toList(),
//                             intialValue: provider.selectedDistances.isEmpty
//                                 ? homeProvider.listOfDistanceData
//                                 : provider.selectedDistances,
//                             onConfirm: (val) {
//                               homeProvider.listOfDistanceData.clear();
//                               homeProvider.changeDistance(val);
//                             },
//                           ),
//                           //badge

//                           //partners

//                           const SizedBox(height: 20),
//                           TextButtonWidget(
//                               text: 'Update',
//                               pres: () {
//                                 provider.updateUserInterest(
//                                   context,
//                                   city: homeProvider.listOfCitiesData,
//                                   type: homeProvider.listOfType,
//                                   distances: homeProvider.listOfDistanceData,
//                                   terrains: homeProvider.listOfTerrains,
//                                 );
//                               }),
//                           const SizedBox(
//                             height: 20,
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               }));
//   }
// }
