import 'package:flutter/material.dart';
import 'package:racemart_app/Pages/DetailPage/Components/distancesAndPartners.dart/components/partener_container_list.dart';
import 'package:racemart_app/Pages/DetailPage/Components/priceAndLocation/components/price_listing_container.dart';
import 'package:racemart_app/Pages/DetailPage/Components/dateAndDescription/components/registration_container.dart';
import 'package:racemart_app/Pages/DetailPage/Components/terains_container_list.dart';

import '../../../Utils/app_size.dart';
import 'dateAndDescription/components/discription_container.dart';
import 'distancesAndPartners.dart/components/distance_container_list.dart';
import 'how_to_reac_container.dart';
import 'important_dates_list.dart';

class TopContainer extends StatelessWidget {
  const TopContainer({super.key, this.data});
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          spacingHeightMedium,
          RegistrationContainer(data: data),
          spacingHeightMedium,
          DescriptionContainer(data: data),
          spacingHeightMedium,
          DistanceContainerList(data: data),
          spacingHeightMedium,
          PartenerContainerList(data: data),
          spacingHeightMedium,
          PriceListingContainer(data: data),
          spacingHeightMedium,
          HowToREachContainer(data: data),
          spacingHeightMedium,
          ImporantDatesList(data: data),
          spacingHeightMedium,
          TerrainsContainerList(data: data),
        ],
      ),
    );
  }
}
