import 'package:flutter/material.dart';

import '../../../../Helper/Widget/text_widget.dart';
import '../../../../Utils/app_size.dart';
import '../../../../Utils/constant.dart';
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
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(12), color: white),
      child: Stack(
        children: [
          //reminging body
          Padding(
            padding: defaultSymetricPeding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Registration date',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: blackColor,
                    letterSpacing: 1.2,
                  ),
                ),
                const Divider(),
                const SizedBox(height: 8),
                data['event_start_date'] != null
                    ? DateTimeContainer(
                        title: 'Start Date',
                        date: data['event_start_date'] == null
                            ? ''
                            : convertDate(data['event_start_date']),
                      )
                    : const SizedBox(),
                // const SizedBox(height: 15),
                // data['event_start_date'] != null
                //     ? DateTimeContainer(
                //         title: 'Start Date',
                //         date: data['event_start_date'] == null
                //             ? ''
                //             : convertDate(data['event_start_date']),
                //       )
                //     : const SizedBox(),
                const SizedBox(height: 15),
                data['event_end_date'] != null
                    ? DateTimeContainer(
                        title: 'End Date',
                        date: data['event_end_date'] == null
                            ? ''
                            : convertDate(data['event_end_date']))
                    : const SizedBox(),
              ],
            ),
          ),
          //button
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              width: 230,
              height: 35,
              decoration: BoxDecoration(
                color: blueColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  bottomRight: Radius.circular(4),
                ),
                // borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(35)),
                child: SizedBox(
                  height: 35,
                  width: 230,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Save your Registration date',
                      style: TextStyle(
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
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
