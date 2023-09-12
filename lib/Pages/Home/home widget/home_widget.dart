import 'package:flutter/material.dart';

import '../../../Provider/Home providers/home_page_provider.dart';
import '../../User interst/user_interest.dart';
import '../Components/eventInCities/event_in_mumbai.dart';
import '../Components/explore_best_cities.dart';
import '../Components/testimonial_list.dart';
import '../Components/the latest listing/the_latest_listing.dart';
import '../Components/upcoming race/upcoming_race_listing_page.dart';
import '../advertisment/advertisment_container.dart';

homeWidget(HomeProvider provider) {
  switch (provider.selectedIndex) {
    case 0:
      return UpcomingRaceListingPage(provider: provider);

    case 1:
      // return UpdatedUserInterrest(provider: provider);
      return UserInterestPage(provider: provider);
    case 2:
      return TheLatestListing(provider: provider);
    case 3:
      return ExploreBestCities(
        provider: provider,
      );
    case 4:
      return EventInCity(
        provider: provider,
      );
    case 5:
      return const TestimonialListOfHome();
    default:
      return Container();
  }
}

///
homePageAdvertiesmentPlacement(HomeProvider provider) {
  switch (provider.selectedIndex) {
    case 0:
      return AdvertismentContainer(homeProvider: provider);

    // case 1:
    //   // return UpdatedUserInterrest(provider: provider);
    //   return UserInterestPage(provider: provider);
    // case 2:
    //   return TheLatestListing(provider: provider);
    // case 3:
    //   return ExploreBestCities(
    //     provider: provider,
    //   );
    // case 4:
    //   return EventInCity(
    //     provider: provider,
    //   );
    // case 5:
    //   return const TestimonialListOfHome();
    default:
      return Container();
  }
}
