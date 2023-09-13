//App Colors
import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

//AppColors
Color blueColor = HexColor("#034ea1");
Color appRed = HexColor('#ee141f');
Color halfWhite = HexColor("#fafafa");
Color white = HexColor("#ffffff");
Color grey = HexColor("#fcfcfc");
const Color whiteColor = Colors.white;
const Color blackColor = Colors.black;
const Color greyColor = Colors.grey;
const Color redColor = Colors.red;
const Color yellowColor = Colors.yellow;
const Color transparentColor = Colors.transparent;
Color textColor = HexColor('#566985');
//
Color appBg = HexColor("#F0EFF0");
Color active = HexColor("#160707");

//textcolor
var greyTextColor = greyColor.withAlpha(250);
//
var containerColor = greyColor.withOpacity(0.1);
var textColor1 = blackColor.withOpacity(0.2);

var kBagroundColor = blueColor.withOpacity(0.4);
var appBarBagroundColor = halfWhite.withAlpha(1);
var dropDownTextColor = greyColor.withOpacity(0.6);
//
var iconColor = blueColor.withOpacity(0.2);
