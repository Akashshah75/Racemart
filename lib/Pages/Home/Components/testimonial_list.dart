import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/testimonial/testimonial_provider.dart';

import '../../../Utils/app_asset.dart';
import '../../../Utils/app_color.dart';

class TestimonialListOfHome extends StatefulWidget {
  const TestimonialListOfHome({
    super.key,
    this.data,
  });
  final dynamic data;

  @override
  State<TestimonialListOfHome> createState() => _TestimonialListOfHomeState();
}

class _TestimonialListOfHomeState extends State<TestimonialListOfHome> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final provider = Provider.of<TestimonialProvider>(context, listen: false);
      provider.testimonialData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    print(size * 0.7);
    final provider = Provider.of<TestimonialProvider>(context, listen: true);
    return provider.testimonialList.isEmpty
        ? Center(child: Image.asset(noDataFound))
        : SizedBox(
            height: size * 0.7,
            child: ListView.builder(
              itemCount: provider.testimonialList.length,
              itemBuilder: (context, index) {
                var dataOfEvent = provider.testimonialList[index];
                return TestimonialListOfContainer(
                  data: dataOfEvent,
                );
              },
            ),
          );
  }
}

class TestimonialListOfContainer extends StatelessWidget {
  const TestimonialListOfContainer({super.key, this.data});
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: appBg),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  color: whiteColor,
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image(
                    fit: BoxFit.cover,
                    color: blueColor,
                    image: const AssetImage(noImageProfile),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              //
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 7),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: Text(
                      data['name'] ?? 'name',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: redColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  //
                  starWidget(data['stars']),
                ],
              ),
            ],
          ),

          const SizedBox(height: 5),

          ///
          ///
          Text(
            data['title'] ?? 'title',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: blueColor,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            data['comments'] ?? 'comments.',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: blackColor.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  starWidget(int star) {
    switch (star) {
      case 1:
        return Row(
          children: [
            Image.asset(fillStar, width: 20, color: yellowColor),
            const Icon(Icons.star_border_outlined, size: 20),
            const Icon(Icons.star_border_outlined, size: 20),
            const Icon(Icons.star_border_outlined, size: 20),
            const Icon(Icons.star_border_outlined, size: 20),
          ],
        );
      case 2:
        return Row(
          children: [
            Image.asset(fillStar, width: 20, color: yellowColor),
            Image.asset(fillStar, width: 20, color: yellowColor),
            const Icon(Icons.star_border_outlined, size: 20),
            const Icon(Icons.star_border_outlined, size: 20),
            const Icon(Icons.star_border_outlined, size: 20),
          ],
        );
      case 3:
        return Row(
          children: [
            Image.asset(fillStar, width: 20, color: yellowColor),
            Image.asset(fillStar, width: 20, color: yellowColor),
            Image.asset(fillStar, width: 20, color: yellowColor),
            const Icon(Icons.star_border_outlined, size: 20),
            const Icon(Icons.star_border_outlined, size: 20),
          ],
        );
      case 4:
        return Row(
          children: [
            Image.asset(fillStar, width: 20, color: yellowColor),
            Image.asset(fillStar, width: 20, color: yellowColor),
            Image.asset(fillStar, width: 20, color: yellowColor),
            Image.asset(fillStar, width: 20, color: yellowColor),
            const Icon(Icons.star_border_outlined, size: 20),
          ],
        );
      case 5:
        return Row(
          children: [
            Image.asset(fillStar, width: 20, color: yellowColor),
            Image.asset(fillStar, width: 20, color: yellowColor),
            Image.asset(fillStar, width: 20, color: yellowColor),
            Image.asset(fillStar, width: 20, color: yellowColor),
            Image.asset(fillStar, width: 20, color: yellowColor),
          ],
        );
    }
  }
}
