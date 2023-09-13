import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:racemart_app/Provider/about%20us/abpout_us_provider.dart';
import 'package:racemart_app/Provider/advertiesment/advertiesment_provider.dart';
import 'package:racemart_app/Provider/bottom%20nav/bottom_nav_type_provider.dart';
import 'package:racemart_app/Provider/notifications/notifications_provider.dart';

import '../../Provider/Home providers/home_page_provider.dart';
import '../../Provider/User interest/user_interest_provider.dart';
import '../../Provider/adverties/adverties_provider.dart';
import '../../Provider/authentication_provider.dart';
import '../../Provider/compare event/compare_event_provider.dart';
import '../../Provider/contact us/contact_us_provider.dart';
import '../../Provider/detail_page_provider.dart';
import '../../Provider/droup_line_provider.dart';
import '../../Provider/find_race_provider.dart';
import '../../Provider/icon_change_provider.dart';
import '../../Provider/profile/profile_provider.dart';
import '../../Provider/report/industries_provider.dart';
import '../../Provider/review a race provider/review_a_race_provider.dart';
import '../../Provider/testimonial/testimonial_provider.dart';
import '../../Provider/wishlist/fav_event_add_wishlist_provider.dart';
import '../../Provider/wishlist/wishlist_provider.dart';

class AppProvider {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (_) => HomeProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => DetailProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => IconChangeProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => FindARacesProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => AdveriesProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => AuthenticationProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => DroupUsLineProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => IndustriesReportProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => ProfileProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => ReviewARaceProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => TestimonialProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => CompareEventProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => WishListProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => FavEventAddWishlist(),
    ),
    ChangeNotifierProvider(
      create: (_) => ContactUsProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => UserInterestProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => BottomnavTypeProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => AboutUsProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => NotificationProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => AdvertiesmentProvider(),
    ),
  ];
}
