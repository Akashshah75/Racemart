import 'package:flutter/material.dart';
import 'package:racemart_app/Pages/User%20interst/search%20userinterest%20page/search_user_interest.dart';
import 'package:racemart_app/Provider/Home%20providers/home_page_provider.dart';

import '../../../Utils/app_color.dart';
import '../user_interest.dart';

class UpdatedUserInterrest extends StatefulWidget {
  const UpdatedUserInterrest({super.key, required this.provider});
  final HomeProvider provider;

  @override
  State<UpdatedUserInterrest> createState() => _UpdatedUserInterrestState();
}

class _UpdatedUserInterrestState extends State<UpdatedUserInterrest> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            enableDrag: false,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            builder: (context) => const SearchUserInterestPage(),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: appBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Find user interest data'),
                Icon(Icons.search),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 10),
      Center(child: UserInterestPage(provider: widget.provider)),
      const SizedBox(height: 10),
    ]);
  }
}
