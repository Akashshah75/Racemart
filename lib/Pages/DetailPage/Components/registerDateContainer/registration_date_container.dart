import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:racemart_app/Utils/app_color.dart';

import '../../../../Utils/app_size.dart';
import '../../../../Utils/constant.dart';
import 'components/date_time_conatianer.dart';

class RegisterationDateContainer extends StatelessWidget {
  const RegisterationDateContainer({
    super.key,
    this.data,
  });
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    //save event date
    final Event event = Event(
      title: data['title'] ?? 'title',
      location: data['city'] ?? 'location',
      startDate: DateTime.parse(data['event_start_date'] ?? '00-00-0000'),
      endDate: DateTime.parse(data['event_end_date'] ?? '00-00-0000'),
      // description: 'Event description',
      //  DateTime.parse(
      //   convertDate(
      //     data['event_start_date'] ?? '',
      //   ),
      // ),
      // DateTime.parse(
      //   convertDate(
      //     data['event_end_date'] ?? '',
      //   ),
      // ),
      // iosParams: const IOSParams(
      //   reminder: Duration(
      //       /* Ex. hours:1 */), // on iOS, you can set alarm notification after your event.
      //   url:
      //       'https://www.example.com', // on iOS, you can set url to your event.
      // ),
      // androidParams: const AndroidParams(
      //   emailInvites: [], // on Android, you can add invite emails to your event.
      // ),
    );

    //
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
          data['event_start_date'] != null && data['event_end_date'] != null
              ? Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    alignment: Alignment.center,
                    width: 230,
                    height: 35,
                    decoration: BoxDecoration(
                      color: appRed, // blueColor,
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
                          onPressed: () {
                            Add2Calendar.addEvent2Cal(event);
                          },
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
              : const SizedBox()
        ],
      ),
    );
  }
}
