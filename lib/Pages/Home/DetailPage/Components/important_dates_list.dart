import 'package:flutter/material.dart';
import 'package:racemart_app/Utils/constant.dart';

import '../../../../Helper/Widget/heading_text.dart';
import '../../../../Helper/Widget/text_widget.dart';
import '../../../../Utils/app_color.dart';

class ImporantDatesList extends StatelessWidget {
  const ImporantDatesList({
    super.key,
    this.data,
  });
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    //  data['event_start_date']
    //  data['event_end_date']
    //  data['registration_start']
    //  data['registration_end']
    //    data['early_start']
    //       data['early_end']
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      //
      height: data['event_start_date'] != null &&
              data['event_end_date'] != null &&
              data['registration_end'] != null &&
              data['early_start'] != null &&
              data['early_end'] != null
          ? 260
          : data['event_start_date'] != null &&
                  data['event_end_date'] != null &&
                  data['registration_start'] != null &&
                  data['registration_end'] != null &&
                  data['early_start'] != null &&
                  data['early_end'] != null
              ? 290
              : data['event_start_date'] != null &&
                      data['event_end_date'] != null &&
                      data['registration_end'] != null
                  ? 175
                  : 250,
      //         : data['event_start_date'] != null &&
      //                 data['event_end_date'] != null &&
      //                 data['registration_end'] != null &&
      //                 data['early_start'] != null &&
      //                 data['early_end'] != null
      //             ? 290
      //             : 280,

      //
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeadingText(
            text: 'Important Dates',
            fontSize: 16,
            color: blackColor,
          ),
          const Divider(),
          Expanded(
            child: Container(
              color: whiteColor,
              child: Column(
                children: [
                  data['event_start_date'] != null
                      ? ImportantDateContainer(
                          title: 'Event start date :',
                          text: convertDate(data[
                              'event_start_date']) // data['event_start_date'],
                          )
                      : const SizedBox(),
                  data['event_end_date'] != null
                      ? ImportantDateContainer(
                          title: 'Event end date :',
                          text: convertDate(
                              data['event_end_date']) //data['event_end_date'],
                          )
                      : const SizedBox(),
                  data['registration_start'] != null
                      ? ImportantDateContainer(
                          title: 'Registration start :',
                          text: convertDate(data[
                              'registration_start']), //data['registration_start'],
                        )
                      : const SizedBox(),
                  data['registration_end'] != null
                      ? ImportantDateContainer(
                          title: 'Registration end :',
                          text: convertDate(data[
                              'registration_end']) //data['registration_end'],
                          )
                      : const SizedBox(),
                  data['early_start'] != null
                      ? ImportantDateContainer(
                          title: 'Early start :',
                          text: convertDate(data['early_start']),
                        )
                      : const SizedBox(),
                  data['early_end'] != null
                      ? ImportantDateContainer(
                          title: 'Early end :',
                          text: convertDate(data['early_end']),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImportantDateContainer extends StatelessWidget {
  const ImportantDateContainer({
    super.key,
    required this.title,
    required this.text,
  });
  final String title, text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            text: title,
            fontSize: 15,
            color: blackColor.withOpacity(0.7),
            letterSpacing: 0,
          ),
          TextWidget(
            text: text,
            color: greyColor.withOpacity(0.9),
          ),
        ],
      ),
    );
  }
}
