import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Provider/detail_page_provider.dart';
import '../../../Utils/app_color.dart';

class HorizontalTabContainer extends StatelessWidget {
  const HorizontalTabContainer({
    super.key,
    required this.press,
    required this.name,
    required this.curentIndex,
    required this.selectd,
  });
  final VoidCallback press;
  final String name;
  final int curentIndex;
  final int selectd;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DetailProvider>(context, listen: true);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: provider.selectedIndex == curentIndex
            ? blueColor
            : appBg, // index == 0 ? blueColor : appBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: blackColor.withOpacity(0.2)),
      ),
      child: InkWell(
        onTap: press,
        splashColor: blueColor,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Text(
            name,
            style: TextStyle(
                color: provider.selectedIndex == curentIndex
                    ? white
                    : Colors.black),
          ),
        ),
      ),
    );
  }
}
