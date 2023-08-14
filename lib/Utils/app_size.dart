//app all sizes
import 'package:flutter/material.dart';

import 'app_color.dart';

double defaultPading = 20;

class AppSize {
  static double? appSceenHeight;
  static double? appScrrenWidth;
  static double appDefaultPading = 15;
  //
  static void appSize(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    appSceenHeight = height;
    appScrrenWidth = width;
    //
    // appDefaultPading = height * 0.02;
  }
}

var spacingHeightMax = const SizedBox(height: 20);
var spacingHeightMedium = const SizedBox(height: 15);
var spacingHeightMin = const SizedBox(height: 5);
var spacingHeightMin1 = const SizedBox(height: 10);
//
var padding = const EdgeInsets.only(left: 20, right: 20);
//
var customeText =
    "Welcome to the MG Vadodara Marathon 2023. On 7th January become a part of history by participating in the 11th Edition of India's Largest Marathon.Vadodara Marathon is a World Marathon Majors Qualifying Race of the Abbott Wanda World Marathon Majors.Vadodara Marathon’s motto of “Sports, Seva, Swachchata” is at the core of all the activities, supporting various social and civic causes. Vadodara Marathon, or VM, offers a platform to local NGOs and Divyang Associations to increase their visibility, raise awareness and funds for their causes.";
var headingText =
    'We are #BackToRun. Eleventh Edition of the Vadodara Marathon.';

void appNav(BuildContext context) {
  Navigator.of(context);
}

//
var boxStyle = BoxDecoration(
  borderRadius: BorderRadius.circular(12),
  color: greyColor,
);

var defaultSymetricPeding =
    const EdgeInsets.symmetric(horizontal: 10, vertical: 10);
var defaultSpaceHeight = const SizedBox(height: 10);

var advString =
    'Advertise on banner ads prominently placed on RaceMart & reach out to your targeted group who regularly visit the site for information on race events and register for events of their choice.';

TextStyle customeTextStyle = const TextStyle(
    fontWeight: FontWeight.w300, color: blackColor, fontSize: 12);

var industrishReportScreen =
    "The road races industry in India emerged in the year 2004 with the launch of the Tata Mumbai Marathon, ( the then Standard Chartered Mumbai Marathon). Before this event, there have been many events that have been held in India but mostly from an athletic perspective. Before 2004, various cities have seen events launched for a few editions before winding up. Most other running events used to be organised by athletic associations catering to the needs of the athletic community.Since 2004 the running industry has been growing exponentially and today runs are conducted in India in almost all small towns of various shapes and sizes. While the industry has been growing there has never been a single point of authentic information about the industry.This report in its first edition seeks to be the most authoritative report, especially with respect to the size and spread of the industry.Download the complete Report Here";
