import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/advertiesment/advertiesment_provider.dart';

import '../../../Provider/Home providers/home_page_provider.dart';
import '../advertisment/advertisment_container.dart';
import 'home_widget.dart';

class HomeMainWidget extends StatefulWidget {
  const HomeMainWidget({
    super.key,
  });

  @override
  State<HomeMainWidget> createState() => _HomeMainWidgetState();
}

class _HomeMainWidgetState extends State<HomeMainWidget> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);
    final advertiesment =
        Provider.of<AdvertiesmentProvider>(context, listen: true);
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CarouselWidget()
          advertiesment.homePageTopSectionAdvertiesment.isEmpty
              ? const SizedBox()
              : homeProvider.selectedIndex == 0
                  ? AdvertismentContainer(
                      homeProvider: homeProvider,
                      title: CategoryOfBottomNavigation.home)
                  : const SizedBox(),
          const SizedBox(height: 5),
          homeWidget(homeProvider),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
