import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Utils/constant.dart';
import '../../Helper/Widget/drop_down_btn.dart';
import '../../Helper/Widget/text_button_widget.dart';
import '../../Provider/compare event/compare_event_provider.dart';
import '../../Utils/app_color.dart';
import 'compare_event_page.dart';

class CompareEventSearchScreen extends StatelessWidget {
  const CompareEventSearchScreen({
    super.key,
    required this.width,
  });
  final double width;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CompareEventProvider>(context, listen: true);
    return CompareEventContainer(provider: provider, width: width);
  }
}

class CompareEventContainer extends StatelessWidget {
  const CompareEventContainer({
    super.key,
    required this.provider,
    required this.width,
  });

  final CompareEventProvider provider;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15, top: 20),
              child: Text(
                'First Event',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: blueColor,
                  letterSpacing: 1.2,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            EventDropDownButton(
              hintText: 'Select your First Event',
              choseValue: provider.choseFirstEvent,
              onChanged: (val) {
                // print(val);
                provider.choseFirstEventName(val);
                provider.fetchEventDetail(context, eventId: val, id: 1);
              },
              items: provider.listOfCompareEventNames.map((val) {
                return DropdownMenuItem(
                  value: val['id'].toString(), //val['id'],
                  child: Text(
                    val['title'],
                    style: const TextStyle(color: blackColor),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),
            // second event
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Text(
                'Second Event',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: blueColor,
                  letterSpacing: 1.2,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            EventDropDownButton(
              hintText: 'Select your Second Event',
              choseValue: provider.choseSecondEvent,
              onChanged: (val) {
                // print(val);
                provider.choseSecondEventName(val);
                provider.fetchEventDetail(context, eventId: val, id: 2);
              },
              items: provider.listOfCompareEventNames.map((val) {
                return DropdownMenuItem(
                  value: val['id'].toString(),
                  child: Text(
                    val['title'],
                    style: const TextStyle(color: blackColor),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            //third event
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Text(
                'Third Event',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: blueColor,
                  letterSpacing: 1.2,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            EventDropDownButton(
              hintText: 'Select your third Event',
              choseValue: provider.choseThirdEvent,
              onChanged: (val) {
                // print(val);
                provider.choseThirdEventName(val);
                provider.fetchEventDetail(context, eventId: val, id: 3);
              },
              items: provider.listOfCompareEventNames.map((val) {
                return DropdownMenuItem(
                  value: val['id'].toString(),
                  child: Text(
                    val['title'],
                    style: const TextStyle(color: blackColor),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 25),
            Align(
              alignment: Alignment.center,
              child: TextButtonWidget(
                  text: 'Compare',
                  pres: () {
                    if (provider.choseFirstEvent.isNotEmpty &&
                        provider.choseSecondEvent.isNotEmpty &&
                        provider.choseThirdEvent.isNotEmpty) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ListOfCompareEvents(
                                provider: provider,
                                firstEventData: provider.detailFirstEventData,
                                width: width,
                              )));
                    } else {
                      toastMessage('Plese select all');
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
