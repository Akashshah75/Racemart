import 'package:flutter/material.dart';
import 'package:vertical_tab_bar_view/vertical_tab_bar_view.dart';
import '../../Utils/app_color.dart';
import '../Home/Drawer/zoom_drawer.dart';
import 'adverties_get_touch_page.dart';
import 'adverties_send_your_query_page.dart';

class AdvertiesOnlinePage extends StatelessWidget {
  const AdvertiesOnlinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: const MenuWidget(),
          backgroundColor: whiteColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: blackColor),
          title: const Text(
            'Adverties Online',
            style: TextStyle(
              color: blackColor,
            ),
          ),
          bottom: TabBar(
              labelColor: blackColor,
              indicatorColor: blueColor,
              indicatorWeight: 2,
              tabs: const [
                Tab(text: 'Send your query'),
                Tab(text: 'Drop us a line'),
              ]),
        ),
        body: const VerticalTabBarView(children: [
          AdvertiesSendQueryPage(),
          AdvertiesGetInTouchPage(),
        ]),
      ),
    );
  }
}
