import 'package:flutter/material.dart';

import '../how_to_reac_container.dart';
import 'components/price_listing_container.dart';

class PriceAndLocation extends StatelessWidget {
  const PriceAndLocation({super.key, this.data});
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        PriceListingContainer(data: data),
        const SizedBox(height: 20),
        HowToREachContainer(data: data),
      ],
    );
  }
}
