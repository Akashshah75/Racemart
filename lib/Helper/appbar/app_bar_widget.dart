import 'package:flutter/material.dart';
import 'package:racemart_app/Pages/Wishlist/wishlist_page.dart';
import '../../Pages/Home/Components/event_names_for_route.dart';
import '../../Pages/Home/Drawer/zoom_drawer.dart';
import '../../Utils/app_color.dart';

PreferredSizeWidget customeAppBar(BuildContext context) {
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
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const WishListPage()));
                },
                icon: const Icon(
                  Icons.favorite_border_sharp,
                  color: blackColor,
                ),
              ),
            ],
          ),
          //
          // Container(
          //   width: 300,
          //   height: 50,
          //   padding: const EdgeInsets.symmetric(horizontal: 12),
          //   child: CustomeTextField(
          //     radius: 10,
          //     hintText: 'Search your product',
          //     controller: TextEditingController(),
          //     icon: Icons.search,
          //   ),
          // ),

          const Padding(
            padding: EdgeInsets.only(left: 8, top: 10),
            child: EventNamesForRoute(),
          ),
        ],
      ),
    ),
  );
}
