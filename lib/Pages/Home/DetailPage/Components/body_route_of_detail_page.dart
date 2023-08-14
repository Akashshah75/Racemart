import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Provider/detail_page_provider.dart';
import '../../../../Utils/app_color.dart';

class BodyRouteOfDetailPage extends StatefulWidget {
  const BodyRouteOfDetailPage({
    super.key,
  });
  @override
  State<BodyRouteOfDetailPage> createState() => _BodyRouteOfDetailPageState();
}

class _BodyRouteOfDetailPageState extends State<BodyRouteOfDetailPage> {
//

  List<String> detailPageRouteNames = [
    'Top',
    // 'Distances',
    // 'Partners',
    // 'Prices',
    // 'How to reach',
    // 'Important Dates',
    // 'Terrains',
    'Deliverables',
    'Gallery',
    'Similar Listings'
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DetailProvider>(context, listen: true);
    return SizedBox(
      height: 30,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: detailPageRouteNames.length,
          itemBuilder: (context, index) {
            return buildNameRouteContainer(index, provider);
          }),
    );
  }

  //
  Widget buildNameRouteContainer(int index, DetailProvider provider) {
    return GestureDetector(
      onTap: () {
        provider.changeIndex(index);
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 120,
        height: 20,
        decoration: BoxDecoration(
          color: provider.selectedIndex == index ? blueColor : white,
          border: Border.all(
            color: provider.selectedIndex == index
                ? whiteColor
                : greyColor.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          detailPageRouteNames[index],
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color:
                provider.selectedIndex == index ? whiteColor : Colors.black54,
          ),
        ),
      ),
    );
  }
}
