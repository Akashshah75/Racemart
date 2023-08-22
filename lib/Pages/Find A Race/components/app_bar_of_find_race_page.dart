import 'package:flutter/material.dart';
import 'package:racemart_app/Provider/Home%20providers/home_page_provider.dart';
import 'package:racemart_app/Provider/find_race_provider.dart';
import '../../../Utils/app_color.dart';
import '../../Home/Drawer/zoom_drawer.dart';

AppBar appBarOfFindRace(BuildContext context, FindARacesProvider provider,
        var h, HomeProvider homeProvider) =>
    AppBar(
      backgroundColor: appBarBagroundColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: blackColor),
      title: const Text(
        'Find a Race',
        style: TextStyle(color: blackColor),
      ),
      leading: const MenuWidget(),
      actions: [
        // provider.searchListData.isNotEmpty
        //     ? IconButton(
        //         onPressed: () {
        //           provider.changePage();
        //         },
        //         icon: const Icon(Icons.filter_list_outlined),
        //       )
        //     :
        MaterialButton(
          onPressed: () {
            provider.cleanTextBoxes();
            homeProvider.cleanDropDownBoxes();
          },
          child: const Text('Clean'),
        )
      ],
    );
