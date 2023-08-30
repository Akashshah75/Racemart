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
        MaterialButton(
          onPressed: () {
            provider.cleanTextBoxes();
            homeProvider.cleanDropDownBoxes();
          },
          child: const Text('Clean'),
        )
      ],
    );
//
AppBar appBarOfFindRaceWithLeading(BuildContext context,
        FindARacesProvider provider, var h, HomeProvider homeProvider) =>
    AppBar(
      backgroundColor: appBarBagroundColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: blackColor),
      title: const Text(
        'Find a Race',
        style: TextStyle(color: blackColor),
      ),
      // automaticallyImplyLeading: true,
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back)),
      // leading: const MenuWidget(),
      actions: [
        MaterialButton(
          onPressed: () {
            provider.cleanTextBoxes();
            homeProvider.cleanDropDownBoxes();
          },
          child: const Text('Clean'),
        )
      ],
    );
