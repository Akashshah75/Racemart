import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Utils/constant.dart';

import '../../../Provider/compare event/compare_event_provider.dart';
import '../../../Utils/app_color.dart';
import '../../../Utils/app_size.dart';
import '../../Home/DetailPage/Components/how_to_reac_container.dart';

class ComapreEventContainer1 extends StatelessWidget {
  const ComapreEventContainer1({
    super.key,
    required this.width,
    required this.image,
    this.data,
    required this.eventLenth,
  });

  final double width;
  final String image;
  final dynamic data;
  final int eventLenth;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CompareEventProvider>(context, listen: true);
    List listOfDistances = data['distances'];
    List listOfDeliverables = data['deliverables'];
    List listOfparteners = data['partners'];
    List listOfTerrains = data['terrains'];
    //
    // double columnLength(String keyName, {double h = 50}) {
    //   double length = 0;
    //   if (provider.detailFirstEventData.containsKey(keyName) &&
    //       provider.detailFirstEventData[keyName].length > length) {
    //     length = provider.detailFirstEventData[keyName].length;
    //   }
    //   if (provider.detailSecondEventData.containsKey(keyName) &&
    //       provider.detailSecondEventData[keyName].length > length) {
    //     length = provider.detailSecondEventData[keyName].length;
    //   }
    //   if (provider.detailThirdEventData.containsKey(keyName) &&
    //       provider.detailThirdEventData[keyName].length > length) {
    //     length = provider.detailThirdEventData[keyName].length;
    //   }

    //   return length;
    // }

    // final eventTitleLength = columnLength('title');
    // print(eventTitleLength);

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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    data['poster'],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //title
              SizedBox(
                // height: columnLength('title'),
                //     ? 80
                //     : eventLenth > 50
                //         ? 100
                //         : 50,
                child: Text(
                  data['title'].toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),

              // const SizedBox(height: 10),
              const Divider(),
              //Address
              Text(data['city'] ?? 'Vadodara', style: customeTextStyle),
              //Editions
              const SizedBox(height: 10),
              const Divider(),
              Text(data['edition'].toString(), style: customeTextStyle),
              //city
              const SizedBox(height: 10),
              const Divider(),
              Text(data['address'] ?? 'address', style: customeTextStyle),
              //location type
              const SizedBox(height: 10),
              const Divider(),
              Text(data['type'] ?? 'On-ground', style: customeTextStyle),
              //distancess
              SizedBox(height: listOfDistances.isEmpty ? 0 : 10),
              listOfDistances.isEmpty ? const SizedBox() : const Divider(),
              //
              listOfDistances.isEmpty
                  ? const SizedBox()
                  : SizedBox(
                      height: 30,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                        ),
                        itemCount: listOfDistances.length,
                        itemBuilder: (context, index) {
                          var distances = listOfDistances[index];
                          if (index < 2) {
                            return Text(
                              distances['name'] ?? '',
                              style: customeTextStyle,
                            );
                          }
                          return const Text('more...');
                        },
                      ),
                    ),
              //badges
              SizedBox(height: listOfDeliverables.isEmpty ? 0 : 10),
              listOfDeliverables.isEmpty ? const SizedBox() : const Divider(),
              //
              listOfDeliverables.isEmpty
                  ? const SizedBox()
                  : SizedBox(
                      height: 40,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                        ),
                        itemCount: listOfDeliverables.length,
                        itemBuilder: (context, index) {
                          var distances = listOfDeliverables[index];
                          if (index < 2) {
                            return Text(
                              distances['name'] ?? '',
                              style: customeTextStyle,
                            );
                          }
                          return const Text('more...');
                        },
                      ),
                    ),

              //
              // Text('T-Shirt, Medal, Food, Participation Certificate',
              //     style: customeTextStyle),
              //partners
              SizedBox(height: listOfparteners.isEmpty ? 0 : 10),
              listOfparteners.isEmpty ? const SizedBox() : const Divider(),
              //
              listOfparteners.isEmpty
                  ? const SizedBox()
                  : SizedBox(
                      height: 40,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                        ),
                        itemCount: listOfparteners.length,
                        itemBuilder: (context, index) {
                          var parteners = listOfparteners[index];
                          if (index < 2) {
                            return Text(
                              parteners['title'] ?? '',
                              style: customeTextStyle,
                            );
                          }
                          return const Text('more...');
                        },
                      ),
                    ),
              //Terrains :
              SizedBox(height: listOfTerrains.isEmpty ? 0 : 10),
              listOfTerrains.isEmpty
                  ? const SizedBox()
                  : SizedBox(
                      height: 40,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                        ),
                        itemCount: listOfTerrains.length,
                        itemBuilder: (context, index) {
                          var terrains = listOfTerrains[index];
                          if (index < 2) {
                            return Text(
                              terrains['name'] ?? '',
                              style: customeTextStyle,
                            );
                          }
                          return const Text('more...');
                        },
                      ),
                    ),
              //Event Start
              const SizedBox(height: 10),
              const Divider(),
              Text(convertDate(data['event_start_date']),
                  style: customeTextStyle),
              //end event
              const SizedBox(height: 10),
              const Divider(),
              data['early_end_date'] != null
                  ? Text(convertDate(data['early_end_date']),
                      style: customeTextStyle)
                  : const SizedBox(),
              //avg..rating
              const Divider(),
              Row(
                children: [
                  Text(data['rate']['stars'].toString(),
                      style: customeTextStyle),
                  const SizedBox(width: 2),
                  const Icon(Icons.star, size: 14, color: yellowColor)
                ],
              ),
              //oragnasied
              const SizedBox(height: 10),
              const Divider(),
              Text(
                data['organized_by'] ?? '',
                style: customeTextStyle,
              ),
              //socila
              const SizedBox(height: 10),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SocialMediaIconContainer(
                    icon: Icons.facebook,
                    width: 30,
                    height: 30,
                    iconsize: 18,
                  ),
                  const SocialMediaIconContainer(
                    icon: Icons.mail,
                    width: 30,
                    height: 30,
                    iconsize: 18,
                  ),
                  GestureDetector(
                    onTap: () {
                      // data['socials'][0]['url'];
                    },
                    child: const SocialMediaIconContainer(
                      icon: Icons.g_mobiledata,
                      width: 30,
                      height: 30,
                      iconsize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
