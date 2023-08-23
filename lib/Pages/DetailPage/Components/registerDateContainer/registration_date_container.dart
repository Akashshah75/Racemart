import 'package:flutter/material.dart';
import 'package:racemart_app/Utils/constant.dart';

import '../../../../Helper/Widget/text_widget.dart';
import '../../../../utils/app_color.dart';

class RegisterationDateContainer extends StatelessWidget {
  const RegisterationDateContainer({
    super.key,
    this.data,
  });
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            data['event_start_date'] != null
                ? DateTimeContainer(
                    title: 'Start Date',
                    date: data['event_start_date'] == null
                        ? ''
                        : convertDate(data['event_start_date']),
                  )
                : const SizedBox(),
            const SizedBox(height: 15),
            // data['event_start_date'] != null
            //     ? DateTimeContainer(
            //         title: 'Start Date',
            //         date: data['event_start_date'] == null
            //             ? ''
            //             : convertDate(data['event_start_date']),
            //       )
            //     : const SizedBox(),
            // const SizedBox(height: 10),
            data['event_end_date'] != null
                ? DateTimeContainer(
                    title: 'End Date',
                    date: data['event_end_date'] == null
                        ? ''
                        : convertDate(data['event_end_date']))
                : const SizedBox(),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: Container(
            //     alignment: Alignment.center,
            //     width: 150,
            //     height: 35,
            //     decoration: BoxDecoration(
            //       color: blueColor,
            //       borderRadius: const BorderRadius.only(
            //         topLeft: Radius.circular(35),
            //         bottomRight: Radius.circular(4),
            //       ),
            //       // borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: ClipRRect(
            //       borderRadius:
            //           const BorderRadius.only(topLeft: Radius.circular(35)),
            //       child: SizedBox(
            //         height: 35,
            //         width: 150,
            //         child: TextButton(
            //           onPressed: () {},
            //           child: const Text(
            //             'Register Now',
            //             style: TextStyle(
            //               color: whiteColor,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class DateTimeContainer extends StatelessWidget {
  const DateTimeContainer({
    super.key,
    required this.title,
    required this.date,
  });

  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.calendar_month,
          size: 16,
          color: blackColor.withAlpha(150),
        ),
        const SizedBox(width: 5),
        TextWidget(
          fontSize: 14,
          text: '$title:',
          color: blackColor.withAlpha(150),
        ),
        const SizedBox(width: 10),
        TextWidget(
          fontSize: 14,
          text: date,
          color: blueColor.withAlpha(150),
        ),
      ],
    );
  }
}
