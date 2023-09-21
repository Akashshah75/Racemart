import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Utils/constant.dart';

import '../../../../Helper/Widget/custome_textfield.dart';
import '../../../../Helper/Widget/text_button_widget.dart';
import '../../../../Provider/detail_page_provider.dart';
import '../../../../Provider/rating/rating_provider.dart';
import '../../../../Utils/app_color.dart';
import 'components/custome_rating_container.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({
    super.key,
    required this.size,
    this.data,
  });

  final Size size;
  final dynamic data;

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  void initState() {
    final provider = Provider.of<RatingProvider>(context, listen: false);
    provider.rating = {};
    provider.ratingComment.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List partnerRatingData = widget.data['user_rating'];

    return SizedBox(
      height: widget.size.height * 0.9,
      child: SingleChildScrollView(
        child:
            Consumer<RatingProvider>(builder: (context, ratingProvider, child) {
          if (ratingProvider.rating.isEmpty) {
            for (var element in partnerRatingData) {
              ratingProvider.rating[element['partner_type'].toString()] =
                  element['stars'].floorToDouble(); //partner_type
              // print(ratingProvider.rating);
            }
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Icon(
                            Icons.arrow_back,
                            color: blueColor,
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        const SizedBox(width: 20),
                        Text(
                          'Event Review / Rating',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: blueColor,
                          ),
                        ),
                        //
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Divider(),
                  ],
                ),
              ),
              //users rating
              CustomeRatingContainer(
                title: "User's Overall Ratings",
                intialRating: 0,
                onRatingUpdate: (usersRating) {
                  ratingProvider.getUserStarRating(usersRating);
                },
              ),
              Divider(color: appBg, height: 1.2, thickness: 4),
              //list of partner ratings
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: partnerRatingData.length,
                  itemBuilder: (context, index) {
                    final data = partnerRatingData[index];
                    return CustomeRatingContainer(
                      title: data['type'],
                      intialRating: data['stars'],
                      onRatingUpdate: (rate) {
                        ratingProvider.getRatingData(
                            data['partner_type'].toString(), rate.floor());

                        // print("${data['partner_type']}: ${rate.floor()}");
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: MultiLineTextBox(
                  hintText: 'comment',
                  controller: ratingProvider.ratingComment,
                  maxLine: 3,
                  textInputType: TextInputType.text,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextButtonWidget(
                  text: 'Submit',
                  pres: () {
                    final detailProvider =
                        Provider.of<DetailProvider>(context, listen: false);
                    // print(widget.data['id']);
                    // print(ratingProvider.ratingComment.text);
                    // print(ratingProvider.rating);
                    if (ratingProvider.ratingComment.text.isNotEmpty) {
                      ratingProvider
                          .postRating(context, widget.data['id'])
                          .then((_) {
                        detailProvider.fetchEventDetail(
                            context, widget.data['id']);
                      }).then((_) {
                        Navigator.of(context).pop();
                      });
                    } else {
                      toastMessage('Plese enter your comment!');
                    }
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
