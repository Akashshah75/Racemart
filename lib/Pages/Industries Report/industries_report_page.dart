import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Helper/Widget/custome_textfield.dart';
import 'package:racemart_app/Helper/Widget/text_button_widget.dart';
import 'package:racemart_app/Utils/app_color.dart';

import '../../Helper/Widget/heading_text.dart';
import '../../Provider/report/industries_provider.dart';

class IndustriesReportDetailPage extends StatefulWidget {
  const IndustriesReportDetailPage({super.key, required this.id});
  final int id;

  @override
  State<IndustriesReportDetailPage> createState() =>
      _IndustriesReportDetailPageState();
}

class _IndustriesReportDetailPageState
    extends State<IndustriesReportDetailPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final controller =
          Provider.of<IndustriesReportProvider>(context, listen: false);
      controller.fetchShowReportData(context, widget.id);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller =
        Provider.of<IndustriesReportProvider>(context, listen: true);
    final data = controller.showReportData;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        iconTheme: const IconThemeData(color: blackColor),
        title: const Text(
          'Industry Report',
          style: TextStyle(color: blackColor),
        ),
      ),
      body: controller.isLoadingForDetail
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HeadingText(
                      text: data['title'] ?? '',
                      color: blueColor,
                      fontSize: 18,
                    ),
                    const SizedBox(height: 20),
                    HtmlWidget(data['description'] ?? '',
                        onTapUrl: (url) async {
                      print(data['description']);
                      print("Taped:$url");
                      return true;
                    }),

                    // Text(
                    //   industrishReportScreen,
                    //   style: const TextStyle(
                    //     fontSize: 14,
                    //     letterSpacing: 0.9,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    CustomeTextField(
                      hintText: 'First name',
                      controller: controller.firstName,
                      textInputType: TextInputType.name,
                    ),
                    const SizedBox(height: 10),
                    CustomeTextField(
                      hintText: 'Last name',
                      controller: controller.lastName,
                      textInputType: TextInputType.name,
                    ),
                    const SizedBox(height: 10),
                    CustomeTextField(
                      hintText: 'Mobile no',
                      textInputType: TextInputType.number,
                      icon: Icons.phone_android,
                      controller: controller.mobileNo,
                    ),
                    const SizedBox(height: 10),
                    CustomeTextField(
                      hintText: 'Email',
                      icon: Icons.mail,
                      textInputType: TextInputType.emailAddress,
                      controller: controller.email,
                    ),
                    const SizedBox(height: 10),
                    controller.downloadProgress != null
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : TextButtonWidget(
                            text: 'Download',
                            pres: () {
                              controller.downloadReport(context, data['id']);
                            })
                  ],
                ),
              ),
            ),
    );
  }
}


//  (url) async {
//                         // ignore: deprecated_member_use
//                         if (await canLaunch(url)) {
//                           await launch(
//                             url,
//                           );
//                         } else {
//                           throw 'Could not launch $url';
//                         }
//                         return true;
//                       },