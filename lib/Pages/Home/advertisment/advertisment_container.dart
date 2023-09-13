import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Utils/constant.dart';

import '../../../Provider/Home providers/home_page_provider.dart';
import '../../../Provider/advertiesment/advertiesment_provider.dart';
import '../../../Utils/app_color.dart';

class AdvertismentContainer extends StatelessWidget {
  const AdvertismentContainer({
    super.key,
    this.height = 130,
    required this.homeProvider,
    this.title,
  });
  final double height;
  final HomeProvider homeProvider;
  final CategoryOfBottomNavigation? title;

  @override
  Widget build(BuildContext context) {
    return Consumer<AdvertiesmentProvider>(builder: (context, value, child) {
      final homeAdData = value.changeAdvertisementAsPerPage(title!);
      // final homeAdData = value.homePageTopSectionAdvertiesment;
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
          const SizedBox(height: 10),

          //dotindicatior
          // const SizedBox(height: 10),
          // AnimatedSmoothIndicator(
          //   activeIndex: value.activeIndex,
          //   count: 2,
          //   effect: ScrollingDotsEffect(
          //     activeDotColor: blueColor,
          //     dotWidth: 7,
          //     dotHeight: 7,
          //   ),
          // ),
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
