import 'package:flutter/material.dart';

import '../../Utils/app_color.dart';
import '../Home/Drawer/zoom_drawer.dart';
import 'components/droup_us_line_page.dart';
import 'components/get_in_touch_page.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: blackColor),
          leading: const MenuWidget(),
          title: const Text(
            'Contact us',
            style: TextStyle(
              color: blackColor,
            ),
          ),
          bottom: TabBar(
              labelColor: blackColor,
              indicatorColor: blueColor,
              indicatorWeight: 2,
              tabs: const [
                Tab(text: 'Get in touch'),
                Tab(text: 'Drop us a line'),
              ]),
        ),
        body: const TabBarView(children: [
          GetInTouchPage(),
          DroupUsLinePage(),
        ]),
      ),
    );
  }
}
