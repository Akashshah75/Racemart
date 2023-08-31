import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Provider/Home providers/home_page_provider.dart';
import 'home_widget.dart';

class HomeMainWidget extends StatelessWidget {
  const HomeMainWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          homeWidget(homeProvider),
        ],
      ),
    );
  }
}
