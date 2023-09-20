import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Helper/Widget/custome_textfield.dart';
import '../../../../Helper/Widget/text_button_widget.dart';
import '../../../../Provider/rating/rating_provider.dart';
import '../../../../Utils/app_color.dart';
import 'components/custome_rating_container.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.9,
      child: SingleChildScrollView(
        child:
            Consumer<RatingProvider>(builder: (context, ratingProvider, child) {
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
              const SizedBox(height: 10),
              //users rating
              CustomeRatingContainer(
                title: "User's Overall Ratings",
                onRatingUpdate: (usersRating) {
                  ratingProvider.getUserStarRating(usersRating);
                },
              ),
              const SizedBox(height: 10),
              CustomeRatingContainer(
                title: "Timing Partner Rating",
                onRatingUpdate: (timingPartnerRating) {
                  ratingProvider.getTimingPartnerRating(timingPartnerRating);
                },
              ),
              const SizedBox(height: 10),
              CustomeRatingContainer(
                title: "Event Organizer Rating",
                onRatingUpdate: (eventOranizerRating) {
                  ratingProvider.getEventOrganiserRating(eventOranizerRating);
                },
              ),
              const SizedBox(height: 10),
              CustomeRatingContainer(
                title: "Registration Partner Rating",
                onRatingUpdate: (registrationPartnerRating) {
                  ratingProvider
                      .getRegistrationPartnerRating(registrationPartnerRating);
                },
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    print(ratingProvider.userRating.floor());
                    print(ratingProvider.timingPartnerRating.floor());
                    print(ratingProvider.eventOranizerRating.floor());
                    print(ratingProvider.registrationPartnerRating.floor());
                    print(ratingProvider.ratingComment.text);
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
