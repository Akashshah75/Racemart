import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/Home%20providers/home_page_provider.dart';
import 'package:racemart_app/Utils/constant.dart';
import '../../Helper/Widget/custome_textfield.dart';
import '../../Helper/Widget/text_button_widget.dart';
import '../../Provider/find_race_provider.dart';
import '../../Utils/app_color.dart';
import 'components/app_bar_of_find_race_page.dart';
import '../../Helper/Widget/drop_down_btn.dart';

class FindARacePage extends StatelessWidget {
  const FindARacePage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    final findProvider = Provider.of<FindARacesProvider>(context, listen: true);
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);
    //
    return WillPopScope(
      onWillPop: () async {
        final diffrence = DateTime.now().difference(timeBackPressed);
        final isExitWarning = diffrence >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        return exitTheAppMethod(isExitWarning);
      },
      child: Scaffold(
        backgroundColor: appBg,
        appBar: appBarOfFindRace(context, findProvider, h, homeProvider),
        body: SingleChildScrollView(
          child: Container(
            padding: findProvider.searchListData.isNotEmpty
                ? const EdgeInsets.symmetric(vertical: 15)
                : EdgeInsets.symmetric(horizontal: w * 0.023),
            child: FiledForSearchEventPage(
                h: h, findProvider: findProvider, homeProvider: homeProvider),
          ),
        ),
      ),
    );
  }
}

class FiledForSearchEventPage extends StatelessWidget {
  const FiledForSearchEventPage({
    super.key,
    required this.h,
    required this.findProvider,
    required this.homeProvider,
  });

  final double h;
  final FindARacesProvider findProvider;
  final HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: h * 0.025),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomeTextField(
            hintText: 'What are you looking for?',
            icon: Icons.bookmark_outline,
            textInputType: TextInputType.name,
            controller: findProvider.lookingFor,
          ),
        ),
        SizedBox(height: h * 0.025),
        EventDropDownButton(
          hintText: 'All Type',
          choseValue: homeProvider.choseAllType,
          onChanged: (val) {
            homeProvider.changeAllType(val);
          },
          items: homeProvider.listOfAllTypeData.map((val) {
            return DropdownMenuItem(
              value: val['id'].toString(),
              child: Text(val['category']),
            );
          }).toList(),
        ),
        SizedBox(height: h * 0.025),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomeTextField(
            readOnly: true,
            hintText: 'Start date',
            icon: Icons.calendar_month,
            controller: findProvider.startDate,
            pres: () async {
              //
              findProvider.addDateTIme(context);
            },
          ),
        ),
        SizedBox(height: h * 0.025),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomeTextField(
              readOnly: true,
              hintText: 'End date',
              icon: Icons.calendar_month,
              controller: findProvider.endDate,
              pres: () {
                findProvider.addDateTimeForEndTime(context);
              }),
        ),
        SizedBox(height: h * 0.025),
        EventDropDownButton(
          hintText: 'All cities',
          choseValue: homeProvider.choseCity,
          onChanged: (val) {
            homeProvider.changeDropDownVal(val);
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
          intialValue: homeProvider.listOfDistanceData,
          onConfirm: (val) {
            homeProvider.listOfDistanceData.clear();
            homeProvider.changeDistance(val);
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
          intialValue: homeProvider.listOfBadgeData,
          onConfirm: (val) {
            homeProvider.listOfBadgeData.clear();
            homeProvider.changeBadge(val);
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
          intialValue: homeProvider.listOfPartnersData,
          onConfirm: (val) {
            homeProvider.listOfPartnersData.clear();
            homeProvider.changePartners(val);
          },
        ),
        SizedBox(height: h * 0.025),
        // CustomeDropDownButton(
        //   onChanged: (val) {},
        //   dropDownList: const [],
        //   hintText: 'Sort by',
        //   choseValue: '',
        // ),
        // SizedBox(height: h * 0.025),
        TextButtonWidget(
            isLoading: findProvider.isLoading,
            text: 'Search',
            pres: () {
              findProvider.searchEvent(
                context,
                category: homeProvider.choseAllType,
                city: homeProvider.choseCity,
                distance: homeProvider.listOfDistanceData,
                badge: homeProvider.listOfBadgeData,
                partner: homeProvider.listOfPartnersData,
              );
            }),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}

class CustomeMultiSelectDropDown extends StatelessWidget {
  const CustomeMultiSelectDropDown({
    super.key,
    required this.btnText,
    required this.dialogHintText,
    required this.intialValue,
    required this.onConfirm,
    required this.items,
  });

  final String btnText, dialogHintText;
  final List<MultiSelectItem<dynamic>> items;
  final List intialValue;
  final void Function(List<dynamic>) onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: MultiSelectDialogField(
        searchable: true,
        chipDisplay: MultiSelectChipDisplay(
          chipColor: white,
          textStyle: const TextStyle(color: blackColor),
        ),
        buttonText: Text(btnText, style: TextStyle(color: dropDownTextColor)),
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(color: blueColor.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(12),
        ),
        dialogHeight: 400,
        title: Text(dialogHintText),
        selectedColor: blackColor,
        items: items,
        initialValue: intialValue,
        onConfirm: onConfirm,
        buttonIcon: const Icon(Icons.arrow_drop_down),
        checkColor: white,
      ),
    );
  }
}

