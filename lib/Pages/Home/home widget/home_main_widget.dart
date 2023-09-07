import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/advertiesment/advertiesment_provider.dart';
import 'package:racemart_app/Utils/app_color.dart';
import 'package:racemart_app/Utils/constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../Provider/Home providers/home_page_provider.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CarouselWidget()
          advertiesment.horizontalAdvertismentData.isEmpty
              ? const SizedBox()
              : homeProvider.selectedIndex == 0
                  ? const AdvertismentContainer()
                  : const SizedBox(),
          const SizedBox(height: 5),
          homeWidget(homeProvider),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}

class AdvertismentContainer extends StatelessWidget {
  const AdvertismentContainer({
    super.key,
    this.height = 130,
  });
  final double height;

  @override
  Widget build(BuildContext context) {
    return Consumer<AdvertiesmentProvider>(builder: (context, value, child) {
      final homeAdData = value.horizontalAdvertismentData;

      return Column(
        children: [
          CarouselSlider.builder(
            itemCount: homeAdData.length,
            itemBuilder: (context, index, realIndex) {
              final urlImages = homeAdData[index]['image'];
              final url = Uri.parse(homeAdData[index]['url']);
              return InkWell(
                onTap: () {
                  print('radhe krishan');
                  launchUrls(url);
                },
                child: CarouselWidget(urlImages: urlImages),
              );
            },
            options: CarouselOptions(
              viewportFraction: 0.98,
              initialPage: 0,
              height: height,
              autoPlay: true,
              // reverse: true,
              autoPlayInterval: const Duration(seconds: 10),
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                value.changeIndex(index);
              },
            ),
          ),
          //dotindicatior
          const SizedBox(height: 10),
          AnimatedSmoothIndicator(
            activeIndex: value.activeIndex,
            count: homeAdData.length,
            effect: ScrollingDotsEffect(
              activeDotColor: blueColor,
              dotWidth: 7,
              dotHeight: 7,
            ),
          ),
        ],
      );
    });
  }
}

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    super.key,
    required this.urlImages,
  });
  final String urlImages;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: grey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 0.5, color: blackColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          urlImages,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
