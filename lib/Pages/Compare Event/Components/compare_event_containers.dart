import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/app_color.dart';
import '../../../Utils/app_size.dart';
import '../../../Utils/constant.dart';
import '../../DetailPage/Components/howToRach/how_to_reac_container.dart';

class ComapreEventContainer1 extends StatelessWidget {
  const ComapreEventContainer1({
    super.key,
    required this.width,
    required this.image,
    this.data,
    required this.eventTitleLength,
    required this.eventAddressLength,
  });

  final double width;
  final String image;
  final dynamic data;
  final int eventTitleLength;
  final int eventAddressLength;

  @override
  Widget build(BuildContext context) {
    // print(data['socials']);
    // print(eventAddressLength);
    List listOfDistances = data['distances'];
    List listOfDeliverables = data['deliverables'];
    List listOfparteners = data['partners'];
    List listOfTerrains = data['terrains'];
    List listOfSocialMedia = data['socials'];
    List listOfPrices = data['prices'];
    // print(listOfPrices);
    // var prices;
    // //
    // for (int i = 0; i < listOfPrices.length; i++) {
    //   if (listOfPrices[i]['price'] != null) {
    //     prices = listOfPrices[i]['price'];
    //   }
    // }
    //socila media
    var facebook = false;
    int? facebookIndex;
    var instagram = false;
    int? instagramIndex;
    var youtube = false;
    int? youtubeIndex;
    var twitter = false;
    int? twitterIndex;
    // var google = false;
    for (int i = 0; i < listOfSocialMedia.length; i++) {
      // print(listOfSocialMedia[i]['type']);
      if (listOfSocialMedia[i]['type'] == 'facebook') {
        facebook = true;
        facebookIndex = i;
      }
      if (listOfSocialMedia[i]['type'] == 'instagram') {
        instagram = true;
        instagramIndex = i;
      }
      if (listOfSocialMedia[i]['type'] == 'youtube') {
        youtube = true;
        youtubeIndex = i;
      }
      if (listOfSocialMedia[i]['type'] == 'twitter') {
        twitter = true;
        twitterIndex = i;
      }
    }
    //

    return Container(
      padding: const EdgeInsets.all(5),
      width: width * 0.332,
      decoration: BoxDecoration(
          border: Border.all(
        color: greyColor.withOpacity(0.1),
      )),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //poster
              Container(
                width: double.infinity,
                height: 75,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: data['poster'] == null
                    ? const SizedBox(
                        child: Text('No Poster!!'),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          data['poster'],
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              const SizedBox(height: 10),
              //title
              SizedBox(
                height: eventTitleLength > 50
                    ? 120
                    : eventTitleLength > 30
                        ? 80
                        : 60,
                child: data['title'] == null
                    ? const SizedBox(
                        child: Text('No title!!'),
                      )
                    : Text(
                        data['title'].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
              ),
              const Divider(),
              //Address
              SizedBox(
                height: 20,
                child: data['city'] == null
                    ? const SizedBox(
                        child: Text('No City!!'),
                      )
                    : Text(
                        data['city'] ?? 'Vadodara',
                        style: customeTextStyle,
                      ),
              ),
              //Editions
              const Divider(),
              SizedBox(
                height: 20,
                child: data['edition'] == null
                    ? const Text('No Edition!!')
                    : Text(
                        data['edition'].toString(),
                        style: customeTextStyle,
                      ),
              ),
              //city
              const Divider(),
              SizedBox(
                  height: eventAddressLength > 30
                      ? 70
                      : eventAddressLength > 50
                          ? 80
                          : 60,
                  child: data['address'] == null
                      ? const Text('No Address!!')
                      : Text(
                          data['address'] ?? 'address',
                          style: customeTextStyle,
                        )),
              //location type
              const SizedBox(height: 10),
              const Divider(),
              Text(data['type'] ?? 'No data!!', style: customeTextStyle),
              //distancess
              const Divider(),
              SizedBox(
                height: 40,
                child: listOfDistances.isEmpty
                    ? const SizedBox(
                        child: Text("Don't have distancess!!!"),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Text(
                                listOfDistances[0]['name'] ?? '',
                                style: customeTextStyle,
                              ),
                              const SizedBox(width: 15),
                              listOfDistances.length > 1
                                  ? Text(
                                      listOfDistances[1]['name'] ?? '',
                                      style: customeTextStyle,
                                    )
                                  : const SizedBox(),
                              // const SizedBox(width: 8),
                              // listOfDistances.length > 2
                              //     ? Text(
                              //         listOfDistances[2]['name'] ?? '',
                              //         style: customeTextStyle,
                              //       )
                              //     : const SizedBox(),
                            ],
                          ),
                          const SizedBox(height: 2),
                          listOfDistances.length > 2
                              ? Text(
                                  'more..',
                                  style: customeTextStyle,
                                )
                              : const SizedBox(),
                        ],
                      ),
              ),
              const Divider(),
              SizedBox(
                height: 40,
                child: listOfPrices.isNotEmpty
                    ? Text(
                        "${listOfPrices[0]['price']} \u20B9") //unicode of rupay \u20B9
                    : const SizedBox(
                        child: Text('No price specify!'),
                      ),
              ),
              const Divider(),
              // deliverables
              SizedBox(
                height: 45,
                child: listOfDeliverables.isEmpty
                    ? const SizedBox(
                        child: Text("Don't have deliverables!!!"),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                listOfDeliverables[0]['image'],
                                width: 20,
                              ),
                              listOfDeliverables.length > 1
                                  ? Image.network(
                                      listOfDeliverables[1]['image'],
                                      width: 20,
                                    )
                                  : const SizedBox(),
                              listOfDeliverables.length > 2
                                  ? Image.network(
                                      listOfDeliverables[2]['image'],
                                      width: 20,
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          const SizedBox(height: 3),
                          listOfDeliverables.length > 3
                              ? Text(
                                  'more..',
                                  style: customeTextStyle,
                                )
                              : const SizedBox(),
                        ],
                      ),
              ),
              // //partners
              const Divider(),
              SizedBox(
                  height: 80,
                  child: listOfparteners.isEmpty
                      ? const SizedBox(
                          child: Text("Don't have Parteners !!"),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              listOfparteners[0]['title'] ?? '',
                              style: customeTextStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            listOfparteners.length > 1
                                ? Text(
                                    listOfparteners[1]['title'] ?? '',
                                    style: customeTextStyle,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : const SizedBox(),
                            const SizedBox(height: 4),
                            listOfparteners.length > 2
                                ? Text(
                                    'more..',
                                    style: customeTextStyle,
                                  )
                                : const SizedBox(),
                          ],
                        )),
              // //Terrains :
              const Divider(),
              SizedBox(
                  height: 50,
                  child: listOfTerrains.isEmpty
                      ? const SizedBox(
                          child: Text("Don't have Terrains Data!!"),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              listOfTerrains[0]['name'] ?? '',
                              style: customeTextStyle,
                            ),
                            // const SizedBox(height: 4),
                            // listOfTerrains.length > 1
                            //     ? Text(
                            //         listOfTerrains[1]['name'] ?? '',
                            //         style: customeTextStyle,
                            //       )
                            //     : const SizedBox(),
                            const SizedBox(height: 4),
                            listOfTerrains.length > 1
                                ? Text(
                                    'more..',
                                    style: customeTextStyle,
                                  )
                                : const SizedBox(),
                          ],
                        )),
              //Event Start
              const Divider(),
              SizedBox(
                height: 40,
                child: data['event_start_date'] != null
                    ? Text(
                        convertDate(data['event_start_date']),
                        style: customeTextStyle,
                      )
                    : const SizedBox(
                        child: Text('No Start date specify!!'),
                      ),
              ),
              // //end event
              const Divider(),
              SizedBox(
                height: 40,
                child: data['early_end_date'] != null
                    ? Text(convertDate(data['early_end_date']),
                        style: customeTextStyle)
                    : const SizedBox(
                        child: Text('No end date specify!!'),
                      ),
              ),
              //avg..rating
              const Divider(),
              SizedBox(
                height: 30,
                child: Row(
                  children: [
                    Text(
                      data['rate']['stars'].toString(),
                      style: customeTextStyle,
                    ),
                    const SizedBox(width: 2),
                    const Icon(Icons.star, size: 14, color: yellowColor)
                  ],
                ),
              ),
              //oragnasied
              const Divider(),
              SizedBox(
                height: 40,
                child:
                    data['organized_by'] == '' || data['organized_by'] == null
                        ? const SizedBox(
                            child: Text('No Data!!'),
                          )
                        : Text(
                            data['organized_by'] ?? '',
                            style: customeTextStyle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
              ),
              // //socila
              const Divider(),
              SizedBox(
                height: 40,
                child: listOfSocialMedia.isEmpty
                    ? const SizedBox(
                        child: Text("No sharing available!!"),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          facebook
                              ? InkWell(
                                  onTap: () {
                                    final facebookUrl = Uri.parse(
                                        listOfSocialMedia[facebookIndex!]
                                            ['url']);
                                    launchInBrowser(facebookUrl);
                                  },
                                  child: const SocialMediaIconContainer(
                                    icon: FontAwesomeIcons.facebook,
                                    width: 30,
                                    height: 30,
                                    iconsize: 18,
                                  ),
                                )
                              : const SizedBox(),
                          instagram
                              ? InkWell(
                                  onTap: () {
                                    final instagramUrl = Uri.parse(
                                        listOfSocialMedia[instagramIndex!]
                                            ['url']);
                                    launchInBrowser(instagramUrl);
                                  },
                                  child: const SocialMediaIconContainer(
                                    icon: FontAwesomeIcons.instagram,
                                    width: 30,
                                    height: 30,
                                    iconsize: 18,
                                  ),
                                )
                              : const SizedBox(),
                          //   youtube
                          youtube
                              ? GestureDetector(
                                  onTap: () {
                                    final youtubeUrl = Uri.parse(
                                        listOfSocialMedia[youtubeIndex!]
                                            ['url']);
                                    launchInBrowser(youtubeUrl);
                                  },
                                  child: const SocialMediaIconContainer(
                                    icon: FontAwesomeIcons.youtube,
                                    width: 30,
                                    height: 30,
                                    iconsize: 18,
                                  ),
                                )
                              : const SizedBox(),
                          //twitter
                          twitter
                              ? GestureDetector(
                                  onTap: () {
                                    final twitterUrl = Uri.parse(
                                        listOfSocialMedia[twitterIndex!]
                                            ['url']);
                                    launchInBrowser(twitterUrl);
                                  },
                                  child: const SocialMediaIconContainer(
                                    icon: FontAwesomeIcons.twitter,
                                    width: 30,
                                    height: 30,
                                    iconsize: 18,
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