class FindRacePage extends StatelessWidget {
  const FindRacePage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    final findProvider = Provider.of<FindARacesProvider>(context, listen: true);
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);
    //
    return WillPopScope(
      onWillPop: () async {
        final diffrence = DateTime.now().difference(timeBackPressed);
        final isExitWarning = diffrence >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        return exitTheAppMethod(isExitWarning);
      },
      child: Scaffold(
        backgroundColor: appBg,
        appBar:
            appBarOfFindRaceWithLeading(context, findProvider, h, homeProvider),
        body: SingleChildScrollView(
          child: Container(
            padding: findProvider.searchListData.isNotEmpty
                ? const EdgeInsets.symmetric(vertical: 15)
                : EdgeInsets.symmetric(horizontal: w * 0.023),
            child: FiledForSearchEventPage(
                h: h, findProvider: findProvider, homeProvider: homeProvider),
          ),
        ),
      ),
    );
  }
}

// class FiledForSearchEventPage extends StatelessWidget {
//   const FiledForSearchEventPage({
//     super.key,
//     required this.h,
//     required this.findProvider,
//     required this.homeProvider,
//   });

//   final double h;
//   final FindARacesProvider findProvider;
//   final HomeProvider homeProvider;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(height: h * 0.025),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: CustomeTextField(
//             hintText: 'What are you looking for?',
//             icon: Icons.bookmark_outline,
//             textInputType: TextInputType.name,
//             controller: findProvider.lookingFor,
//           ),
//         ),
//         SizedBox(height: h * 0.025),
//         EventDropDownButton(
//           hintText: 'All Type',
//           choseValue: homeProvider.choseAllType,
//           onChanged: (val) {
//             homeProvider.changeAllType(val);
//           },
//           items: homeProvider.listOfAllTypeData.map((val) {
//             return DropdownMenuItem(
//               value: val['id'].toString(),
//               child: Text(val['category']),
//             );
//           }).toList(),
//         ),
//         SizedBox(height: h * 0.025),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: CustomeTextField(
//             readOnly: true,
//             hintText: 'Start date',
//             icon: Icons.calendar_month,
//             controller: findProvider.startDate,
//             pres: () async {
//               //
//               findProvider.addDateTIme(context);
//             },
//           ),
//         ),
//         SizedBox(height: h * 0.025),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: CustomeTextField(
//               readOnly: true,
//               hintText: 'End date',
//               icon: Icons.calendar_month,
//               controller: findProvider.endDate,
//               pres: () {
//                 findProvider.addDateTimeForEndTime(context);
//               }),
//         ),
//         SizedBox(height: h * 0.025),
//         EventDropDownButton(
//           hintText: 'All cities',
//           choseValue: homeProvider.choseCity,
//           onChanged: (val) {
//             homeProvider.changeDropDownVal(val);
//           },
//           items: homeProvider.listOfCitiesNames.map((val) {
//             return DropdownMenuItem(
//               value: val['id'].toString(),
//               child: Text(val['name']),
//             );
//           }).toList(),
//         ),
//         SizedBox(height: h * 0.025),
//         //distances
//         CustomeMultiSelectDropDown(
//           btnText: 'Select distance',
//           dialogHintText: "Select distances",
//           items: homeProvider.listOfDetancesNames.map((val) {
//             return MultiSelectItem(val['id'], val['name']);
//           }).toList(),
//           intialValue: homeProvider.listOfDistanceData,
//           onConfirm: (val) {
//             homeProvider.listOfDistanceData.clear();
//             homeProvider.changeDistance(val);
//           },
//         ),
//         //badge
//         SizedBox(height: h * 0.025),
//         CustomeMultiSelectDropDown(
//           btnText: 'Select Badges',
//           dialogHintText: "Select Badges",
//           items: homeProvider.listOfBadgeNames.map((val) {
//             return MultiSelectItem(val['id'], val['title']);
//           }).toList(),
//           intialValue: homeProvider.listOfBadgeData,
//           onConfirm: (val) {
//             homeProvider.listOfBadgeData.clear();
//             homeProvider.changeBadge(val);
//           },
//         ),
//         //partners
//         SizedBox(height: h * 0.025),
//         CustomeMultiSelectDropDown(
//           btnText: 'Select Partners',
//           dialogHintText: "Select Partners",
//           items: homeProvider.listOfPartnersNames.map((val) {
//             return MultiSelectItem(val['id'], val['title']);
//           }).toList(),
//           intialValue: homeProvider.listOfPartnersData,
//           onConfirm: (val) {
//             homeProvider.listOfPartnersData.clear();
//             homeProvider.changePartners(val);
//           },
//         ),
//         SizedBox(height: h * 0.025),
//         // CustomeDropDownButton(
//         //   onChanged: (val) {},
//         //   dropDownList: const [],
//         //   hintText: 'Sort by',
//         //   choseValue: '',
//         // ),
//         // SizedBox(height: h * 0.025),
//         TextButtonWidget(
//             isLoading: findProvider.isLoading,
//             text: 'Search',
//             pres: () {
//               findProvider.searchEvent(context,
//                   category: homeProvider.choseAllType,
//                   city: homeProvider.choseCity,
//                   distance: homeProvider.listOfDistanceData,
//                   badge: homeProvider.listOfBadgeData,
//                   partner: homeProvider.listOfPartnersData,
//                   findProvider: findProvider);
//             }),
//         const SizedBox(
//           height: 20,
//         )
//       ],
//     );
//   }
// }

// class CustomeMultiSelectDropDown extends StatelessWidget {
  // const CustomeMultiSelectDropDown({
  //   super.key,
  //   required this.btnText,
  //   required this.dialogHintText,
  //   required this.intialValue,
  //   required this.onConfirm,
  //   required this.items,
  // });

  // final String btnText, dialogHintText;
  // final List<MultiSelectItem<dynamic>> items;
  // final List intialValue;
  // final void Function(List<dynamic>) onConfirm;

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 10),
  //     child: MultiSelectDialogField(
  //       chipDisplay: MultiSelectChipDisplay(
  //         chipColor: white,
  //         textStyle: const TextStyle(color: blackColor),
  //       ),
  //       buttonText: Text(btnText, style: TextStyle(color: dropDownTextColor)),
  //       decoration: BoxDecoration(
  //         color: whiteColor,
  //         border: Border.all(color: blueColor.withOpacity(0.4)),
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       dialogHeight: 200,
  //       title: Text(dialogHintText),
  //       selectedColor: blackColor,
  //       items: items,
  //       initialValue: intialValue,
  //       onConfirm: onConfirm,
  //       buttonIcon: const Icon(Icons.arrow_drop_down),
  //       checkColor: white,
  //     ),
  //   );
  // }
// }
